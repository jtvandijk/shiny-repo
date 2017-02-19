#Install packages
install.packages(c("shiny", "dplyr", "ggplo2", "DT", "devtools"))
devtools::install_github("juliasilge/southafricastats")

#Prepare Shiny data
library(southafricastats)
library(dplyr)
library(ggplot2)
mortality_zaf
mortality_zaf$province

install.packages(c("shiny",
"flexdashboard",
"dplyr",
"tidyr",
"ggplot2",
"leaflet"
"devtools"))
