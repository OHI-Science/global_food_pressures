# Crop Nutrient

Map nutrient leaching stressor. Fertilizer use data is extracted from FAOSTAT and we allocate that spatially using our MapSPAM data. Ten percent of fertilizer use was assumed to have leached in the raster cell it was applied.

## Scripts
|File Name|Description|Output|
|---	|---	|---	|
|step1_crop_nutrient_wrangling|Wrangle FAOSTAT fertilizer use by nutrient data and map using MapSPAM crop allocation.|nutrient_df.csv|
|step2_crop_nutrient_mapping|Map fertilizer application and leaching. Leaching is assumed to be 10% of fertilizer application.|file.path(prep, "crop_nutrient/crop_lent_nutrient.tif")|

## Data 
|File Name|Processing Extent|Description|Source|
|---	|---	|---	|---	|
|FAOSTAT_2016_nutrient_agri_use.csv|Raw|FAOSTAT category selection: 2016; Fertilizer by Nutrient; Agricultural use; All countries. Extracted: 3/4/2020. Nutrients are nitrogen (N), phosphate (P<sub>2</sub>O<sub>5</sub>) and potash (K<sub>2</sub>O)|FAOSTAT database: Fertilizer input.|
|nutrient_df.csv|Intermediate dataset|Fertilizer use (tonnes) by iso3c, crop and production system|Output from step1_crop_nutrient_wrangling|
|IFA_2017_FUBC_pc_archive.csv|Raw|Crop-specific percentages for each country in 2014/15. Archived because we couldn't integrate this dataset with our data.|International Fertilizer Association 2014/15 fertilizer use report: ["Assessment of Fertilizer Use by Crop at the Global Level"](https://www.fertilizer.org/images/Library_Downloads/2017_IFA_AgCom_17_134%20rev_FUBC%20assessment%202014.pdf).|

## Contributors
[Paul-Eric](rayner@nceas.ucsb.edu)      
@prayner96  