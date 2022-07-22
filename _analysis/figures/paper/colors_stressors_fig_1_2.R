## color pallets for figure 1b maps of total stressor in each cell and for figure 2 ranking country radial plot

library(RColorBrewer)
library(colorspace)

dis <- "#D5BD75"
ghg <- "#DA6098"
nut <- "#795B48"
wat <- "#77C1D7"
light_gray <- "#F8F9FA"
white <- "#FFFFFF"

# DISTURBANCE

d1 <- "#4E3823"
d0 <- colorspace::lighten(d1, amount = -0.7)
d2 <- "#B58B64"
d3 <- "#C68C5A"
d4 <- "#CD9D5F"
d5 <- "#DB983D"
d6 <- "#F7DF9A"
d7 <- "#F7F298"
d8 <- "#F7F3B0"
d9 <- colorspace::lighten(d8, amount = 0.7)

dist <- c(d0, d1, d2, d3, d4, d5, d6, d7, d8, d9)
dist_palette <-  rev(colorRampPalette(dist, space="Lab", bias = 0.8)(10000))  ## bias = 0.3
dist_palette <- c(white, dist_palette)
par(mar=c(1,1,1,1))
image(volcano, asp=1, col=dist_palette)



# GHG

g1 <- "#460561"
g0 <-  colorspace::lighten(g1, amount = -0.5)
g2 <- "#660F63"
g3 <- "#841276"
g4 <- "#841276"
g5 <- "#DA3AB9"
g6 <- "#F16BE2"
# g7 <- colorspace::lighten(g6, amount = 0.2)
# g8 <- colorspace::lighten(g6, amount = 0.5)
# g9 <- colorspace::lighten(g6, amount = 0.8)
g10 <- colorspace::lighten(g6, amount = 0.95)

mag_pal <- c(g0,g1, g2, g3, g4, g5, g6, g10) # g7, g8, g9,

ghg_palette  <-  c("white" , rev(colorRampPalette(mag_pal, space="Lab", bias = 1)(10000))) # bias = 0.5
par(mar=c(1,1,1,1))
image(volcano, asp=1, col=ghg_palette)

## NUTRIENTS

# n1 <- "#2C140A"
# n0 <- colorspace::lighten(n1, amount = -0.5)
# n2 <- "#4E3019"
# n3<- "#7E5F4C"
# n4 <-"#9F866E"
# n5 <- "#B2A18A"
# n6 <- "#CBAE88"
# n7 <- "#CBAE88"
# n8 <- colorspace::lighten(n7, amount = 0.9)
# nut_pal <- c(n0, n1,n2, n3, n4, n5, n6, n7, n8)


n1 <- "#68114F"
n0 <-  colorspace::lighten(n1, amount = -0.8)
n2 <- "#850232"
n3 <- "#9E1818"
n4 <- "#B14B22"
n5 <- "#E27927"
n6 <-  colorspace::lighten(n5, amount = 0.95)

nut_pal <- c(n0, n1, n2, n3, n4, n5, n6)
nut_palette  <-  c("white" , rev(colorRampPalette(nut_pal, space="Lab", bias = 1)(10000)))
par(mar=c(1,1,1,1))
image(volcano, asp=1, col=nut_palette)


w1 <- "#000F3E"
w2 <- "#103E65"
w3 <- "#1C5D92"
w4 <- "#399BBA"
w5 <- "#55DAE7"
w6 <- colorspace::lighten(w5, amount = 0.3)
w7 <- colorspace::lighten(w5, amount = 0.8)

wat_c <- c(w1, w2, w3, w4, w5, w6, w7)
wat_palette  <-  c("white" , rev(colorRampPalette(wat_c, space="Lab", bias = 1)(10000))) # bias = 0.5
par(mar=c(1,1,1,1))
image(volcano, asp=1, col=wat_palette)


