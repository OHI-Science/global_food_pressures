## color pallets for figure 1b maps of total stressor in each cell and for figure 2 ranking country radial plot

library(RColorBrewer)
library(colorspace)

dis <- "#D5BD75"
ghg <- "#DA6098"
nut <- "#795B48"
wat <- "#77C1D7"
light_gray <- "#F8F9FA"
white <- "#FFFFFF"

# disturbance
dis_1 <- colorspace::lighten(dis, amount = -0.8)
dis_2 <- colorspace::lighten(dis, amount = -0.4)
dis_3 <- colorspace::lighten(dis, amount = 0.2)
dis_4 <- colorspace::lighten(dis, amount = 0.4)
dis_5 <- colorspace::lighten(dis, amount = 0.95)

dist_palette <- c(dis_5, dis_4, dis_3, dis, dis_2, dis_1)
dist_palette <-  colorRampPalette(dist_palette, space="Lab", bias = 1.5)(10000)
dist_palette <- c(white, dist_palette)
par(mar=c(1,1,1,1))
image(volcano, asp=1, col=dist_palette)

# ghg
ghg_1 <- colorspace::lighten(ghg, amount = -0.8)
ghg_2 <- colorspace::lighten(ghg, amount = -0.4)
ghg_3 <- colorspace::lighten(ghg, amount = 0.2)
ghg_4 <- colorspace::lighten(ghg, amount = 0.4)
ghg_5 <- colorspace::lighten(ghg, amount = 0.95)

ghg_palette <- c(ghg_5, ghg_4, ghg_3, ghg, ghg_2, ghg_1)
ghg_palette <-  colorRampPalette(ghg_palette, space="Lab", bias = 2)(10000) #  
ghg_palette <- c(white, ghg_palette)
par(mar=c(1,1,1,1))
image(volcano, asp=1, col=ghg_palette)

# nut
nut_1 <- colorspace::lighten(nut, amount = -0.8)
nut_2 <- colorspace::lighten(nut, amount = -0.4)
nut_3 <- colorspace::lighten(nut, amount = 0.2)
nut_4 <- colorspace::lighten(nut, amount = 0.4)
nut_5 <- colorspace::lighten(nut, amount = 0.95)

nut_palette <- c(nut_5, nut_4, nut_3, nut, nut_2, nut_1)
nut_palette <-  colorRampPalette(nut_palette, space="Lab", bias = 2)(10000)
nut_palette <- c(white, nut_palette)
par(mar=c(1,1,1,1))
image(volcano, asp=1, col=nut_palette)

# wat
wat_1 <- colorspace::lighten(wat, amount = -0.8)
wat_2 <- colorspace::lighten(wat, amount = -0.4)
wat_3 <- colorspace::lighten(wat, amount = 0.2)
wat_4 <- colorspace::lighten(wat, amount = 0.4)
wat_5 <- colorspace::lighten(wat, amount = 0.95)


wat_palette <- c(wat_5, wat_4, wat_3, wat, wat_2, wat_1)
wat_palette <-  colorRampPalette(wat_palette, space="Lab", bias = 2)(10000)
wat_palette <- c(white, wat_palette)
par(mar=c(1,1,1,1))
image(volcano, asp=1, col=wat_palette)


## adapt for figure 2
dist_1 <- "#D5BD75"
dist_1 <- lighten(dist_1, amount = -0.05)
dist_2 <- "#FFEAB1"
dist_2 <- lighten(dist_2, amount = -0.05)

ghg_1 <- "#DA6098"
ghg_1 <- lighten(ghg_1, amount = -0.05)
ghg_2 <- "#FFCEE0"
ghg_2 <- lighten(ghg_2, amount = -0.05)

nut_1 <- "#795B48"
nut_2 <- "#E7C7B5"

wat_1 <- "#3E638E"
wat_2 <- "#C5F0FF"

jv_palette <- c(dist_1, ghg_1, nut_1, wat_1,
                dist_2, ghg_2, nut_2, wat_2)
scales::show_col(jv_palette, n = 4)
#dist, ghg, water, nut

pal_df <- as_tibble(jv_palette) %>% 
  rename(fill_value = value) %>% 
  mutate(source = case_when(fill_value == dist_1 ~ "land-disturbance",
                            fill_value == dist_2 ~ "ocean-disturbance",
                            fill_value == wat_1 ~ "land-water",
                            fill_value == wat_2 ~ "ocean-water",
                            fill_value == nut_1 ~ "land-nutrient",
                            fill_value == nut_2 ~ "ocean-nutrient",
                            fill_value == ghg_1 ~ "land-ghg",
                            fill_value == ghg_2 ~ "ocean-ghg")) 

