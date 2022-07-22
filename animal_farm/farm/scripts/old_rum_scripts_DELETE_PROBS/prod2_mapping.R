## Creating rasters for each animal and production system where the cell is the proportion of animals in that cell that are grassland or mixed
## Juliette Verstaen
## 9/22/20


prod2_mapping <- function(ruminant) {

  ##ruminant <- "cows"
  
  ## grab the animal raster we are interseted in
  if(ruminant == "cows") {
    animal_raster <- raster(file.path(raw, "FAO_livestock_maps/d2019/cattle/5_Ct_2010_Da.tif"))
    names(animal_raster) <- "animal_counts"
    
  }else{
    if(ruminant == "goats"){
      animal_raster <- raster(file.path(raw, "FAO_livestock_maps/d2019/goats/5_Gt_2010_Da.tif"))
      names(animal_raster) <- "animal_counts"
      
    }else{
      if(ruminant == "sheep"){
        animal_raster <- raster(file.path(raw, "FAO_livestock_maps/d2019/sheep/5_Sh_2010_Da.tif"))
        names(animal_raster) <- "animal_counts"
        
      }else{
        animal_raster <- raster(file.path(raw, "FAO_livestock_maps/d2019/buffalo/5_Bf_2010_Da.tif"))
        names(animal_raster) <- "animal_counts"
      }}}
  
  for(system_OI in system_list) {

## read in gf df

    gf_df <- read_csv(here(paste0("animal_farm/farm/data/production_system2_dfs/", ruminant, "_prod_syst2.csv", sep = ""))) %>% 
      select(iso3c, gf_system = system, system_prop) %>% 
      filter(gf_system == system_OI)
    
    if(system_OI == "grassland") {
    
    animal_syst_prop <- animal_raster %>% 
      raster_df() %>% 
      left_join(lps_df, by = "cellindex") %>% 
      select(-x,-y) %>% 
      left_join(food_rgns_xy, by = "cellindex") %>% 
      left_join(gf_df, by = c("iso3c")) %>% 
      mutate(cell_prop = case_when(system == "grassland" ~ 1,
                               system == "mixed" ~ 0,
                               T ~ system_prop))
    
    }else{
      animal_syst_prop <- animal_raster %>% 
        raster_df() %>% 
        left_join(lps_df, by = "cellindex") %>% 
        select(-x,-y) %>% 
        left_join(food_rgns_xy, by = "cellindex") %>% 
        left_join(gf_df, by = c("iso3c")) %>% 
        mutate(cell_prop = case_when(system == "mixed" ~ 1,
                                     system == "grassland" ~ 0,
                                     T ~ system_prop))
    }

raster <- animal_syst_prop %>% 
  select(x,y, cell_prop) %>% 
  rasterFromXYZ(crs = food_crs)

writeRaster(raster, file.path(prep, paste0("animal_farm/farm/production_system2_tifs/", ruminant, "_", system_OI, "_prod_system.tif", sep = "")), format = "GTiff", overwrite = TRUE )               

}}