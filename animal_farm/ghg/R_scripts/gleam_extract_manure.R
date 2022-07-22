### saving data sheets from GLEAMi manure download as one big cleaned DF
### Juliette Verstaen
### July 24, 2020

library(countrycode)
library(here)
source(here("_workflow/common.R"))

## Grab the files and combine as one manure df
manure_files <- list.files(file.path(raw, "GLEAMi/Extract_data_web_based"), pattern="manure", full = TRUE)

manure_data <- lapply(manure_files, read_csv)
manure_data <- bind_rows(manure_data)

## standardize region names
## filter out countries we are not considering
cut <- read_csv(here("_spatial/_output/NA_coded_regions_land_based.csv")) %>% 
  filter(included_region == "no")

dim(manure_data)

manure_data <- manure_data %>%
  mutate(country = gsub("_", " ", country)) %>%
  filter(!(country %in% cut$region_name)) %>% 
  filter(!(country %in% cut$synonym))

summary(manure_data) # should be no NA values

## add country isocodes
manure_data <- manure_data %>% 
  mutate(iso3c = countrycode(country, origin="country.name", destination = "iso3c")) %>% 
  mutate(iso3c = ifelse(country == "Madeira-Islands", "XMI",
                        ifelse(country == "Netherlands Antilles", "BES", iso3c))) %>% 
  mutate(country_name_st = countrycode(country, origin="country.name", destination = "country.name")) %>% 
  mutate(country_name_st = ifelse(country == "Madeira-Islands", "Madeira Islands",
                        ifelse(country == "Netherlands Antilles", "Bonaire, Sint Eustatius and Saba", country_name_st)))

## check for duplicates
sort(table(manure_data$country_name_st))
sum(table(manure_data$country_name_st)>204)

## combine Palestine data (West-Bank and Gaza Strip); looking through the data manually looks like they both have the same values, will take an average just incase
check <- manure_data %>% 
  filter(iso3c == "PSE" & species == "Goat")

manure_pse <- manure_data %>% 
  filter(iso3c == "PSE") %>% 
  group_by(category, manuremanagement, name, orientation, production_system, species) %>% 
  dplyr::summarise(gleam_percentage = mean(str_value, na.rm = TRUE)) %>% 
  mutate(iso3c = "PSE",
         country = "Palestinian Territories") %>%  
  rename(mms_specific = manuremanagement) %>% 
  ungroup()

manure <- manure_data %>% 
  filter(iso3c != "PSE") %>% 
  select(-unit, -datasource, - access, -country) %>% 
  rename(country = country_name_st,
         mms_specific = manuremanagement,
        gleam_percentage = str_value) %>% 
  rbind(manure_pse) %>% 
  ## GLEAM says that some of the grassland based manure gets managed, we want it to all be left on pasture
  mutate(percentage = ifelse(production_system == "Grassland Based", 0, gleam_percentage),
         percentage = ifelse(production_system == "Grassland Based" & mms_specific == "Pasture/Range/Paddock", 100, percentage), 
         orientation = ifelse(orientation == "Feedlot", "Meat", orientation),
         
  ## super weird that there are a lot of countries with percentages of manure from feedlots, when the GLEAM herd data has only 12 countries with feedlots; in the end it will mupltiply out but still... strange
         species = ifelse(species == "Cattle", "Cow", species),
         species = ifelse(species == "Buffalo", "Buffaloes", species),
  
  ## no backyard chickens for meat.... I am going to rename it as eggs and meat because logically it will be the same. it looks like its 50.50 left on pasture and spread
         orientation = ifelse(species == "Chicken" & production_system == "Backyard", "eggs&meat", orientation),
         production_system = ifelse(species == "Chicken" & production_system == "Layers",  "Industrial",
                                     ifelse(species == "Chicken" & production_system == "Broiler", "Industrial",
                                     production_system))) %>% 
  mutate(mms = case_when(mms_specific == "Pasture/Range/Paddock" ~ "left on field",
                         mms_specific == "Daily spread" ~ "applied to crops",
                         T ~ "management")) %>% 
  select(iso3c, country,mms, mms_specific, animal = species, product = orientation, production_system, gleam_percentage, percentage)

write_csv(manure, here("animal_farm/ghg/data/mms_specific_percentages.csv"))


# manure_short <- manure %>% 
#   group_by(iso3c, country, animal, product, production_system) %>% 
#   dplyr::summarise(percentage= sum(percentage, na.rm = TRUE)) %>% 
#   ungroup()
## industrial eggs dont add up to 100...

# check <- mms_percent_raw %>% 
#   group_by(iso3c, country, animal, product, production_system) %>% 
#   dplyr::summarise(percentage= sum(gleam_percentage, na.rm = TRUE)) %>% 
#   ungroup()





