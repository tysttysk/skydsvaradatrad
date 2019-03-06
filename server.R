# Server Side

shinyServer(function(input, output, session) 
  
output$DataSk <- DT::renderDataTable(DT::datatable(sktradjkp, rownames = FALSE, 
                                                     options=list(scrollX=TRUE)
    )
  )
)
  
  

  





