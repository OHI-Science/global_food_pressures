# Animal GHG

This folder contains the scripts for calculated GHG emissions from livestock. Sources included in analysis are: N2O from manure, CH4 from manure, enteric fermentation, and direct energy use. 

## Scripts
| File Name | Description | Output |
|:----------:|:-------------:|:------:|
| STEP1_gleam_tables_wrangling.Rmd | Wrangles the GLEAM tables of provided values to use in the modeling equations|compiled_gleam_tables.csv |
| STEP2_animal_ghg_manure_n2o.Rmd | Calculated N2O emissions using GLEAM models | Rasters of CO2-eq of N2O for each of our livestock systems|
| STEP3_animal_ghg_manure_ch4.Rmd | Calculated CH4 emissions for each livestock system by calcalating a CO2eq/head rate from GLEAM data | Rasters of CO2-eq of CH4 for each of our livestock systems|
| STEP4_animal_ghg_enteric_fermentation.Rmd | Calculated methane emissions for each livestock system by calcalating a CO2eq/head rate from GLEAM data | Rasters of CO2-eq of enteric fermentation for each of our livestock systems|
| STEP5_animal_ghg_direct_energy_use.Rmd |Calculated N2O emissions using GLEAM models | Rasters of CO2-eq of N2O for each of our livestock systems|
| STEP6_compile_animal_ghg.Rmd | Combine all GHG emissions into the final layer | Rasters of total CO2-eq for each of our livestock systems |

## In *R_scripts* folder
| File Name | Description | Output |
|:----------:|:-------------:|:------:|
| gleam_extract_manure.R | Wrangles the web scraped GLEAM data of manure system percentages by animal and country | mms_specific_percentages.csv |
| nitrogen_excretion_rates.R | Wrangles the web scraped FAO data of nitrogen excretion by animal and country | nitrogen_excretion_rates.csv |

## Contributors
Juliette Verstaen