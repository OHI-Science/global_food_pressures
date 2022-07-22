#Salmon occupancy and area data details

##Juliette Verstaen

## `data` folder directory

******************************************************************

`salmon_occupancy.csv`
- This file is calculated in occupancy_area.Rmd
- salmon_num_live are number of salmon that are currently alive being grown in the water at the farms. The conversion factor for this calculation was determined through Norway aquaculture data linear regression in the [salmon_tonnes_to_livestock_conversion.Rmd](https://github.com/cdkuempel/food_chicken_salmon/blob/master/salmon_occupancy/salmon_tonnes_to_livestock_conversion.Rmd)
- total_area_m2 is the total top view area of salmon production and facilities

`salmon_conversion_factors.csv`
This file is a compiled list of values and parameters necessary for our calculations regarding salmon aquaculture. It includes sources

`fish_edible_weight_conversion.xlsx`
This file is a table of conversion factors for various fish species to convert between edible and production weight

`all_salmon_norway.csv`
This file includes data downloaded from [Statistics Norway](https://www.ssb.no/en/statbank/table/09259/) and other values calculated from it and the conversion factors data