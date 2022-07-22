# Animal Disturbance 

This folder contains all the scripts and data produced from them for calculating disturbance values per head of livestock, and the final disturbance rasters.

In each system/product combination of chickens, pigs, and ungrazed cows, buffaloes, goats, and sheep a single disturbance value of space/head was assigned. Grazed systems to not have the same linear disturbance relationship, a cow that occupies 1 km2 of space doesn't 100% disturb 1 km2. For this we estimated grazing intensity based of available forage from NPP maps and livestock forage requirements. 

## Scripts
| File Name | Description | Output |
|:----------:|:-------------:|:------:|
| STEP1_across_country_conversions.Rmd | First, wrangles the FAO LSU conversion values. Then uses it and USA based livestock minimum space requirement data to calculate the differentarea/head value for each animal in each country. | across_country_conversions.csv; livestock_area_head_table.csv |
| STEP2_calculate_head_liveweight_conversions.Rmd | Uses GLEAM values to calculate a head to liveweight conversion value for broiler chickens, layer chickens, and pigs. | chicken_pigs_live_weights.csv |
| STEP3_disturbance_chickens.Rmd | Calculates the disturbance layer for industrial (eggs, meat) and backyard (eggs&meat) chickens | Final raster layers for the 3 chicken food categories |
| STEP4_disturbance_pigs.Rmd | Calculates the disturbance layer for industrial, intermediate, and backyard pigs | Final raster layers for the 3 pig food categories |
| STEP5_disturbance_ruminants_mixed.Rmd | Calculates the disturbance layer mixed ruminants (cows (meat, milk), buffaloes (milk), sheep (meat, milk), goats (meat, milk)) | Final raster layers for the 7 mixed ruminant food categories |
| STEP6_npp_maps.Rmd | Creates one raster of average NPP from 2013-2015 | mean_npp_2013_2015.tif (saved on the server)|
| STEP7_disturbance_ruminants_grazing.Rmd | Calculates disturbance raster for feedlot meat cows | Final raster layers for the feedlot cows |

## Contributors
Juliette Verstaen