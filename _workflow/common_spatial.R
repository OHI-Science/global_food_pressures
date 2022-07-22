## Script loading data, info, functions, and packages commonly used in spatial work

## Libraries
library(raster)
library(rgdal)

## Projection System and extents
food_crs <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
food_raster <- raster(nrows=2160, ncols=4320, xmn=-180, xmx=180, ymn=-90, ymx=90)

## Region data

# loads the food region .tif file
    food_rgns_tif <- raster::raster(file.path(prep, "spatial/food_rgns.tif"))
    
# loads the food region .csv file
    food_rgns_xy <- read_csv(file.path(prep, "spatial/food_rgns_xy.csv"), col_type = "ddnncc")

# loads the unique food regions and associated naming and numbering conventions commonly seen/used
    food_rgns <- read_csv(here("_spatial/_output/food_rgns.csv"))    

    


 
