mar_split <- function(m) {
  ### Deal with special cases of countries, specific to MAR: Netherlands Antilles reported multiple ways, including 'Bonaire/S.Eustatius/Saba' 
  ### - fao_major_area reports 'Antilles' as one region, but OHI considers as four 
  ###   reported regions; break up and distribute values 
  
# Currently only marine aquaculture in this region, and only Montenegro has a coastline   
 m <- m %>% 
    mutate(country = ifelse(country=='Serbia and Montenegro' & environment %in% c("Marine", "Brackishwater"), "Montenegro", country))
    
  m_channel <- m %>%
    filter(country == 'Channel Islands') %>%
    mutate(
      value            = value/2,
      'Guernsey'        = value,
      'Jersey'           = value) %>%
    select(-value, -country) %>%
    gather(country, value, -species, -fao_major_area, -environment, -year) %>%
    mutate(country = as.character(country))  
  m <- m %>%
    filter(country != 'Channel Islands') %>%
    bind_rows(m_channel) %>%  
    arrange(country, fao_major_area, environment, species, year, value) 
  
  
  return(m)
}

