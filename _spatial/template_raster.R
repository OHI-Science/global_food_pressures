library(raster)
library(sp)


## to source:
## source('https://raw.githubusercontent.com/cdkuempel/food_chicken_salmon/master/_spatial/template_raster.R?token=ABLMCDNSCGBY3NWPCDJRISC5JA4JI')


food_raster <- raster(nrows=2160, ncols=4320, xmn=-180, xmx=180, ymn=-90, ymx=90)
food_crs <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"

raster_df <- function(input_raster){ #input_raster=food_raster
  template_rast <- raster(nrows=2160, ncols=4320, xmn=-180, xmx=180, ymn=-90, ymx=90)
  values(template_rast) <- 1:ncell(food_raster)
  template_df <- as.data.frame(template_rast, xy=TRUE)
  names(template_df)[3] <- "cellindex"
  if(ncell(input_raster) == ncell(template_rast)){
    final_rast <- cbind(template_df, as.data.frame(input_raster))
    return(final_rast)
  } else
    stop("Rasters are different sizes")
  
}


fake_raster <- raster(nrows=2160, ncols=4320, xmn=-180, xmx=180, ymn=-89.999, ymx=90)
values(fake_raster) <- 1000
check <- raster_df(fake_raster)


#tmp <- area(food_template_raster)
#plot(tmp)
#sqrt(85.47965) # 9.2 km at equator, 85.5 km2 at equator

cat("template food raster is loaded as object: 'food_raster'")
cat("\n\n")
cat("coordinate reference system is loaded as object: 'food_crs'")