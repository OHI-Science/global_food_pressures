### saving Excel sheets from GLEAMi download to CSV files

library(readxl)
library(countrycode)
library(here)

source(here("_workflow/common.R"))

### Extract Data

files <- list.files(file.path(raw, "GLEAMi/data_excel_macro"), pattern="xlsx")

for(file in files){ 
  
  #file = files[1]
  
  country <- gsub(".xlsx", "", file)  
  
  # chicken data  
  chick <- readxl::read_excel(paste0(raw, "GLEAMi/data_excel_macro/", file),
                              sheet = 3, skip=4)
  
  chick$Country <- country 
  
  chick <- chick %>%
    select(Country, Species, Production_system = "Production system", Variable, Unit, Value="Baseline value")
  
  write_csv(chick, file.path(paste0(raw, "GLEAMi/data_excel_macro/wrangled_csv/chicken_", country, ".csv")))
  
  
  # pig data
  pigs <- readxl::read_excel(paste0(raw, "GLEAMi/data_excel_macro/", file),
                             sheet = 2, skip=4)
  
  pigs$Country <- country 
  
  pigs <- pigs %>%
    select(Country, Species, Production_system = "Production system", Variable, Unit, Value="Baseline value")
  
  write_csv(pigs, file.path(paste0(raw, "GLEAMi/data_excel_macro/wrangled_csv/pigs_", country, ".csv")))
  
  
  # ruminants
  rums <- readxl::read_excel(paste0(raw, "GLEAMi/data_excel_macro/", file),
                             sheet = 4, skip=4)
  
  rums$Country <- country 
  
  rums <- rums %>%
    select(Country, Species, Production_system = "Production system", Herd_type = "Herd type", Variable, Unit, Value="Baseline value")
  
  write_csv(rums, file.path(paste0(raw, "GLEAMi/data_excel_macro/wrangled_csv/rum_", country, ".csv")))
  
}


#######################################
## combine chicken datasets into single dataset
#######################################

chicks <- list.files(paste0(raw, "GLEAMi/data_excel_macro/wrangled_csv"), pattern = "chicken", full=TRUE)

chicken_data <- lapply(chicks, read_csv)
chicken_data <- bind_rows(chicken_data)


## standardize region names
## filter out countries we are not considering
cut <- read_csv(here("_spatial/_output/NA_coded_regions_land_based.csv")) %>% 
  filter(included_region == "no")

dim(chicken_data)

chicken_data <- chicken_data %>%
  mutate(Country = gsub("_", " ", Country)) %>%
  filter(!(Country %in% cut$region_name)) %>% 
  filter(!(Country %in% cut$synonym))

dim(chicken_data)

summary(chicken_data) # should be no NA values

# add country isocodes

chicken_data <- chicken_data %>% 
  mutate(iso3c = countrycode(Country, origin="country.name", destination = "iso3c")) %>% 
  mutate(iso3c = ifelse(Country == "Madeira Islands", "XMI",
                        ifelse(Country == "Netherlands Antilles", "BES", iso3c))) %>% 
  mutate(country_name_st = countrycode(Country, origin="country.name", destination = "country.name")) %>% 
  mutate(country_name_st = ifelse(Country == "Madeira Islands", "Madeira Islands",
                        ifelse(Country == "Netherlands Antilles", "Bonaire, Sint Eustatius and Saba", country_name_st)))

# check for duplicates
sort(table(chicken_data$country_name_st))
sum(table(chicken_data$country_name_st)>132)

# combine Palestine data
# There are 0 values for intake data for gaza strip, weird but will keep going
filter(chicken_data, iso3c == "PSE")
table(chicken_data$Unit)
filter(chicken_data, iso3c == "PSE" & Unit == "kg CO2-eq/kg protein")
data.frame(filter(chicken_data, Country=="Gaza Strip"))
data.frame(filter(chicken_data, Production_system=="Backyard" & iso3c=="PSE"))

## look at all the varibales and units to figure out best way to combine west bank and gaza strip
variables <- chicken_data %>% 
  filter(iso3c == "PSE") %>% 
  select(Variable, Unit) %>% 
  unique()
## all variables look like they can be summed between the two countries except for "EI: Emission intensity" which we will averaged 

palestina <- chicken_data %>% 
  filter(iso3c == "PSE") %>% 
  spread(Country, Value) %>% 
  mutate(Value = ifelse(Variable %in% c("EI: Emission intensity of egss", "EI: Emission intensity of meat"), rowMeans(.[,7:8]), rowSums(.[,7:8]))) %>% 
  select(-'Gaza Strip', -'West Bank') %>% 
  mutate(Country = "Gaza Strip and West Bank")

chicken_data <- chicken_data %>% 
  filter(iso3c != "PSE") %>%
    rbind(palestina) %>% 
  mutate(Country = country_name_st) %>%
  select(-country_name_st)

