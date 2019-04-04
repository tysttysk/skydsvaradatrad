# global options

library(shiny)
library(leaflet)
library(ggplot2)
library(DT)
library(dplyr)
library(shinydashboard)
library(plotly)
library(leaflet.extras)
library(xlsx)
library(bbplot)
library(MASS)

load("sktrad.Rdata")

options ( encoding = "UTF-8" )

#setwd( system.getCurrentDirectory() )  

#loadzip = tempfile() 
#download.file("http://ext-dokument.lansstyrelsen.se/gemensamt/geodata/ShapeExport/LSTF.miljoovervakning_skyddstrad_flan_alla.zip", loadzip, mode = "wb")
#unzippa = unzip(loadzip, st_read("LSTF.miljoovervakning_skyddstrad_flan_alla.shp"))
#unzip(loadzip)
#shape = st_read(loadzip, "LSTF.miljoovervakning_skyddstrad_flan_alla.shp")
#data = import(loadzip, "LSTF.miljoovervakning_skyddstrad_flan_alla.dbf")
#data = import(unz(loadzip, "LSTF.miljoovervakning_skyddstrad_flan_alla.dbf"))
#unlink(loadzip)




