# Read Me ----
# Script for extracting data from HDF files and then tiling rasters together. 
# From: https://stackoverflow.com/questions/36772341/reading-hdf-files-into-r-and-converting-them-to-geotiff-rasters
# and
# https://stackoverflow.com/questions/15876591/merging-multiple-rasters-in-r
# And then modified from "Merge and Reproject Script 29.August_MikeClark.R"
#
# It is not totally portable: need to make sure file names align etc.
#


# Packages -----
library(raster)
library(data.table)
library(tidyverse)
library(rgdal)
library(gdalUtils)
library(purrr)
# library(pryr)
library(doMC)
registerDoMC(cores=4)

# Clean up -----
rm(list=ls())

source(here("_workflow/common.R"))

# Function to tile the rasters together
mosaic_fun <- function(raster_list, year, name){
  file_name = paste(name, "_", year, ".tif", sep = "")
  mosaic_rasters(gdalfile = raster_list, 
                 dst_dataset = file_name)
  
}


# Mosaic them
# map2(raster_list, c(2010:2013), mosaic_fun, 
#      name = "/scratch/williams/OtherFiles/MODIS_LandCover/SecondaryLandClass")


raster_list_all <- unzip("/home/shares/food-systems/Food_footprint/_raw_data/MODIS_NPP_for_Juliette/NPP.zip", list = TRUE) %>% 
  select(Name) %>% 
  filter(str_detect(Name, "IndividualTiles/TIF_"))%>% 
  filter(str_detect(Name, ".tif"))

 # 2010
 raster_list_2010 <- raster_list_all %>%  
   filter(str_detect(Name, "TIF_2010"))
 list_2010 <- raster_list_2010$Name
 
# raster_list_2011 <- raster_list_all %>%  
#   filter(str_detect(Name, "TIF_2011"))
# raster_list_2012 <- raster_list_all %>%  
#   filter(str_detect(Name, "TIF_2012"))
# raster_list_2013 <- raster_list_all %>%  
#   filter(str_detect(Name, "TIF_2013"))
# raster_list_2014 <- raster_list_all %>%  
#   filter(str_detect(Name, "TIF_2014"))

## Mosiac the tiles together
# c(2010:2014)
map2(list_2010, 2010, mosaic_fun, 
     name = paste0(prep, "animal_farm/disturbance/npp_2010_2014_rasters/npp") )

test <- raster(file.path(prep, "animal_farm/disturbance/npp_2010_2014_rasters/npp_2010.tif"))
par(mar=c(1,1,1,1))
plot(test)
summary(test)






# 3) Reproject rasters into Mollweide -----
raster_list <- list.files(path = "/scratch/williams/OtherFiles/MODIS_LandCover/", 
                          pattern = "PrimaryLandClass",
                          include.dirs = FALSE,
                          full.names = TRUE)
raster_list <- raster_list[grep(".tif", raster_list)]
raster_list <- map(raster_list, raster)

# First need to aggregate to 1.5km as raster is crapping out on me
raster_list <- foreach(i = 1:4) %dopar% aggregate(raster_list[[i]], 
                                               fact = 3,
                                               fun = modal)

dummy <- raster("Data/MollweideCountryID_1.5km.tif")
reproj_fun <- function(raster, dummy, new_name, path){
  name <- paste(names(raster), new_name, sep = "_")
  projectRaster(from = raster,
                to = dummy,
                method = "ngb",
                filename = paste(path, name, ".tif", sep = ""))
}
foreach(i = 1:4) %dopar% reproj_fun(raster = raster_list[[i]],
                                    dummy = dummy,
                                    new_name = "Mollweide1500m",
                                    path = "/scratch/williams/OtherFiles/MODIS_LandCover/")

# Combine rasters ----
raster_list <- list.files("/scratch/williams/OtherFiles/MODIS_LandCover",
                          full.names = TRUE, 
                          pattern = "PrimaryLandClass")
raster_list <- raster_list[grep("Mollweide1500m", raster_list)]

raster_list <- map(raster_list, raster)

