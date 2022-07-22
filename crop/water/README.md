# Crop Water

The primary aim was to map the water consumption stressor for crops. We do this by extracting the WF for each FAO crop and FIPS code in Mekonnen & Hoekstra (2011) appendix 2 (or report 47 of the WFN). I used FAOSTAT's polygon to map FIPS codes accordingly, although a couple of US states were mixed up. The secondary aim was to map irrigation for each crop.

## Scripts
|File Name|Description|Output|
|---	|---	|---	|
|step1_crop_water_wrangling.Rmd|Wrangle Mekonnen and Hoekstra 2011 Appendix table 2 dataset. Produce df that we can use to map water consumption and irrigation for each crop and iso3c.|global_average.csv <br> wf_df.csv <br> wf_df_irrigation.csv|
|step2_crop_water_mapping.Rmd|Map WF of feed crops. Gapfill using national average when state-level WF is missing, or global average when neither are available.|crop_water/water_footprint/crop_<crop>_water.tif; |
|step2_crop_water_mapping_archive.Rmd|Previous version crop_water_mapping||
|step3_crop_irrigation_mapping.Rmd|Calculate blue water footprint using MapSPAM irrigation layer. No gapfilling.|crop_water/irrigation/crop_<crop>_irrigation.tif|

## Data 
|File Name|Processing Extent|Description|Source|
|---	|---	|---	|
|Report47_Appendix_II.csv|Modified spreadsheet for use in R|Water footprint for all FAO crops and mapped using FIPS codes|Extracted from [Report 47](https://waterfootprint.org/media/downloads/Report47-WaterFootprintCrops-Vol2.pdf).|
|Report47_Appendix_II_codes.csv|Modified spreadsheet for use in R|This is the same as "Report47_Appendix_II.csv" except it has the FIPS codes for each state which we can map using polygons, rather than the character names. These are hidden in the original excel sheet as the rows are written in white font.|Extracted from [Report 47](https://waterfootprint.org/media/downloads/Report47-WaterFootprintCrops-Vol2.pdf). |
|global_average.csv|Final dataset|Global WF average measured in m3/ton for each SPAM crop.|Output from step1_crop_water_wrangling.Rmd|
|wf_df.csv|Final dataset|Complete dataset with WF for all regions and SPAM crops|Output from step1_crop_water_wrangling.Rmd|
|wf_df_irrigation.csv|Final dataset|Blue WF dataset used to map irrigation ghg emissions (See /crop_ghg_irrigation/) from SPAM crops.|Output from step1_crop_water_wrangling.Rmd|

## Contributors
[Paul-Eric](rayner@nceas.ucsb.edu)      
@prayner96  