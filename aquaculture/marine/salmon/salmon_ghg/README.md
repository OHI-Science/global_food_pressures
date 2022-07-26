# salmon_ghg

Calculate the ghg emissions of salmon farming. We used [Parker *et al.* 2020](http://seafoodco2.dal.ca/)'s data to extract ghg emissions associated with live weight of salmon from salmon farming. One factor that we considered adding was aquatic N<sub>2</sub>O emissions as discussed in [Hu *et al*., 2012](https://pubs.acs.org/doi/full/10.1021/es300110x) and [MacLoid *et al*., 2019](http://www.fao.org/3/ca7130en/ca7130en.pdf).

## Scripts
|File Name|Description|Output|
|---	|---	|---	|
|STEP1_ghg_emissions.Rmd|Using Parker 2020 data and our salmon distribution, we calculate and map ghg emissions from salmon aquaculture globally.| |
  
## Data 
|File Name|Processing Extent|Description|Source|
|---	|---	|---	|---	|
|Specie_List_-_11_24_2020,_11_39_21_AM_Farmed.csv"; Units: kg CO<sub>2</sub>-eq / live-weight tonne of salmon produced.|Seafood Carbon Emissions Tool; [Parker *et al.* 2020](http://seafoodco2.dal.ca/) |
| |Final dataset|ghg emissions measured in tCO<sub>2</sub>-eq/tLW |Output from STEP1_ghg_emissions.Rmd|

## Contributors
[Paul-Eric Rayner](rayner@nceas.ucsb.edu)    
@prayner96  

Juliette Verstaen

[Gage Clawson](clawson@nceas.ucsb.edu)
@gclawson1