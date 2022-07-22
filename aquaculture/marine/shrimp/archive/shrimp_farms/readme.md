To recreate the maps the following codes are used in this order:

1. fao_shrimp_production.Rmd : Clean FAO production data
2. shrimp_farm_locations.Rmd : cleans lat/long information for shrimp farms (in some cases we have farms, in other cases we have no information on individual farms and we use generic points to save the data)
3. rasterize_production.Rmd.Rmd : this distributes country (or, regional) production data to farms and creates a raster layer with each raster indicating tonnes/production

