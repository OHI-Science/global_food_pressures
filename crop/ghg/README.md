# Crop GHG

Map greenhouse gas emissions stressor from feed crops. All final units are standardized as tonnes of CO<sub>2</sub>-equivalent.

## Primary script: [crop_ghg_totals]()
Aggregates all crop ghg layers and maps total emissions from crop feed.

## Scripts
|File Name|Description|Output|
|---	|---	|---	|
|stepX_crop_ghg_fertilizer_production_and_transport.Rmd|Map ghg emissions from production and transport of fertilizers. Using nutrient df from ~/crop_nutrient/ and emission factors from FAO LEAP 2017.|1. crop_ghg/crop_nutrient_ghg/: 38 crops <br /> 2. crop_ghg/crop_nutrient_ghg/: 38 crops x (3+1) nutrient types = 152 maps <br /> 3. nutrient_EF.csv |
|stepX_crop_ghg_pest.Rmd|Map pesticide emissions. We used Lal (2004) values for herbicide, insecticide and fungicide emission factors. All other pesticide types in FAOSTAT were assumed to have an emission factor of 25.5 kg CO<sub>2</sub>-eq based on LEAP (2017) (whom quote Audley *et al*., 2009).|crop_ghg/crop_pesticide_ghg/: 38 crops|

## Data 
|File Name|Processing Extent|Description|Source|
|---	|---	|---	|---	|
|nutrient_EF.csv|Final dataset|Provides CO<sub>2</sub>-eq tonnes for each iso3c and nutrient type.|Output from stepX_crop_ghg_fertilizer_production_and_transport.Rmd|
|pesticide_df.csv|Final dataset|Provides CO<sub>2</sub>-eq tonnes for each iso3c and crop.|Output from stepX_crop_ghg_pest.Rmd|
|FAO_2017_LEAP_EF.csv|Modified dataframe from research article table|Emission factors for nitrogen (N), phosphate (P<sub>2</sub>O<sub>5</sub>) and potash (K<sub>2</sub>O) and lime.|Extracted from [FAO LEAP 2017](http://www.fao.org/partnerships/leap/database/ghg-crops/en/)|
|FAOSTAT_pesticide_use.csv|Raw|Pesticide use for agricultural use. <br /> Year: 2016.  <br /> Unit: tonnes.|Accessed: 05/08/2020 from FAOSTAT database|

## Contributors
Juliette

[Paul-Eric](rayner@nceas.ucsb.edu)      
@prayner96  

####README####

**markdowns wrangling and creating df to use to calculate emissions using raster maps**

burning_parameters.Rmd takes the raw parameters for crop burning from various crops detailed in the IPCC and gap fills missing values

developed_countries.Rmd creates a df of our masters regions list and assigns them to either developed or non developed category based on of World Bank Organization cut offs

machinery_factors.Rmd this markdown creates a df of carbon emission factors from on farm maintaince for each of our crops for high irrigated and high rain fed croplands

**Code that actually creates the ghg emission rasters**
ghg_residue_burning.Rmd takes the burning parameters, developed_countries data, and MAPSPAM production data to caculate emissions from crop residue burning using IPCC tier 1 methods.

ghg_farm_machinery.Rmd takes the machinery factors and the MAPSPAM cropland area data to calcualte emissions from on farm cropland maintence due to machinery use

ghg_irrigation.Rmd calculates the proportion of croplands that are irrigation with flood vs sprinkler systems for each country based on ICID data, and then uses the water foot print data and emissions factors for the two irrigation systems to caculate emissions based on cropland irrigation (not including installation of irrigation systems)