write_csv(chicken_data, here("animal_farm/farm/data/chickens_GLEAMi_v2.csv"))


#######################################
## combine pig datasets into single dataset
#######################################

pigs <- list.files(paste0(raw, "GLEAMi/data_excel_macro/wrangled_csv"), pattern = "pigs", full=TRUE)

pig_data <- lapply(pigs, read_csv)
pig_data <- bind_rows(pig_data)


## standardize region names
## filter out countries we are not considering
cut <- read_csv(here("_spatial/_output/NA_coded_regions_land_based.csv")) %>% 
  filter(included_region == "no")

dim(pigdata)

pig_data <- pig_data %>%
  mutate(Country = gsub("_", " ", Country)) %>%
  filter(!(Country %in% cut$region_name)) %>% 
  filter(!(Country %in% cut$synonym))

summary(pig_data) # should be no NA Values

# add country isocodes

pig_data <- pig_data %>% 
  mutate(iso3c = countrycode(Country, origin="country.name", destination = "iso3c")) %>% 
  mutate(iso3c = ifelse(Country == "Madeira Islands", "XMI",
                        ifelse(Country == "Netherlands Antilles", "BES", iso3c))) %>% 
  mutate(country_name_st = countrycode(Country, origin="country.name", destination = "country.name")) %>% 
  mutate(country_name_st = ifelse(Country == "Madeira Islands", "Madeira Islands",
                                  ifelse(Country == "Netherlands Antilles", "Bonaire, Sint Eustatius and Saba", country_name_st)))

# check for duplicates
sort(table(pig_data$country_name_st))
sum(table(pig_data$country_name_st)>120)

# combine Palestine data
# no pigs in Gaza strip data...cut
data.frame(filter(pig_data, iso3c == "PSE"))


pig_data <- pig_data %>%
  filter(Country != "Gaza Strip") %>%
  mutate(Country = country_name_st) %>%
  select(-country_name_st)

write_csv(pig_data, here("animal_farm/farm/data/pigs_GLEAMi_v2.csv"))


#######################################
## combine ruminants datasets into single dataset
#######################################

## just cut the variables that can't be summed for Palestine.  These can be recalculated later!

ruminants <- list.files(paste0(raw, "GLEAMi/data_excel_macro/wrangled_csv"), pattern = "rum", full=TRUE)

ruminants_data <- lapply(ruminants, read_csv)
ruminants_data <- bind_rows(ruminants_data)


## standardize region names
## filter out countries we are not considering
cut <- read_csv(here("_spatial/_output/NA_coded_regions_land_based.csv")) %>% 
  filter(included_region == "no")

dim(ruminants_data)

ruminants_data <- ruminants_data %>%
  mutate(Country = gsub("_", " ", Country)) %>%
  filter(!(Country %in% cut$region_name))%>%
  filter(!(Country %in% cut$synonym))

summary(ruminants_data)
## there are 324 rows with Na values:
## For all species the only countries that have NA values are China Macau SAR, Monaco, and Nauru. There is data on various combinations of parameters, but all the values are 0. I do not know why some rows are NA
## I feel comfortable that these NAs are 0s

dim(ruminants_data)

# add country isocodes

ruminants_data <- ruminants_data %>% 
  mutate(Value = ifelse(is.na(Value), 0, Value)) %>% 
  mutate(iso3c = countrycode(Country, origin="country.name", destination = "iso3c")) %>% 
  mutate(iso3c = ifelse(Country == "Madeira Islands", "XMI",
                        ifelse(Country == "Netherlands Antilles", "BES", iso3c))) %>% 
  mutate(country_name_st = countrycode(Country, origin="country.name", destination = "country.name")) %>% 
  mutate(country_name_st = ifelse(Country == "Madeira Islands", "Madeira Islands",
                                  ifelse(Country == "Netherlands Antilles", "Bonaire, Sint Eustatius and Saba", country_name_st)))

# check for duplicates
sort(table(ruminants_data$country_name_st))
sum(table(ruminants_data$country_name_st)>1221)


## Combine gaza strip and west bank

palestina <- ruminants_data %>% 
  filter(iso3c == "PSE") %>% 
  spread(Country, Value) %>% 
  mutate(Value = ifelse(Variable %in% c("EI: Emission intensity of egss", "EI: Emission intensity of meat"), rowMeans(.[,8:9]), rowSums(.[,8:9]))) %>% 
  select(-'Gaza Strip', -'West Bank') %>% 
  mutate(Country = "Gaza Strip and West Bank")

ruminants_data <- ruminants_data %>% 
  filter(iso3c != "PSE") %>%
  rbind(palestina) %>% 
  mutate(Country = country_name_st) %>%
  select(-country_name_st)

write_csv(ruminants_data, here("animal_farm/farm/data/ruminants_GLEAMi_v2_unmodified.csv"))

