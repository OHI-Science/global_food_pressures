# Data Description
********************

## Added externally to folder
| File Name | Description |
|:----------:|:-------------:|
|**FAOSTAT_enteric_fermentation.csv** | FAO reported enteric fermentation totals; used to check our results |
| **GLEAM_rgn_to_country.csv** | Key for GLEAM named regions and this project's regions |
| **gleam_table_4.15_ef_dir.csv** | Table 4.15 from the GLEAM methods document |
| **gleam_table_4.16_frac_gas.csv** |Table 4.16 from the GLEAM methods document |
| **gleam_table_4.17_frac_leach.csv** | Table 4.17 from the GLEAM methods document|


## Created in Markdowns and R scripts
| File Name | Description |
|:----------:|:-------------:|
| **compiled_gleam_tables.csv** | All GLEAM tables (4.15-.17) in one file and gapfilled; created in STEP1 |
| **methane_em_rates_gf.csv** | Calculated emissions rate from GLEAM enteric fermentation data; created in STEP4 |
| **mms_specific_percentages.csv** | Wrangled data set of manure management system percentages; created in gleam_extract_manure.R |
| **nitrogen_excretion_rates.csv** | Wrangled data set of nitrogen excretion rates; created in nitrogen_excretion_rates.R|

| Folder Name | Description |
|:----------:|:-------------:|
| **manure_n2o_emissions** | Contains rates for the 3 sources of N2O emissions for each livestock system; separated out into 3 folders: direct N2O (dir_n2o_manure_rates), leaching N2O (leach_n2o_manure_rates), and volatized N2O (vol_n2o_manure rates) |

