# Crop Disturbance

Map proportion of each raster cell that is 'disturbed' by crop production. Calculated by dividing cropland physical area by raster cell area.

## Scripts
|File Name|Description|Output|
|---	|---	|---	|
|disturbance_calculator.Rmd|Map proportion of each raster cell that is 'disturbed' by crop production|final_path/crop_"crop name"_disturbance.csv * 42 crops|

## Data 
|File Name|Processing Extent|Description|Source|
|---	|---	|---	|---	|
|/home/shares/food-systems/Food_footprint/all_food_systems/dataprep/crop/farm/MapSPAM_correct_extent/spam2010V1r1_global_A_"crop name"_A.tif|Modified: raster extent is fixed|MapSPAM physical area maps.| International Food Policy Research Institute, 2019, "Global Spatially-Disaggregated Crop Production Statistics Data for 2010 Version 1.1", https://doi.org/10.7910/DVN/PRFF8V, Harvard Dataverse, V3|

## Contributors
[Paul-Eric](rayner@nceas.ucsb.edu)
@prayner96