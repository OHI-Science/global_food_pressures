# Marine Fisheries Disturbance

### Folder description
This folder contains the data prep to calculate global habitat disturbance caused by marine fishing. Note that some of the files called upon in this prep were created in the ghg dataprep, meaning marine fisheries ghg dataprep should be completed first. 


## Scripts

|File Name|Description|Output|
|---	|---	|---	|
|STEP1_NPP_prep.Rmd | Gapfill NPP rasters which will be used to account for low vs high productivity fishing areas | annal_mean_npp_2015_gf_wgs.tif |
|STEP2_classify_gear_type.Rmd | Classify different species and gear types as dem/pel, dest/non-dest, and high/low bycatch |  taxa_gear_types.csv |
|STEP3_marinefisheries_disturbance.Rmd | Calculate disturbance for all marine fisheries catch from 2017 |  all_marine_fisheries_disturbance_v2.tif |
|STEP4_large_pelagic_disturbance.Rmd | Calculate disturbance for large pelagic marine fisheries from 2017 | marine_large-pelagic_fisheries_meat_disturbance.tif|
|STEP5_medium_pelagic_disturbance.Rmd | Calculate disturbance for medium pelagic fisheries from 2017 | marine_medium-pelagic_fisheries_meat_disturbance.tif |
|STEP6_small_pelagic_disturbance.Rmd | Calculate disturbance for small pelagic fisheries from 2017 | marine_small-pelagic_fisheries_meat_disturbance.tif |
|STEP7_demersal_disturbance.Rmd | Calculate disturbance for demersal fisheries from 2017 | marine_demersal_fisheries_meat_disturbance.tif |
|STEP8_benthic_disturbance.Rmd | Calculate disturbance for benthic fisheries from 2017 | marine_benthic_fisheries_meat_disturbance.tif  |
|STEP9_reef_associated_disturbance.Rmd | Calculate disturbance for reef associated fisheries from 2017 | marine_reef_fisheries_meat_disturbance.tif |
|STEP10_feedfish_disturbance.Rmd | Calculate disturbance for fofm marine fisheries from 2017 | marine_fofm_fisheries_meat_disturbance.tif |


## List of relevant GitHub issues
[202](https://github.com/OHI-Science/global_food_issues/issues/202)

## Contributors
Name of main authors.
Gage Clawson and Melanie Frazier