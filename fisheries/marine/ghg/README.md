# Marine Fisheries GHG

### Folder description
This folder contains the data prep to calculate global greenhouse gas emissions from marine fisheries. 


## Scripts
|File Name|Description|Output|
|---	|---	|---	|
|STEP1_download_watson_data.Rmd | Download the fisheries data to aurora |  Fisheries data saved on aurora |
|STEP2_emissions_intensities.Rmd | Calculate the emissions intensity estimates from FUI values provided by the [Seafood Carbon Emissions Tool](http://seafoodco2.dal.ca/) |  Global fisheries emissions per species |
|STEP3_catch_data_prep.Rmd | Prep the catch data so that we can calculate both FOFM and all catch emissions |  Prepped catch data |
|STEP4_match_watson_parker.Rmd | Match the catch data with the emissions intensity estimates | Catch data with estimates of emissions intensities attached to each observation |
|STEP5_gapfill_ei.Rmd | Gapfill the emissions intensities which are NAs |  Catch data with estimates of emissions intensities attached to each observation |
|STEP6_marine_fisheries_ghg_final.Rmd | Create raster maps of global emissions |  Global emissions rasters for fofm catch and all catch minus fofm |


## List of relevant GitHub issues
[9](https://github.com/OHI-Science/global_food_issues/issues/9)

## Contributors
Name of main authors.
Gage Clawson and Melanie Frazier
