# global options

library(shiny)
library(leaflet)
library(ggplot2)
library(readr)
library(DT)
library(plyr)
library(shinydashboard)

setwd("C:/Users/mermo/Downloads/skydsvardtrad")

sktradjkp <- read_csv("C:/Users/mermo/Downloads/! strad/sktradjkp.csv")

str(sktradjkp)