# I need to know which cells have changed the value of primary land cover
# For these, I'll only use the 2013 value
t1 <- Sys.time()
primary_dt <- map(raster_list, getValues)
primary_dt <- data.table(primary_2010 = primary_dt[[1]],
                         primary_2011 = primary_dt[[2]],
                         primary_2012 = primary_dt[[3]],
                         primary_2013 = primary_dt[[4]])
Sys.time() - t1

primary_check <- primary_dt[, .(c1 = primary_2010 == primary_2011, 
                                c2 = primary_2010 == primary_2012, 
                                c3 = primary_2010 == primary_2013, 
                                c4 = primary_2011 == primary_2012, 
                                c5 = primary_2011 == primary_2013, 
                                c6 = primary_2012 == primary_2013)]

primary_check[, check := c1 + c2 + c3 + c4 + c5 + c6]
primary_check <- primary_check[,check] 
primary_check <- data.table(check = primary_check)
# This is an index of cells to use only 2013 data
primary_check[, use_2013_only := check != 6]
primary_class <- primary_dt[, primary_2013]
primary_class <- data.table(primary_2013 = primary_class)
# This is the primary class to use for all cells
rm(primary_dt)

# Now bring in the percentage data
raster_list <- list.files("/scratch/williams/OtherFiles/MODIS_LandCover",
                          full.names = TRUE, 
                          pattern = "PrimaryLandCover")
raster_list <- raster_list[grep("Mollweide1500m", raster_list)]

raster_list <- map(raster_list, raster)

t1 <- Sys.time()
primary_dt <- map(raster_list, getValues)
primary_dt <- data.table(primary_2010 = primary_dt[[1]],
                         primary_2011 = primary_dt[[2]],
                         primary_2012 = primary_dt[[3]],
                         primary_2013 = primary_dt[[4]])
Sys.time() - t1

# Bind to the check vector
primary_dt[, use_2013_only := primary_check$use_2013_only]

# Add the final value that we want: either the mean, or the 2013 value
primary_dt[, primary_coverage_to_use := primary_2013]
primary_dt[use_2013_only == FALSE, 
           primary_coverage_to_use := mean(c(primary_2010, primary_2011, primary_2012, primary_2013)), 
           by = seq_len(nrow(primary_dt[use_2013_only == FALSE]))]

# Cut down to the relevant columns
primary_dt[, primary_2013 := primary_class$primary_2013]
primary_dt <- primary_dt[,c("primary_2013", "primary_coverage_to_use")]
names(primary_dt) <- c("primary_class", "primary_coverage_perc")

# Repeat for secondary land class
# For secondary land class, I only need the 2013 value: either all years are the same, 
#     or I'll just use 2013
primary_dt <- primary_dt[, secondary_class := getValues(raster("/scratch/williams/OtherFiles/MODIS_LandCover/SecondaryLandClass_2013_Mollweide1500m.tif"))]


# Make rasters out of these -----
dummy <- raster("Data/MollweideCountryID_1.5km.tif")
primary_land_class <- raster(matrix(primary_dt$primary_class, 
                                    ncol = ncol(dummy),
                                    byrow = TRUE))
crs(primary_land_class) <- crs(dummy)
extent(primary_land_class) <- extent(dummy)
names(primary_land_class) <- "MODIS_primary_land_class"
writeRaster(primary_land_class,
            "Data/MODIS_LandCover/MODIS_primary_land_class_2010_2013.tif")  
rm(primary_land_class)

primary_coverage <- raster(matrix(primary_dt$primary_coverage_perc, 
                                    ncol = ncol(dummy),
                                  byrow = TRUE))
crs(primary_coverage) <- crs(dummy)
extent(primary_coverage) <- extent(dummy)
names(primary_coverage) <- "MODIS_primary_class_perc_cover"
writeRaster(primary_coverage,
            "Data/MODIS_LandCover/MODIS_primary_class_perc_cover_2010_2013.tif")  
rm(primary_coverage)

secondary_land_class <- raster(matrix(primary_dt$secondary_class, 
                                    ncol = ncol(dummy),
                                    byrow = TRUE))
crs(secondary_land_class) <- crs(dummy)
extent(secondary_land_class) <- extent(dummy)
names(secondary_land_class) <- "MODIS_secondary_land_class"
writeRaster(secondary_land_class,
            "Data/MODIS_LandCover/MODIS_secondary_land_class_2010_2013.tif")  

