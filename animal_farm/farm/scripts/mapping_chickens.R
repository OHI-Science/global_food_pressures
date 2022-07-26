## Function creating maps of chicken distribution: backyard and industrial systems; milk and eggs
## Author: Juliette Verstaen

mapping_chickens <- function(animal, system){
  
    for(product in chicken_product_list) {
# 
#        animal = "chickens"
#        system = "industrial"
#        product = "meat"

      ## read in the correct FAO production system map
      if(system == "industrial"){
        
        path <- file.path(raw, "FAO_livestock_maps/d2019/chickens/07_ChInt_2010_Da.tif")
        
        
      }else{
        
        path <- file.path(raw, "FAO_livestock_maps/d2019/chickens/06_ChExt_2010_Da.tif")
        
      }
        raster <- raster(path)
        stack <- stack(food_rgns_tif, raster, food_rgns_area)
        column_count_name <- names(raster) ## the raster name is the column name when converted to df. we want to be able to rename it easily later so we save it here
        
        chicken_map_df <- as.data.frame(stack, xy=TRUE) %>%
          rename(ID_0 = food_rgns, map_head_count = paste0(column_count_name), area_km2= layer) %>% 
          mutate(map_head_count= ifelse(is.na(map_head_count), 0, map_head_count)) %>% 
          left_join(food_rgns, by = "ID_0") %>% 
          group_by(iso3c) %>% ## determine the proportion of chickens in the cell
          mutate(map_rgn_total = sum(map_head_count, na.rm = TRUE)) %>% 
          ungroup() %>% 
          rowwise() %>% 
          mutate(map_prop = map_head_count/map_rgn_total,
                 product = product,
                 system = system)
        
       
      ## now we want to read in the fao chicken adjusted count data
  
        fao_animal <- animal # filtering is not liking the column and filter variable being the same
        fao_product <- product

        if(system == "industrial" && product == "eggs&meat"){
          print("this is not a food category")
        }else{
        if(system == "backyard" && product == "eggs") {    
        print("this is not a food category")
        }else{
          if(system == "backyard" && product == "meat") {    
            print("this is not a food category")
            
          }else{    
        fao_livestock_headcount <- read_csv(here("animal_farm/farm/data/fao_livestock_headcount_chicken_adjusted.csv")) %>% 
          filter(year == 2017) %>% 
          filter(animal == fao_animal) %>%
          filter(product == fao_product) 

        final_map <- left_join(chicken_map_df, fao_livestock_headcount, by = c("iso3c", "product") )%>%
          mutate(fao_headcount = ifelse(is.na(fao_headcount), 0, fao_headcount)) %>%
          rowwise() %>%
          mutate(current_count = map_prop*fao_headcount) %>% 
          ungroup()

        write_csv(final_map, file.path(prep, paste0("animal_farm/farm/ungapfilled_chickens_pigs/chickens_",  system, "_", product, "_location_df_ungf.csv")))

    }
  }   }}}



