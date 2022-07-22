# Crop Farm

This folder organizes crop maps using MapSPAM data as a foundation for calculating the stressors associated with feed crops. The scripts follow a step-by-step approach to harmonizing crop codes in MapSPAM to FAOSTAT data we'll be using in the analyses, scaling the crop production data to the year 2016 and understanding how crop production varies within each country.

## Primary script: [MapSPAM_synthesis.Rmd](https://github.com/cdkuempel/food_chicken_salmon/blob/master/crop_farm/MapSPAM_synthesis.Rmd)

## Scripts
|File Name|Description|Output|
|---	|--- |---	|
|step1_MapSPAM_verification|Verification for GitHub issue #98 regarding raster extent problem|None|
|step2_MapSPAM_wrangling|Harmonizing MapSPAM names and FAO crop codes|MapSPAM_names.csv|
|step3_MapSPAM_scaling_2010_to_2016|Rescale MapSPAM data to year 2016|scaling_coef.csv|
|step4_MapSPAM_synthesis|Map crop production coefficients from 2010 to 2016; <br> Scale MapSPAM rastermaps to 2016; <br> Calculate how much of the crop's production is allocated to each cell.| crop_farm/coefficients/ * 42 crops; <br> crop_farm/scaled_maps_2016/ * 42 crops * 5 production systems; <br> crop_farm/cell_allocation/ * 42 crops * 5 production systems|
|step5_MapSPAM_analysis|Produce a dataframe with total production for each crop and iso3c; <br> Measure proportion of SPAM production to FAOSTAT production; <br> Checking data for island nations without production|prod_crop.csv <br> prod_crop_rgns.csv|

## Data 
|File Name|Process Extent|Description|Source|
|---	|--- |---	|---	|
|FAOSTAT_crop_production_2010_2016.csv|Raw|Crop production data extracted for year 2010 and 2016.|FAOSTAT database: crop production.|
|SI_SPAM_crops_tbl.csv|Modified|Table for Supp. Info showing SPAM crops and their respective FAOSTAT code.|Output from step 2.|
|MapSPAM_crop_info.csv|Raw|Dataset extracted from MapSPAM with FAO codes for each SPAM crop category.|[MapSPAM methodology webpage](https://www.mapspam.info/methodology/).|
|scaling_coef.csv|Modified|Crop production (2010-2017) coefficients by SPAM crop category.|Output from step 3.|
|prod_prop.csv|Modified|Crop production proportions for each production system, iso3c, and crop.|Output from step 5.|
|prod_crop_rgns.csv|Crop production in tonnes for each production system, iso3c, and crop.|Output from step 5.|

## Contributors
[Paul-Eric](rayner@nceas.ucsb.edu)      
@prayner96  