# Data Description
********************

## Added externally to folder
| File Name | Description |
|:----------:|:-------------:|
|**herd_GLEAMi.csv** | Data set scraped from the GLEAM website |
|**LSU_Coeffs_by_Country.csv** | Livestock Units for each country animal. A SI file on FAOSTAT Agri-Environmental Indicators-Livestock Patterns http://www.fao.org/faostat/en/#data/EK|
|**fao_codes_country.xlsx** | FAO country codes | 
|**space_rec.csv** | Minimum space requirements for mixed ruminants and backyard pigs and chickens |
|**livestock_conversion_values.csv** | Space requirements for industrial chickens, pigs, and accounting for non animal filled farm space |

## Created in Markdowns
| File Name | Description |
|:----------:|:-------------:|
|**across_country_conversions.csv** | Gapfilled version os LSU_Coeffs_by_Country.csv; created in STEP1_across_country_conversions.Rmd|
|**chicken_pigs_live_weights.csv** | head to liveweight conversion values; created in STEP2 |
|**grazing_ruminant_feed_intake.csv** | Gapfilled yearly ruminant feed intake rates, calcualted from ruminants_GLEAMi_v2.csv; calculated in STEP7 |
|**livestock_area_head_table.csv** | Country specific data set of disturbance value/head created using space_rec.csv and across_country_conversions.csv; created in STEP1 |


