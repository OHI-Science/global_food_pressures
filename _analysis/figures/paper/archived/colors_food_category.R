

library(RColorBrewer)
library(colorspace)
library(scales)

## colors

light_green <- c("#428D87")
light_green_1 <- colorspace::lighten(light_green, amount = 0.9)
light_green_2 <- colorspace::lighten(light_green, amount = -0.25)
scales::show_col(c(light_green,light_green_1, light_green_2))
light_green_grad <- colorRampPalette(c(light_green_1, light_green_2))(4)
scales::show_col(light_green_grad)

dark_green <- c("#2B5F3D")
dark_green_1 <- colorspace::lighten(dark_green, amount = 0.9)
dark_green_2 <- colorspace::lighten(dark_green, amount = -0.25)
scales::show_col(c(dark_green,dark_green_1, dark_green_2))
dark_green_grad <- colorRampPalette(c(dark_green_1, dark_green_2))(4)
scales::show_col(dark_green_grad)

dark_blue <- c("#08283D")
dark_blue_1 <- colorspace::lighten(dark_blue, amount = 0.9)
dark_blue_2 <- colorspace::lighten(dark_blue, amount = -0.25)
scales::show_col(c(dark_blue,dark_blue_1, dark_blue_2))
dark_blue_grad <- colorRampPalette(c(dark_blue_1, dark_blue_2))(4)
scales::show_col(dark_blue_grad)

purple <- c("#72224F")
purple_1 <- colorspace::lighten(purple, amount = 0.9)
purple_2 <- colorspace::lighten(purple, amount = -0.5)
scales::show_col(c(purple,purple_1, purple_2))
purple_grad <- colorRampPalette(c(purple_1, purple_2))(4)
scales::show_col(purple_grad)

red <- c("#AD2D37")
red_1 <- colorspace::lighten(red, amount = 0.6)
red_2 <- colorspace::lighten(red, amount = -0.3)
scales::show_col(c(red,red_1, red_2))
red_grad <- colorRampPalette(c(red_1, red_2))(4)
scales::show_col(red_grad)

orange <- c("#CE512D")
orange_1 <- colorspace::lighten(orange, amount = 0.7)
orange_2 <- colorspace::lighten(orange, amount = -0.2)
scales::show_col(c(orange,orange_1, orange_2))
orange_grad <- colorRampPalette(c(orange_1, orange_2))(4)
scales::show_col(orange_grad)

yellow <- c("#EAB33B")
yellow_1 <- colorspace::lighten(yellow, amount = 0.7)
yellow_2 <- colorspace::lighten(yellow, amount = -0.15)
scales::show_col(c(yellow,yellow_1, yellow_2))
yellow_grad <- colorRampPalette(c(yellow_1, yellow_2))(4)
scales::show_col(yellow_grad)



jv_palette <- c(light_green_grad, dark_green_grad, dark_blue_grad, purple_grad, red_grad, orange_grad, yellow_grad)
scales::show_col(jv_palette, ncol = 4)



