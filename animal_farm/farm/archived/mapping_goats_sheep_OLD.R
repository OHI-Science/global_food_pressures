## Function creating maps of goat and sheep (small ruminant) distribution: grassland and mixed; milk and meat
## Author: Juliette Verstaen


mapping_small_ruminant <- function(animal, product){
  
  for(system in small_ruminant_system_list) {
    for(product in small_ruminant_product_list) {
        # 
        # animal_type = "goats"
        # system_type = "grass"
        # product_type = "meat"
        # 
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
        mutate(system = case_when(glps_name == "LGA" | glps_name == "LGH" | glps_name =="LGT" | glps_name =="LGY" ~ "grassland",
                                  glps_name == "MRY" | glps_name =="MIY" | glps_name =="MRA" | glps_name =="MIA"
               | glps_name =="MRT" | glps_name =="MRH" | glps_name =="MIT" | glps_name =="MIH" ~ "mixed", 
                                  T ~ "other")) %>% 
        mutate(system = ifelse(is.na(glps_name), NA, system)) %>% 
        select(cellindex, system)
      
      # par(mar=c(1,1,1,1))
      # plot(lps_raster)
      
      ## read in the FAO production system map
      if(animal == "goats"){path <- file.path(raw, "FAO_livestock_maps/d2019/goats/5_Gt_2010_Da.tif")
      }else{path <- file.path(raw, "FAO_livestock_maps/d2019/sheep/5_Sh_2010_Da.tif")}
      
      animal_raster <- raster(path)
      names(animal_raster) <- "all_syst_map_count"
      
      # par(mar=c(1,1,1,1))
      # plot(animal_raster)
      
    ## first we will overlay the system raster with the livestock one, and keep the values for the cells that match the system we are looking at, and make all others 0
      system_map_int <- animal_raster %>% 
        raster_df() %>% 
        left_join(lps_df, by = "cellindex") %>% 
        mutate(fao_map_cell_count_system = ifelse(system == system_type, all_syst_map_count, 0)) %>% ## there are def cells listed as other for prod system that have animals
        select(-x,-y) %>% 
        left_join(food_rgns_xy, by = "cellindex") %>% 
        mutate(fao_map_cell_count_system = ifelse(is.na(fao_map_cell_count_system), 0, fao_map_cell_count_system)) 
        
      
      # check <- filter(system_map_int, system != "mixed")
      # check <- filter(system_map_int, system == "other") %>% dplyr::summarise(sum = sum(all_syst_map_count, na.rm = TRUE))
      # ## sheep = 156,666.3 in NA regions; 130,003,227 in "other"
      ## goats = 245,410 in NA regions; 151,606,494 in "other"
      
      ## ~13% livestock fall in the "other" system category
  
    ## there are quite a lot of heads that are in the FAO distribution maps that do not fall in a mixed or grassland system according to our land system prod map. so the animals in these cells will be alloted to grassland or mixed depending on the regional gleam system proportions
        
      system_proportions <- read_csv(here("animal_farm/farm/data/ruminant_gleam_system_proportions.csv")) %>% 
        filter(animal == animal_type,
               system  == system_type) %>% 
        select(iso3c, system_prop)
     
      ##overlay the system raster with the livestock one, and keep the values for the cells that fall in "other" system. then use the gleam proportions jsut for the system to alloate grassland or mixed based on country
       other_map <-  animal_raster %>% 
        raster_df() %>% 
        left_join(lps_df, by = "cellindex") %>% 
        mutate(fao_map_cell_count_other = ifelse(system == "other", all_syst_map_count, 0)) %>% 
        select(-x,-y) %>% 
        left_join(food_rgns_xy, by = "cellindex") %>% 
        left_join(system_proportions, by = "iso3c") %>% 
        mutate(fao_map_cell_count_other_dist = fao_map_cell_count_other*system_prop) %>% 
        mutate(fao_map_cell_count_other_dist = ifelse(is.na(fao_map_cell_count_other_dist), 0, fao_map_cell_count_other_dist)) %>% 
        select(cellindex, fao_map_cell_count_other_dist)
       
       
       ## combine the two maps (system and other)
        system_map <- system_map_int %>% 
          left_join(other_map, by = "cellindex") %>% 
          rowwise() %>% 
          mutate(fao_map_cell_count = fao_map_cell_count_system + fao_map_cell_count_other_dist) %>% 
          select(-fao_map_cell_count_system, -fao_map_cell_count_other_dist) %>% 
          group_by(iso3c) %>% 
          mutate(rgn_count = sum(fao_map_cell_count, na.rm = TRUE)) %>% 
          rowwise() %>% 
          mutate(map_rgn_prop = fao_map_cell_count/rgn_count,
                 map_rgn_prop = ifelse(is.na(map_rgn_prop), 0, map_rgn_prop)) %>% 
          ungroup() %>% 
          select(-system)
   
### Now we can use the 2016 fao data allocated to each each animal/system/product combination to distribute amount
      
      fao_allocated_data <- read_csv(here("animal_farm/farm/data/fao_allocations_goat_sheep.csv")) %>% 
        filter(animal == animal_type & system == system_type & product == product_type) %>% 
        select(iso3c, animal, system, product, fao_allocated_headcount)
   
      #length(setdiff(system_map$iso3c, gleam_proportions$iso3c) ## missing 12 regions
      #length(setdiff(gleam_proportions$iso3c, system_map$iso3c)) ## missing 0
      
      final_map <- system_map %>% 
        left_join(fao_allocated_data, by = "iso3c") %>% 
        rowwise() %>% 
        mutate(current_count = map_rgn_prop*fao_allocated_headcount,
               animal = animal_type,
               system = system_type,
               product = product_type) %>% ## these designations are not given to the countries not included in GLEAM
        select(x,y, ID_0, animal, system, product, iso3c, Country, all_syst_map_count, fao_map_cell_count, rgn_count, map_rgn_prop, fao_allocated_headcount, current_count)
      
                    
      write_csv(final_map, file.path(prep, paste0("animal_farm/farm/", animal, "_",  system, "_", product, "_location_df.csv"))) 
      
    }
  
}
}


