raster_crs <- function(input){
  
  food_raster <- raster(nrows=2160, ncols=4320, xmn=-180, xmx=180, ymn=-90, ymx=90)
  
  # convert forage fish raster to tonnes/area
  
  area <- area(input)
  forage_fish_raster_area <- input/area
  
  forage_fish_raster_area_resample <- projectRaster(forage_fish_raster_area, food_raster, method="ngb", over=TRUE, progress="text")
  
  area_new <- area(forage_fish_raster_area_resample)
  
  final_raster <- forage_fish_raster_area_resample*area_new
  final_raster
}
