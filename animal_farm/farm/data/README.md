# Data Descriptions
********************

## GLEAM data

| File Name | Description |
|:----------:|:-------------:|
|**chickens_GLEAMi_v2.csv** |data set created from gleam_extract_v2.R which grabs GLEAM chicken data scraped from the web and tidies it|
|**pigs_GLEAMi_v2.csv** |data set created from gleam_extract_v2.R which grabs GLEAM pig data scraped from the web and tidies it|
|**ruminants_GLEAMi_v2.csv** |data set created from gleam_extract_v2.R which grabs GLEAM ruminant data scraped from the web and tidies it|

## Created in markdowns

| File Name | Description |
|:----------:|:-------------:|
|**fao_livestock_headcount.csv**| wrangled/tidied FAO 2010 and 2017 headcount data from the Emissions-Manure Management section of FAOSTAT (all our animals of interest)|
|**fao_production.csv** |wrangled/tidied FAO 2010 and 2017 production data from the Production-Livestock Primary section of FAOSTAT (all our animals/products of interest)|
|**prop_change_2010_2017.csv**| proportional change from 2010-2017 calculated using *fao_livestock_headcount.csv* for our animals of interest|
|**prop_change_backyard_chickens_2010_2017.csv**| proportional change from 2010-2017 calculated using chicken headcount data from Production-Livestock Primary section of FAOSTAT (this is not broiler or layer specific). Uses *fao_chicken_live_animal_count.csv*| 
|**ruminants_production_rates.csv** |production rates for each product from dairy and non dairy herd ruminants (does not differentiate between grassland and mixed systems). Calculated using *ruminants_GLEAMi_v2.csv*|
|**pigs_system_prop.csv** |pigs system (industrial, intermediate, backyard) proportions by region. Calculated with the global distributions map data|
|**prop_industrial_chickens_gf.csv** |Proportion of industrial broilers(meat) relative to industrial layers (eggs). Calculated with *chickens_GLEAMi_v2.csv*|

## Added externally to folder

| File Name | Description |
|:----------:|:-------------:|
|**feedlot_locations** |USA addresses for cow feedlots|
|**fao_chicken_live_animal_count.csv** |Chicken headcount data from Production-Livestock Primary section of FAOSTAT (this is not broiler or layer specific)|
|**continent_system_props_pigs.csv** |Continental values for pig system proportions (industrial, intermediate, backyard) which are used for gapfilling. These values are ballpark medians estimated from the tables created in *STEP10_pigs_system_prop.Rmd*|

## production_system2_df folder

| File Name | Description |
|:----------:|:-------------:|
|**buffalo_prod_syst2.csv, cows_prod_syst2.csv, cows_prod_syst2.csv, buffalo_prod_syst2.csv**| Dfs with country specific prop mixed or grassland|