
prod2_maps <- function(ruminant) {
  
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
  
  ## Create the regional percentage df
  animal_syst_prop <- animal_raster %>% 
    raster_df() %>% 
    left_join(lps_df, by = "cellindex") %>%
    ## remove the neither information
    mutate(animal_counts = ifelse(system == "neither", 0, animal_counts),
           system = ifelse(system == "neither", NA, system)) %>% 
    select(-x, -y) %>% 
    ## add in country and iso3 info
    left_join(food_rgns_xy, by = "cellindex") %>% 
    group_by(iso3c, system) %>% 
    ## calculate total region system counts and total region counts
    dplyr::summarise(system_total = sum(animal_counts, na.rm = TRUE)) %>% 
    ungroup() %>% 
    group_by(iso3c) %>% 
    mutate(rgn_total = sum(system_total, na.rm = TRUE)) %>% 
    ungroup() %>% 
    rowwise() %>% 
    mutate(system_prop = system_total/rgn_total,
           system_prop = ifelse(system_total == 0 & rgn_total == 0, 0, system_prop))  %>% 
    filter(!is.na(system),
           !is.na(iso3c)) 
  
  ## Gapfill
  missing_rgn <- setdiff(food_rgns$iso3c, animal_syst_prop$iso3c)
  
  ## 1. there are some countries where the prop is 0 for both grass and mixed because no animals are in the gridded. will gapfill those with 1 for mixed
  ## 2. there are 28 countries that we added in from our food systems project list. all of these will be mixed
  
  animal_syst_prop_gf <- animal_syst_prop %>% 
    right_join(food_rgns, by = "iso3c") %>% 
    group_by(iso3c) %>% 
    mutate(system_sum = sum(system_prop)) %>% 
    ungroup() %>%  
    mutate(system_prop = ifelse(system_sum == 0 & system == "mixed", 1, system_prop),
           system = ifelse(iso3c %in% missing_rgn, "mixed", system),
           system_prop = ifelse(iso3c %in% missing_rgn, 1, system_prop)) %>% 
    select(-system_sum, -ID_0, -Country)
  
  ## There are some countries that only have 1 system so there is only one line. we want to add in the missing one with a 0 to make things cleaner down the line. there are also a couple countries with only 1 row and its 0 prop. ex for sheep: Anguilla, Bermuda and the British Virgin Islands only have grassland cells, no mixed, and they have 0 reported animals so the proportion is 0. will make these 1. Saint Vincent and the Grenadines has 1 cell mixed and 3 NA. will make the proportion 1 
  
  missing_system <- animal_syst_prop_gf %>% 
    group_by(iso3c) %>% 
    filter(n() <= 1) %>% 
    ungroup() %>% 
    pivot_wider(names_from = "system", values_from = "system_prop") %>% 
    mutate(grassland = ifelse(grassland == 0 & is.na(mixed), 1, grassland),
           mixed = ifelse(mixed == 0 & is.na(grassland), 1, mixed)) %>% 
    mutate(grassland = ifelse(is.na(grassland), 1-mixed, grassland),
           mixed = ifelse(is.na(mixed), 1-grassland, mixed)) %>% 
    pivot_longer(cols = 4:5, names_to = "system") %>% 
    rename(system_prop = value)
  
  ## add back in
  animal_syst_prop_final <- animal_syst_prop_gf %>% 
    group_by(iso3c) %>% 
    filter(n() > 1) %>% 
    ungroup() %>% 
    rbind(missing_system) %>% 
    mutate(animal = ruminant)
  
write_csv(animal_syst_prop_final, here(paste0("animal_farm/farm/data/production_system2_dfs/", ruminant, "_prod_syst2.csv", sep = "")  ))
  
}
