# Animal Farm Location

This folder contains all the scripts and data produced from them for creating spatial data frames for all of our project livestock categories. These categories are:

1. meat or milk cows, goats, and sheep raised in both mixed and grassland production systems
2. milk buffaloes raised in both mixed and grassland production systems.
3. egg or meat chickens raised in industrial systems
4. egg and meat chickens raised in backyard systems
5. meat pigs raised in industrial, intermediate, or backyard systems

| File Name | Description | Output |
|:----------:|:-------------:|:------:|
| STEP1_fao_livestock_count.Rmd | Wrangles the FAO headcount data from the Emissions-Manure Management section of FAOSTAT into an easy format for the analysis later down the line. | fao_livestock_headcount.csv |
| STEP2_fao_livestock_production.Rmd | Wrangles the FAO production data from the Production-Livestock Primary section of FAOSTAT into an easy format for the analysis later down the line. | fao_production.csv|
| STEP3_prop_change_2010_2017.Rmd | Calculates the proportional change from 2010-2017 for the headcounts of our animals of interest using FAOSTAT data. |prop_change_2010_2017.csv and prop_change_backyard_chickens_2010_2017.csv |
| STEP4_production_rates.Rmd| Creates a data file with production/head of animal using the GLEAM data. We are not differentiating between grassland and mixed systems. | ruminants_production_rates.csv |
|STEP5_rum_system2_prop.Rmd |Creates a raster for each of our animals and production system2 (mixed/grass) where each cell is a percentage of the total number of animals in that cell that fall into that category. | ruminant_prod_syst2.csv (one for each ruminant) and ruminant_system_OI_prod_system.tif (one for each ruminant and system)|
| STEP6_rum_system1_prop.Rmd | Calculates the percent non-dairy and dairy herd for all our ruminant species, and turns it into a raster. | ruminant_dairy.tif and ruminant_nondairy.tif|
|STEP7_rum_update_maps.Rmd | Allocates the 2017 FAOSTAT headcount data to the 2010 gridded global distribution of livestock maps | animal_all_counts.tif (one for each ruminant)|
|STEP8_map_chick_pigs_locations.Rmd | Map the distribution of total current living chickens and pigs globally. | 6 df maps (chicken_meat_industrial.csv, chicken_eggs_industrial.csv, chicken_eggs&meat_backyard.csv, pigs_meat_industrial.csv, pigs_meat_intermediate.csv, pigs_meat_backyard.csv|
|STEP9_map_ruminant_locations.Rmd | Creates maps each for all our ruminants by grassland/mixed and dairy/nondairy combinations (14 total. | ruminant_system_product.csv and tif files for every combination of cows/buffaloes/goats/sheep, grassland/mixed, and milk/meat.|
|STEP10_pigs_system_prop| Calculates pigs system proportions by region using the global distributions map data and also gapfills missing countries. | pigs_system_prop.csv|
| STEP11_pigs_locations_gapfilling.Rmd | Gapfills our 3 pig maps | Gapfilled versions of our input maps|
|STEP12_gleam_broiler_layer_proportion.Rmd | Calculates proportion of industrial broilers(meat) relative to industrial layers (eggs). |prop_industrial_chickens_gf.csv|
|STEP13_chicken_locations_gapfilling.Rmd | Gapfills our 2 industrial chicken maps | Gapfilled versions of our input maps|
|STEP14_creating_country_livestock_df.Rmd | Creates a summary df for each of our animals. | CSV files for each animal categories with the regional totals |






## Contributors
Juliette Verstaen