Feed folder organization

## 1.1_MAPSPAM_production.Rmd
GOAL: calculate tonnes of production for each mapspam crop in each country.
These data are used in several places in the analysis.

Inputs: 
* mapspam production tiff files
* spatial country boundaries
* MapSPAM_crop_info.csv (combine some SPAM categories, such as millet)
Outputs: 
* MAPSPAMcrop_production.csv

## 1.2_MAPSPAM_trade_proportions.Rmd
GOAL: This uses the FAO Food balance sheets to determine imports vs. local production (minus exports).  Then, we use FAO Detailed Trade Matrix to determine the proportion of total imports coming from each country.  We use crop production data to gapfill countries with no trade data, if a country has no trade data we assume imports are proportional to global production.

This is used later in the 6.3 and 6.4 scripts where we determine country of origin for feed items consumed in each country.

Inputs: 
* FAO Detailed trade matrix
* FAO Food balance sheets
* crop production data (from 1.1_MAPSPAM_production)
* MapSPAM_to_FAO_v2.csv (the original is also in there, MapSPAM_to_FAO.csv because other scripts use it. The v2 version is updated with the addition of the Food Balance Sheet values.)
Outputs: 
* FAO_MAPSPAMcrop_trade_data.csv

## 2.1_feedgroup_ruminants_proportions.Rmd
GOAL: For livestock, GLEAM provides feed composition data for different cohorts within a system (e.g., Cattle: Adult females, Meat animals, Replacement animals and adult males.

This script estimates the proportion of animals in each cohort to weight the feed composition data to better estimate the average feed composition for the entire system.

Inputs: 
* GLEAM herd data for ruminants
Outputs: 
* ruminant_feedgroup_prop.csv

## 2.2_livestock_diet_composition
GOAL: Extract and clean GLEAM data describing the % composition of feed for different animal groups.

Inputs:
* GLEAM feed data
* UN georegions for gapfilling
* ruminant_feedgroup_prop.csv (from 2.1_feedgroup_ruminants_proportions.Rmd)
Outputs:
* livestock_diet_composition.csv

## 2.3_aquaculture_diet_composition
GOAL: Extract and wrangle data describing average % diet composition for each category of aquaculture production.

Inputs:
* Froehlich 2018 diet composition data (and scripts in diet_composition_wrangling)
 - feed/diet_composition_wrangling/shrimp_aquaculture_diet_composition.csv"
 - feed/diet_composition_wrangling/marine-fish-general_aquaculture_diet_composition.csv
* feed/diet_composition_wrangling/salmon_aquaculture_diet_composition.csv (from Aas)
* Region list: _spatial/_output/food_rgns.csv
Outputs:
aquaculture_diet_composition.csv

## 3.1_chicken_diet_rate_consumption
GOAL: Determine how much each feed item is consumed per year per chicken, based on 
* consumption rates (tonnes animal-1 year-1) 
* % diet composition.

Inputs:
* livestock_diet_composition.csv (from 2.2_livestock_diet_composition)
* UN georegions for gapfilling
* GLEAM data describing Feed intake and number of animals to get tonnes/year

Outputs:
chicken_feed_consumption_rates.csv

## 3.2_pig_diet_rate_consumption
GOAL: Determine how much each feed item is consumed per year per pig, based on 
* consumption rates (tonnes animal-1 year-1) 
* % diet composition.

Inputs:
* livestock_diet_composition.csv (from 2.2_livestock_diet_composition)
* UN georegions for gapfilling
* GLEAM data describing Feed intake and number of animals to get tonnes/year (used data from webapp, due to errors discovered in the excel macro)

Outputs:
pigs_feed_consumption_rates.csv

## 3.3_ruminant_diet_rate_consumption
GOAL: Determine how much each feed item is consumed per year per cow/sheep/goal, based on 
* consumption rates (tonnes animal-1 year-1) 
* % diet composition.
This script also adjusts feed for grazed vs. mixed livestock.  For grazed, we assume all roughage comes fresh from fields (but we allow supplmentation of crop feed).  For mixed we assume that no roughage comes fresh from fields, but is provided. 

Inputs:
* livestock_diet_composition.csv (from 2.2_livestock_diet_composition)
* UN georegions for gapfilling
* GLEAM data describing Feed intake and number of animals to get tonnes/year (used data from webapp, due to errors discovered in the excel macro)

Outputs:
ruminnat_feed_consumption_rates.csv


## 4.1_livestock_diet_total_consumption.Rmd
GOAL: Determine tonnes of each feed item consumed per year for 2017 numbers of cows/goats/sheep/chickens/pigs based on  
* dietary consumption rates  
* total number of livestock in each country
This script also corrects inputs for FOFM to match Froehlich reported values.  This was particularly necessary because GLEAM had large overetimates of FOFM in 


Inputs:
* rate consumption data (from: 3.1, 3.2, and 3.3_XXX_diet_rate_consumption)
* data describing heads of livestock (farm data)
* msleckman.45.1_fofm_consumption.csv to correct FOFM estimates

Outputs:
* total_livestock_feedstuff_consumption.csv
* fofm_livestock_corrected_consumption.csv


## 4.2_aquaculture_diet_total_consumption.Rmd
GOAL: Determine tonnes of each feed item consumed per year for 2017 production of mariculture  
* feed conversion ratios  
* total tonnes production in each country
This script also corrects inputs for FOFM to match Froehlich reported values.  This was particularly necessary because GLEAM had large overetimates of FOFM in 


Inputs:
* aquaculture_diet_composition.csv (from: 2.3 aquaculture_diet_composition.Rmd)
* tonnes_per_country_group.csv 
* feed_conversion_aquaculture.csv
* msleckman.45.1_fofm_consumption.csv to correct FOFM estimates

Outputs:
* total_aquaculture_feedstuff_consumption.csv
* fofm_aquaculture_corrected_consumption.csv


## 4.3_combine_aquaculture_livestock_total_consumption.Rmd
GOAL:Combine mariculture and livestock feed consumption data 

Inputs:
* total_aquaculture_feedstuff_consumption.csv (from: 4.2_aquaculture_diet_total_consumption.Rmd)
* total_livestock_feedstuff_consumption.csv (from: 4.1_livestock_diet_total_consumption.Rmd)

Outputs:
* total_feedstuff_consumption.csv

## 5.1_GLEAM_diet_composition_update_data.Rmd
GOAL:Use feed data from FAO Food Balance Sheets to replace GLEAM data.

NOTE: Currently NOT replacing gleam data with this.
Inputs:
* MapSPAM_to_FAO.csv: to convert FAO data to SPAM data
* FAO food balance sheets

Outputs:
* feed_percents_FAO_fbs_update.csv

## 5.2_feed_group_translate.Rmd
GOAL:Take the feed data and separate into three main categories:
Mapspam
Fodder
FOFM

For crops: The source feed names are tranlated into SPAM crop names, tonnes values are corrected for loss during manufacturing, and totals are summed.

fofm: converted to tonnes of fish

Inputs:
* total_feedstuff_consumption.csv (from 4.3_aquaculture_diet_total_consumption.Rmd)
* feed_category_table.csv (converts source feed names to major categories of feed and crop feed into more standardized "product" names)
* feed_extraction_rates.csv (corrects for loss during processing/drying of each product)
* product_to_fao_spam.csv (converts product to spam crops)

Outputs:
* system_country_mapspam_tonnes_consumption.csv
* FMFO_country_data.csv (this goes to Jessica to get likely country of origin)
* livestock_system_country_fodder_consumption.csv

* system_consumption_per_category.csv (not used anywhere)

## 6.1_global_fodder_distribution.Rmd
GOAL: Takes fodder consumption for each animal system and determines proportion of globally produced fodder it consumes and then multiplies the fodder production raster by this value.  This is repeated for each animal system.

Due to mismatches between country consumption and production, we just use a global percent consumption.

Inputs:
* tonnes fodder production raster
* livestock_system_country_fodder_consumption.csv (from: 5.2_feed_group_translate.Rmd)

Outputs:
* raster for each animal system describing proportion of fodder consumption, saved to datalayers folder

## 6.2_feedfish_catch_proportion.Rmd
GOAL: Converts tonnes of fofm catch obtained by each country into a raster describing proportion going to each animal system based on country vessel and location of catch.

Inputs:
* FMFO_bySource.csv (derived from FMFO_country_data.csv)
* 2017 Watson catch data

Outputs:
* raster for each animal system describing proportion of forage fish catch based on catch location and country fishing vessel.

## 6.3_mapspam_prop_for_feed.Rmd
GOAL: Uses trade proportion data and country consumption data to determine likely country of origin of crops consumed by animals. 

Inputs:
* FAO_MAPSPAMcrop_trade_data.csv (from: 1.2_MAPSPAM_trade_proportions.Rmd)
* system_country_mapspam_tonnes_consumption.csv (from: 5.2_feed_group_translate.Rmd)

Outputs:
* country_system_crop_tonnes_feedproduced.csv

## 6.4_redistributing_feed_overshoot_and_prop_mapspam.Rmd
GOAL: There are mismatches between the amount of food consumed as feed in countries and the amount produced.  This script disperses this excess feed based on relative global production. 

Inputs:
* country_system_crop_tonnes_feedproduced.csv (from: 6.3_mapspam_prop_for_feed.Rmd)
* MAPSPAMcrop_production.csv (from: 1.1_MAPSPAM_production.Rmd)

Outputs:
* proportion_feed_per_country_system.csv
* raster for each crop and animal system describing proportion of crop consumed by system in each country.

## 6.5_human_consumption_prop_maps.Rmd
GOAL: Assume crops not consumed as feed are going to humans.

Inputs:
* proportion_feed_per_country_system.csv (from: 6.4_redistributing_feed_overshoot_and_prop_mapspam.Rmd)

Outputs:
* raster for each crop describing proportion of crop consumed by humans in each country.
