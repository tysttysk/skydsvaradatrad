# Server Side

shinyServer(function(input, output, session) 
  
{  
  
# Add visualzations od both datatable and graphics
  
output$DataSk <- DT::renderDataTable(DT::datatable(sktradjkp, rownames = FALSE, 
                                                   options=list(scrollX=TRUE)
  )
)

output$BarPlot <- renderPlotly({
  ggplotly(
  ggplot(sktradjkp, aes_string(x=input$StrToPlot, y="Stamomkret")) + 
    stat_summary(fun.y="mean", geom="bar") + theme(axis.text.x = element_text(angle = 45, hjust = 1,size=12)) 
  )
   
    })   
})
  

  





