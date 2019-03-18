# UI side

header = dashboardHeader(title = "Skyddsvärda träd",
  dropdownMenu(
    type = "messages",
    messageItem(
      from = "Author",
      message = "Klicka för mer information om skyddsvärda träd!",
      href = "https://www.lansstyrelsen.se/download/18.4df86bcd164893b7cd92a924/1534321611646/broschyr-skyddsvarda-trad.pdf"
    )
  )
)

sidebar = dashboardSidebar(
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Information",
               tabName = "info"
      ),
      sliderInput(inputId = "stamk",
                  label = "Trädiameter inkluderat",
                  min = min(sktradjkp$Stamomkret),
                  max = max(sktradjkp$Stamomkret),
                  value = c(min(sktradjkp$Stamomkret), max(sktradjkp$Stamomkret)),
                  sep = "",
                  step = 10,
                  post = " cm "
      ),
      selectizeInput(inputId = "KomS",
                     label = "Välj en eller flera kommuner",
                     choices = unique(sktradjkp$Kommun),
                     multiple = T,
                     selected = "Jönköping"
      ),
      
      selectizeInput(inputId = "TraS",
                     label = "Välj en eller flera Trädslag",
                     choices = unique(sktradjkp$Tradslag),
                     multiple = T,
                     selected = "Ek"
      ),
      
      selectizeInput(inputId = "TraSt",
                     label = "Välj en eller flera trädstatus",
                     choices = unique(sktradjkp$Tradstatus),
                     multiple = T,
                     selected = "Friskt"
      )
    )
  )
)

body = dashboardBody(
  tabItems(
    tabItem(tabName = "info",
          tabBox(
            tabPanel("Välkommen",
                     p("Hej, den här webapplikation innehåller information om projektet Skyddsvärda träd i Jönköpings län. 
                       Informationen om skyddsvärda träd samlades in sedan 2008 och kontinuerlig uppdaters eller nya observationer läggs till"),
                     p("På de följande flikar hittar du bakgrundinformation om inventering av skyddsvärda träd som tabell såväl som informativ grafik och karta.
                       Du har möjligheten att välja ut vilken information ska visas i tabell, figurer och kartbild genom att använda navigera till fliken dashboard och karta på vänster sidan.
                       I framtiden kommer det även finnas möjligheten att ladda ner tabeller och kartblad efter din filterering.")
                       ),
            tabPanel("Data som tabell", dataTableOutput(outputId="DataSk"),
                     downloadButton("download", "Ladda ner resultatet")
                        ),
            tabPanel("Visualisering", plotlyOutput(outputId="BarPlot"),
                    
                     #selector for categorcial variable to plot
                     
                     selectInput(
                       inputId = "StrToPlot",
                       label = "Välj en kategori",
                       choices = c("Kommun", "Tradslag", "Tradstatus"),
                       selected = "Kommun"
                       
                     )
                        ),
            tabPanel("Karta", leafletOutput(outputId="SKmap")
                )        
            )
        )    
    )
)

dashboardPage(
  header=header,
  sidebar=sidebar,
  body=body,
  title="Skydsvärda träd",
  skin="blue"
)