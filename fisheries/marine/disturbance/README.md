# Marine Fisheries Disturbance

### Folder description
This folder contains the data prep to calculate global habitat disturbance caused by marine fishing. Note that some of the files called upon in this prep were created in the ghg dataprep, meaning marine fisheries ghg dataprep should be completed first. 


## Scripts

|File Name|Description|Output|
|---	|---	|---	|
|STEP1_NPP_prep.Rmd | Gapfill NPP rasters which will be used to account for low vs high productivity fishing areas | annal_mean_npp_2015_gf_wgs.tif |
|STEP2a_GFWdata_prep.Rmd | Create maps of destructive fishing effort based of GFW data |  FishingWatch_annual_effort_dredge_2017.tif; FishingWatch_annual_effort_trawlers_2017.tif |
|STEP2b_classify_gear_type.Rmd | Classify different species and gear types as dem/pel, dest/non-dest, and high/low bycatch |  taxa_gear_types.csv |
|STEP2c_prep_watson_catch_df.Rmd | Here we prep the Watson fisheries data to be classified into the correct species classes, and save as a csv. | catch_with_gear_cats.csv; catch_spp_class_2017.csv |
| STEP3_create_prop_rasters.Rmd | Prep many different rasters that will be used for disturbance calculations | trawl_proportion_raster.tif; ben_hab_dest_prop_%s.tif; catch_all_spp.tif; catch_%s_spp.tif |
| STEP4a_correct_trawl_combine_with_dredge.Rmd | Correct trawl to include only the demersal destructive portion of trawling. Combine the hours effort for the corrected trawl data to hours effort for dredge data to get total effort | FishingWatch_annual_effort_destructive_hours_2017.tif |
| STEP4b_habitat_destruction_rescale.Rmd | Rescale the habitat destruction data and partition between marine fisheries food groups. | benthic_habitat_destruction_%s |
| STEP4c_biomass_removal_raster.Rmd | Estimate biomass removal for marine fisheries | biomass_removal_%s.tif |
| STEP5_combine_disturbance_metrics.Rmd | Combine the two metrics (habitat destruction and biomass removal) of marine fisheries disturbance | marine_%s_fisheries_meat_disturbance.tif |


## List of relevant GitHub issues
[303](https://github.com/OHI-Science/global_food_issues/issues/303)

## Contributors
Name of main authors.
Gage Clawson and Melanie Frazier