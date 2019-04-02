# Server Side

shinyServer(function(input, output, session) 
  
{  
  
  data_fil <- reactive({
    data <- subset(
      sktradjkp,
      Stamomkret >= input$stamk[1] & Stamomkret <= input$stamk[2]
     )
})  
  
  output$download <- downloadHandler(
    filename = "data.xlsx",
    content = function(file) {
      # Code that creates a file in the path <file>
      write.xlsx(data_fil(), file)
    }
  )  
  
  output$kommunSelektOutput <- renderUI({
    selectizeInput(inputId = "KomS",
                   label = "Filtrera efter kommun",
                   choices = unique(sktradjkp$Kommun),
                   multiple = T,
                   selected = "Jönköping"
                   
    )
  })   
  output$tradslagSelektOutput <- renderUI({  
  selectizeInput(inputId = "TraS",
                 label = "Filtrera efter trädslag",
                 choices = unique(sktradjkp$Tradslag),
                 multiple = T,
                 selected = "Ek"
  )
}) 
  output$tradstatusSelektOutput <- renderUI({
  selectizeInput(inputId = "TraSt",
                 label = "Filtrera efter trädstatus",
                 choices = unique(sktradjkp$Tradstatus),
                 multiple = T,
                 selected = "Friskt"
  )
})  
  
  output$summaryText <- renderText({
    numOptions <- nrow(data_fil())
    if (is.null(numOptions)) {
      numOptions <- 0
    }
    paste0("Du har valt ", numOptions, " observationer")
  })  
  
  output$sumText <- renderText({
    numOptions <- nrow(data_fil())
    if (is.null(numOptions)) {
      numOptions <- 0
    }
    paste0("Du har valt ", numOptions, " observationer")
  })
# Add visualzations od both datatable and graphics
  
output$DataSk <- DT::renderDataTable(DT::datatable(data_fil(), rownames = FALSE, 
                                                   options=list(scrollX=TRUE)
  )
)

output$BarPlot <- renderPlotly({
  ggplotly(
  ggplot(data_fil(), aes_string(x=input$StrToPlot, y="Stamomkret")) + 
    stat_summary(fun.y="mean", geom="bar") + theme(axis.text.x = element_text(angle = 45, hjust = 1,size=12)) 
  )
   
    })

output$coolplot <- renderPlot({
  
  ggplot(data_fil(), aes_string("Stamomkret")) +
    geom_histogram()
  
})
 
output$SKmap <- renderLeaflet(
  data_fil() %>%
    leaflet() %>%
    addTiles() %>%
    setView(lng = 14.16, lat = 57.78, zoom = 7) %>%
    addMarkers(
      lng= ~lon, lat= ~lat,
      popup= paste("Stamomkrets i cm:", data_fil()$Stamomkret, "<br>",
                   "Trädslag:", data_fil()$Tradslag, "<br>",
                   "Trädstatus:", data_fil()$Tradstatus
        
          )
        )  
    )

})


  

  





