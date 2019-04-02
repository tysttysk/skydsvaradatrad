# global options

library(shiny)
library(leaflet)
library(ggplot2)
library(readr)
library(DT)
library(dplyr)
library(shinydashboard)
library(rio)
library(sf)
library(plotly)
library(readxl)
library(xlsx)

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

#skimmed <- reactive({
#  sktradjkp %>%
#    filter(Kommun == input$KomS,
#           Tradslag == input$TraS,
#           Skyddsvrede == input$SkyS,
#           Tradstatus == input$TraSt	
#    )
#})

#filterSk <- reactive({
 # filterSk <- sktradjkp
  
  #if (is.null(input$KomS)) {
   # return(NULL)
  #}
  
#  filterSk <- dplyr::filter(filterSk, Tradslag %in% input$TraS)
 # if (input$KomS) {
  #  filterSk <- dplyr::filter(filterSk, Kommun == input$KomS)
  #}
  
  #if(nrow(filterSk) == 0) {
    #return(NULL)
  #}
  #filterSk
#})

#var = reactive({
 # sktradjkp[, input$KomS]
#})


