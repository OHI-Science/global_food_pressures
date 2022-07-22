###Data###

burning_parameters.csv is the gapfilled version of the burning parameters listed in the 1996 IPCC Guidelines or National Greenhouse Gas Inventories. This dataset is created in burning_parameters.Rmd and used in ghg_residue_burning.Rmd to calculate emissions from crop residue burning

co2_eq_fators.csv included conversion factors for calcualting CO2 eq values from CH4 and N2O

developed_regions.csv is a dataframe created used the World Bank Organization designating regions as developed or not. It is created in developed_regions.Rmd

FAO_burned folder houses fao_burned.csv (downloaded from FAOSTAT crop residue burning) and fao_total_production.csv (downlowed from FAOSTAT agrocultural production) These data are used to compare the values we calculated for crop residue burning using a differnent method. Comparions are done in ghg_residue_burning.Rmd

farm_mach_activities_em.csv is a dataset we created based off of Lal 2004. It includes averages for carbon emission factors for various farming activities and the proportion they are used in high irrigated versus high rain fed cropland systems. This data is created in machinery_factors.Rmd and used in ghg_farm_machinery.Rmd to caculate emissions from cropland farming activities. 

ghg_em_ratio.csv contains values for emissions ratio to convert total carbon released to either CH4, CO, N2O, and NOx. Pulled from 996 IPCC Guidelines or National Greenhouse Gas Inventories.

ghg_factors_crop_residue_burning.csv 

irrigation_type_proportions.csv

machinery_em.csv

mapspam_crops.csv