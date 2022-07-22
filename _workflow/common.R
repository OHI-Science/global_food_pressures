### Script loading paths, data, info, functions, and packages commonly used 

## Libraries
library(here)
library(tidyverse)

## Set the aurora and neptune data_edit share based on operating system
dir_aurora        <- c('Windows' = '//aurora.nceas.ucsb.edu/food-systems/Food_footprint/',
                       'Darwin'  = '/Volumes/food-systems/Food_footprint/',    ### connect (cmd-K) to smb://aurora/ohi
                       'Linux'   = '/home/shares/food-systems/Food_footprint/')[[ Sys.info()[['sysname']] ]]

# warning if aurora directory doesn't exist
if (Sys.info()[['sysname']] != 'Linux' & !file.exists(dir_aurora)){
  warning(sprintf("The aurora directory dir_aurora set in src/R/common.R does not exist. Do you need to mount Aurora: %s?", dir_aurora))
}


## Paths
raw   <- paste0(dir_aurora, "_raw_data/")
prep  <- paste0(dir_aurora,"all_food_systems/dataprep/")
layers <- paste0(dir_aurora,"all_food_systems/datalayers/")


## Load .csv file of food regions and associated naming and numbering conventions
food_rgns <- read_csv(here("_spatial/_output/food_rgns.csv"), col_types = "cdc")
  
  
## Common functions+packages
select <- dplyr::select
summarise <- dplyr::summarise



rgdal::setCPLConfigOption("GDAL_PAM_ENABLED", "FALSE")







