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
                     label = "Filtrera efter kommun",
                     choices = unique(sktradjkp$Kommun),
                     multiple = T,
                     selected = " "
                     
      ),
      
      selectizeInput(inputId = "TraS",
                     label = "Filtrera efter trädslag",
                     choices = unique(sktradjkp$Tradslag),
                     multiple = T,
                     selected = " "
      ),
      
      selectizeInput(inputId = "TraSt",
                     label = "Filtrera efter trädstatus",
                     choices = unique(sktradjkp$Tradstatus),
                     multiple = T,
                     selected = " "
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
                       Informationen om skyddsvärda träd samlades in sedan 2008 och kontinuerlig läggs till nya observationer. 
                       I dagsläget finns det mer än 167 000 trädobservationer i länet. "),
                     p("På de flikar till höger hittar du information om inventering av skyddsvärda träd i form av en datatabell 
                      som du kan även ladda ner men även som informativ grafik och karta."),
                     p("Du har möjligheten att välja ut vilken information ska visas i tabell, figurer och kartbild genom att använda 
                      de menueran på vänster sidan. Välj t.ex. mellan olika stamomkretsar 
                      och ser hur många observationer def finns för de valda parameter. Kolla vilka kommun i länet har i genomsnitt 
                      de största skyddsvärda träd. Var finns de träd med största diameter? 
                      Vilken trädslag har dom? Och vilken status befinner de sig? Är de risk eller har låg vitalitet?"),
                     p("Det är din möjlighet att undersöka all den fantastiskt information. Kör igång!")
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
                       
                     ),
                     
                     plotOutput(outputId="coolplot")
                     
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