#Images
#Like with text, there are packages in R that will help you carry out analysis of images. 
#In particular, magick is particularly helpful for advanced image processing within R,
#https://cran.r-project.org/web/packages/magick/vignettes/intro.html#drawing_and_graphics

# install package
#install.packages("magick")
# load package
library(magick)
library(tesseract)
## Linking to ImageMagick 6.9.9.39
## Enabled features: cairo, fontconfig, freetype, lcms, pango, rsvg, webp
## Disabled features: fftw, ghostscript, x11
img1 <- image_read("https://ggplot2.tidyverse.org/logo.png")
img2 <- image_read("https://pbs.twimg.com/media/D5bccHZWkAQuPqS.png")
#show the image
print(img1)
print(img2)
#concatenate and print text
cat(image_ocr(img1))
## ggplot2
cat(image_ocr(img2))
## parsnip