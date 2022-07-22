## Function creating maps of goat and sheep (small ruminant) distribution: grassland and mixed; milk and meat
## Author: Juliette Verstaen


mapping_small_ruminant <- function(animal){
  
  for(system in small_ruminant_system_list) {
    for(product in small_ruminant_product_list) {
# 
#         animal_type = "goats"
#         system_type = "grassland"
#         product_type = "meat"
          
          animal_type <- animal
          product_type <- product
          system_type <- system

    ## create the land production system raster 
      
      lps_raster <- raster(file.path(raw, "FAO_livestock_maps/d2019/ruminant_production_systems/no_landless_production_maps/2_GlobalRuminantLPS_GIS/glps_gleam_61113_10km.tif"))
      ## the extent is a little bit off, so we will use the raster_df function. It might make things a little off, unsure how much that will influence the allocation of mixed vs grassland critters
      source(here("_spatial/template_raster.R"))
      
      lps_df <- lps_raster %>% 
        raster_df() %>% 
        select(x,y, cellindex, CLASSNAME) %>% 
        rename(glps_name = CLASSNAME) %>% 
        mutate(system = ifelse(is.na(glps_name), "neither",
                               ifelse(glps_name %in% c("Unsuitable", "Other", "Urban"), "neither",
                                      ifelse(glps_name %in% c("LGA", "LGH", "LGT", "LGY"), "grassland",
                                                              ifelse(glps_name %in% c("MRY", "MIY", "MRA", "MIA", "MRT", "MRH", "MIT", "MIH"), "mixed", NA)))))
      
      ##unique(lps_df$system) ## quick check, there should be no NAs
      # test <- lps_df %>%  mutate(code = case_when(system == "grassland" ~ 1,
      #                                                   system == "mixed" ~ 2,
      #                                                   system == "neither" ~ 3)) %>%
      #   select(x,y, code) %>%
      #   rasterFromXYZ(crs = food_crs)
      # 
      # par(mar=c(1,1,1,1))
      # plot(test)
      
      lps_df <- lps_df %>% 
        select(cellindex, system)
      
      
      ## read in the FAO production system map
      if(animal_type == "goats"){path <- file.path(raw, "FAO_livestock_maps/d2019/goats/5_Gt_2010_Da.tif")
      }else{path <- file.path(raw, "FAO_livestock_maps/d2019/sheep/5_Sh_2010_Da.tif")}
      
      animal_raster <- raster(path)
      names(animal_raster) <- "cell_count_all"
      
      # par(mar=c(1,1,1,1))
      # plot(animal_raster)
      
    ## first we will overlay the system raster with the livestock one, and keep the values for the cells that match the system we are looking at and "neither" (we will allocate those later), and make all others 0
      system_map_int <- animal_raster %>% 
        raster_df() %>% 
        left_join(lps_df, by = "cellindex") %>% 
        mutate(cell_count_syst = ifelse(system == system_type, cell_count_all, 0)) %>% 
        select(-x, -y) %>% 
        left_join(food_rgns_xy, by = "cellindex") %>% 
        mutate(cell_count_syst = ifelse(is.na(cell_count_syst), 0, cell_count_syst),
               cell_count_all = ifelse(is.na(cell_count_all), 0, cell_count_all)) 
      
      ## now we want to calculate the regional proportions for grassland vs mixed livestock to reallocate the livestock that fall in the "neither" category. We have externally calcualted that and created a df with regional system proportions
     
      rum_syst_prop <- read_csv(here("animal_farm/farm/data/rum_system_prop.csv"))
      
      ## grab the system proportions that are relevant to where the loop is at
      short_system_prop <- rum_syst_prop %>% 
        filter(system == system_type,
               animal == animal_type) %>% 
        select(iso3c, allocating_system_prop = system_prop)
      
      ## reallocate the animals that fall in neither based on the gridded livestock system proportions
      livestock_map_system <- system_map_int %>% 
        left_join(short_system_prop, by = "iso3c") %>% 
        mutate(cell_count_syst_gf = cell_count_syst,
               cell_count_syst_gf = ifelse(system == "neither", cell_count_all*allocating_system_prop, cell_count_syst_gf),
               system = system_type,
               animal = animal_type) %>% 
        select(x, y, iso3c,country = Country, animal, system, cell_count_all, cell_count_syst_gf) 
        
      ### now we want to multiply the proportions we calculated from GLEAM for milk/meat animals in each system
      product_proportions <- read_csv(here("animal_farm/farm/data/ruminant_product_proportions_gf.csv")) %>% 
        filter(animal == animal_type,
               system  == system_type,
               product == product_type) %>% 
        select(iso3c, product_prop)
      
      livestock_map_cell_prop <- left_join(livestock_map_system, product_proportions, by = "iso3c") %>% 
        mutate(cell_count_category = cell_count_syst_gf*product_prop) %>% 
        group_by(iso3c) %>% 
        mutate(rgn_total = sum(cell_count_all, na.rm = TRUE)) %>% 
        ungroup() %>% 
        rowwise() %>% 
        mutate(map_prop = cell_count_category/rgn_total) %>% 
        ungroup()
    
      ## check, should be less than 1 because only include 1/4 of the categories
      # check <- livestock_map_cell_prop %>% 
      #   group_by(iso3c) %>% 
      #   dplyr::summarise(sum = sum(map_prop, na.rm= TRUE))
    
### Now we can use the 2016 fao data for each animal and multiply it by the map_prop 
      
      fao_data <- read_csv(here("animal_farm/farm/data/fao_livestock_headcount.csv")) %>% 
        filter(animal == animal_type) %>% 
        select(iso3c, fao_headcount)
    
      final_map <- livestock_map_cell_prop %>% 
        left_join(fao_data, by = "iso3c") %>% 
        rowwise() %>% 
        mutate(current_count = map_prop*fao_headcount,
               product = product_type) %>% 
        select(x,y, iso3c, country, animal, system, product, cell_headcount_all = cell_count_all, cell_headcount_category = cell_count_category, rgn_total, map_prop, fao_headcount, current_count)
  
                    
      write_csv(final_map, file.path(prep, paste0("animal_farm/farm/ungapfilled/", animal, "_",  system, "_", product, "_location_df_ungf.csv"))) 
      
    }
  
}
}


