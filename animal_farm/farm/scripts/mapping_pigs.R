## Function creating maps of pig distribution; backyard, intermediate, and industrial production systems; only product is meat
## Author: Juliette Verstaen

mapping_pigs <- function(animal){
  
  for(system in pigs_system_list) {
    # 
    # animal = "pigs"
    # system = "industrial"
    # product = "meat"

    # library(here)
    # source(here("_workflow/common.R"))
    # source(here("_workflow/common_spatial.R"))
    source(here("_spatial/template_raster.R"))
    
    ## Calculate the total proportional allocations to each system using the FAO maps
    backyard_raster <-  raster(file.path(raw, "FAO_livestock_maps/d2019/pigs/backyard_pigs/8_PgExt_2010_Da.tif"))
    names(backyard_raster) <- "backyard_map_counts"
    
    intermediate_raster <- raster(file.path(raw, "FAO_livestock_maps/d2019/pigs/semi_intensive_pigs/9_PgInt_2010_Da.tif"))
    names(intermediate_raster) <- "intermediate_map_counts"
    
    industrial_raster <- raster(file.path(raw, "FAO_livestock_maps/d2019/pigs/intensive_pigs/10_PgInd_2010_Da.tif"))
    names(industrial_raster) <- "industrial_map_counts"
    
    ## grab the FAO livestock count data
    fao_livestock_rgn_headcount <- read_csv(here("animal_farm/farm/data/fao_livestock_headcount.csv")) %>% 
      filter(animal == "pigs",
             year == 2017)
    
    total_fao_pigs <- fao_livestock_rgn_headcount %>% 
      dplyr::summarise(total = sum(fao_headcount)) 
    ## 978,466,146 fao total pigs
    
    ## Calculate
    
    stack <- stack(backyard_raster, intermediate_raster, industrial_raster)
    #df <- as.data.frame(stack, xy= TRUE)
    df <- raster_df(stack) %>% select(-x, -y)
    
    all_systems_df <- df %>% 
      left_join(food_rgns_xy, by = "cellindex") %>% 
      select(x,y, iso3c, backyard_map_counts, intermediate_map_counts, industrial_map_counts) %>% 
      group_by(iso3c) %>% 
      mutate(map_rgn_syst_headcount = sum(backyard_map_counts, na.rm = TRUE) + sum(intermediate_map_counts, na.rm = TRUE) + sum(industrial_map_counts, na.rm = TRUE),
             prop_map_rgn_backyard = backyard_map_counts/map_rgn_syst_headcount,
             prop_map_rgn_intermediate = intermediate_map_counts/map_rgn_syst_headcount,
             prop_map_rgn_industrial = industrial_map_counts/map_rgn_syst_headcount) %>% 
      left_join(fao_livestock_rgn_headcount, by= "iso3c") %>% 
      rowwise() %>% 
      mutate(current_backyard_headcount = prop_map_rgn_backyard*fao_headcount,
             current_intermediate_headcount = prop_map_rgn_intermediate*fao_headcount,
             current_industrial_headcount = prop_map_rgn_industrial*fao_headcount) %>% 
      ungroup()

    sum_all <-  all_systems_df %>% 
      ungroup() %>% 
      dplyr::summarise(total = sum(current_backyard_headcount, na.rm = TRUE) + sum(current_intermediate_headcount, na.rm = TRUE) + sum(current_industrial_headcount, na.rm = TRUE))
    
    ## 978,466,146 fao total pigs
    ## 976,222,411 total pigs after distributing them, probably loosing some along the coast, that's fine
    ## 939,953,822 fao maps total pigs; these are very close so yay! probably just the difference between 2010 and 2016
    
    ## create system specific locations
    
    if(system == "backyard"){
      
      final_map <- all_systems_df %>% 
        select(x,y, iso3c, animal, product, backyard_map_counts, map_rgn_syst_headcount, prop_map_rgn_backyard, fao_headcount, current_backyard_headcount) %>% 
        mutate(system = system)
      
    }else{
      if (system == "intermediate"){
        
        final_map <- all_systems_df %>% 
          select(x,y, iso3c, animal, product, intermediate_map_counts, map_rgn_syst_headcount, prop_map_rgn_intermediate, fao_headcount, current_intermediate_headcount) %>% 
          mutate(system = system)
        
      }else{
        
        final_map <- all_systems_df %>% 
          select(x,y, iso3c, animal, product, industrial_map_counts, map_rgn_syst_headcount, prop_map_rgn_industrial, fao_headcount, current_industrial_headcount) %>% 
          mutate(system = system)
      } }
    
    write_csv(final_map, file.path(prep, paste0("animal_farm/farm/ungapfilled_chickens_pigs/pigs_",  system, "_meat_location_df_ungf.csv"))) 
    
  }
}