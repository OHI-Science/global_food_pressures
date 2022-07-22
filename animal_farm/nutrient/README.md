# Animal Nutrient

This folder contains all the scripts and data produced from creating rasters of P leaching, N leaching, and N volatization from livestock animal systems.


## Scripts
| File Name | Description | Output |
|:----------:|:-------------:|:------:|
| STEP0_calc_N_excretion.Rmd | Uses FAOSTAT N excreted in manure data to calculate excretion rates for livestock.| excretion_rate_gf.csv |
| STEP1_create_n_P_excretion_rasters.Rmd | Creates rasters for all livestock system of 1) amount of N excreted in manure and 2) amount of P excreted in manure. | N and P rasters for all livestock systems in the prep data folder |
| STEP2_manure_P_leaching_rasters. Rmd | Creates rasters for amount of P leached from livestock manure. | P leached rasters for all livestock systems in the prep data folder |
| STEP3_prop_manure_leaching_mms.Rmd | Creates rasters for the proportion of initial manure N that is leached during active manure management systems| Prop N leached during mms rasters for all livestock systems in the prep data folder|
| STEP3.5_prop_manure_volt_mms.Rmd | Creates rasters for the proportion of initial manure N that is volatized during active manure management systems| Prop N volatized during mms rasters for all livestock systems in the prep data folder |
| STEP4_prop_manure_applied_pasture.Rmd | Creates rasters for the proportion of initial manure N that is applied to soils and also that is left on pastures| Prop N applied to soils rasters; Prop N left on pastures rasters for all livestock systems |
| STEP5_prop_manure_volt_mms.Rmd | Creates rasters for 1) the proportion manure that leaches after being applied to soils and 2) the proportion of manure that volatizes after being applied to soils| Creates rasters for the proportion of N leached and volatized from manure applied to soils |
| STEP5.5_prop_manure_leaching_volt_applied pastures.Rmd | Creates rasters for 1) the proportion manure that leaches after manure that has been through mms is then applied to pastures  2) the proportion manure that volatizes after manure that has been through mms is then applied to pastures| Creates rasters for the proportion of N leached and volatized from being applied to pastures |
| STEP6_prop_manure_leaching_pastures.Rmd | Creates rasters for 1) the proportion manure that leaches when left on pastures 2) the proportion manure that volatizes when left on pastures | Creates rasters for the proportion of N leached and volatized from being left on pasture |
| STEP7_total_N_leach_volatize.Rmd | Combines all the sources of manure volatization for each livestock system | Creates rasters all livestock systems volatization |
| STEP8_combine_all_nutrients.Rmd | Combines all the sources of excess nutrients (N leaching, P leaching, and N volatizing | Creates rasters all livestock systems nutrient inputs |


## Contributors
Juliette Verstaen