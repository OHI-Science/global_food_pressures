### Cleaning up and gapfilling N excretion rate data
### Juliette Verstaen
### August 13, 2020library(here)


library(janitor)
library(countrycode)
source(here("_workflow/common.R"))

n_exc_raw <- read_csv(file.path(raw, "FAO_data/v2020/manure_data/annex_Annual_N_excretion_by_animal.csv"))
un <- read_csv(here("_spatial/_output/UNSD_Methodology.csv")) %>% 
  dplyr::select(iso3c, Global_Name, Region_Name, Sub_region_Name, Intermediate_Region_Name, Region_Name)

## a little bit of country name cleaning
n_exc <- n_exc_raw %>% 
  select(- Continent, -Units) %>% 
  pivot_longer(-Country, names_to = "animal", values_to = "kg_n_yr") %>% 
  mutate(Country = ifelse(Country == "China, mainland", "China",
                          ifelse(Country == "China, Hong Kong SAR", "Hong Kong", 
                                 ifelse(Country == "Netherlands Antilles", "Bonaire, Sint Eustatius and Saba", Country)))) %>% 
  mutate(iso3c = countrycode::countrycode(Country, origin="country.name", destination = "iso3c")) %>% 
  select(-Country)

## there are some countries that have no reported animals, so we need to add them in so we can gapfil
## This is a cautionary action, even if those countries do not have those animals according to what FAO reports, our final head count maps might. we don't want to loose these animals
n_exc_gf <- left_join(food_rgns, n_exc, by = "iso3c") 

n_exc_missing <- n_exc_gf %>% 
  filter(is.na(animal)) %>% 
  select(-animal) %>% 
  slice(rep(1:n(), each = 6)) %>% 
  mutate(animal = rep(c("Cattle", "Goat", "Sheep", "Chicken", "Swine", "Buffalo"), times = 36))

## now we want to add in those missing countries with animals, and then gap fill
n_exc_gf <- n_exc_gf %>% 
  filter(!is.na(animal)) %>% 
  rbind(n_exc_missing) %>% 
  left_join(un, by = "iso3c") %>%
  group_by(animal, Intermediate_Region_Name) %>%
  mutate(kg_n_yr = ifelse(is.na(kg_n_yr), mean(kg_n_yr, na.rm = TRUE), kg_n_yr)) %>%
  ungroup() %>%
  group_by(animal, Sub_region_Name) %>%
  mutate(kg_n_yr = ifelse(is.na(kg_n_yr), mean(kg_n_yr, na.rm = TRUE), kg_n_yr)) %>%
  ungroup() %>%
  group_by(animal, Region_Name) %>%
  mutate(kg_n_yr = ifelse(is.na(kg_n_yr), mean(kg_n_yr, na.rm = TRUE), kg_n_yr)) %>%
  ungroup() %>% 
  group_by(animal, Global_Name) %>%
  mutate(kg_n_yr = ifelse(is.na(kg_n_yr), mean(kg_n_yr, na.rm = TRUE), kg_n_yr)) %>%
  ungroup() %>% 
  ## some last second name cleaning
  mutate(animal = ifelse(animal == "Cattle", "cows",
                         ifelse(animal == "Swine", "pigs",
                                ifelse(animal == "Goat", "goats",
                                       ifelse(animal == "Chicken", "chickens",
                                              ifelse(animal == "Buffalo", "buffaloes",
                                              ifelse(animal == "Sheep", "sheep", animal))))))) %>% 
  select(-Global_Name, -Region_Name, -Sub_region_Name, -Intermediate_Region_Name)

write_csv(n_exc_gf, here("animal_farm/ghg/data/nitrogen_excretion_rates.csv"))


