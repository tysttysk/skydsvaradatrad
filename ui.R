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
      checkboxInput("filtreraKommun", "Filtrera efter kommun", FALSE),
      conditionalPanel(
        condition = "input.filtreraKommun",
        uiOutput("kommunSelektOutput")
      ),
      
      checkboxInput("filtreraTradslag", "Filtrera efter trädslag", FALSE),
      conditionalPanel(
        condition = "input.filtreraTradslag",
        uiOutput("tradslagSelektOutput")
      ),
      
      checkboxInput("filtreraTradsstatus", "Filtrera efter trädsstatus", FALSE),
      conditionalPanel(
        condition = "input.filtreraTradsstatus",
        uiOutput("tradstatusSelektOutput")
      ) 
    )
  )
)

body = dashboardBody(
  tabItems(
    tabItem(tabName = "info",
          tabBox(width = 12,
            tabPanel("Välkommen",
                           fluidRow(
                              column(12,
                     p("Hej, den här webapplikation innehåller information om projektet Skyddsvärda träd i Jönköpings län. 
                       Informationen om skyddsvärda träd samlades in sedan 2008 och det läggs till nya observationer kontinuerligt. 
                       I dagsläget finns det mer än 167 000 trädobservationer i länet. "),
                     br(),
                     p(img(src="tree.jpg", align = "center")),
                     br())),
                          fluidRow(
                              column(4,
                     p("Bild: Länsstyrelsen i Jönköping ©" ),
                     br())),
                            fluidRow(
                              column(12, 
                     p("På de flikar till höger hittar du information om inventering av skyddsvärda träd i form av en datatabell 
                      som du kan även ladda. Du har också möjlighet att ta del av informationen via olika figurer och en karta."),
                     p("Du har möjligheten att välja ut vilken information ska visas i tabell, figurer och kartbild genom att använda 
                      de menyer på vänster sidan. Välj t.ex. mellan olika stamomkretsar 
                      och ser hur många observationer def finns för de valda parameter. Var finns de träd med största diameter? 
                      Vilken trädslag har dom? Och vilken status befinner de sig? Är de frisk eller har dom låg vitalitet?"),
                     p("Det är din möjlighet att undersöka all den fantastiskt information digital men varför inte åka ut och besöka en av trädet med hjäl av kartan."), 
                     p(" Kör igång!")
                       ))),
            tabPanel("Data som tabell", 
                     br(),
                     p("Här kan du ser du resultat av inventeringen i form av en tabell. Du kan sortera i tabellen med hjälp av pilarna. 
                       Notera hur antal observationer förändrar sig (vänster-nedre delen) när du filtrera efter Stramomkrets. Om du vill ladda observationer
                       för att själv studera dom använd nedladdningskanppen under tabellen."),
                     br(),
                     dataTableOutput(outputId="DataSk"),
                     br(),
                     downloadButton("download", "Ladda ner resultatet")
                        ),
            tabPanel("Visualisering",
                     p(" "),
                     p("Den första visualisering visar den genomsnittliga stamomkrets för tre olika parameter (Kommun, Trädslag och Trädstatus)."),
                     p(" "),
                     textOutput("summaryText"),
                     
                     plotlyOutput(outputId="BarPlot"),
                     p(" "),
                     #selector for categorcial variable to plot
                     
                     selectInput(
                       inputId = "StrToPlot",
                       label = "Välj en kategori",
                       choices = c("Kommun", "Tradslag", "Tradstatus"),
                       selected = "Kommun"
                       
                     ),
                     p("------------------------------------------------------------------------"),
                     p("Denna plot visar en histogram som visualisera hur många observationer det finns per stamomkretsklass"),
                     p(" "),
                     plotOutput(outputId="coolplot")
                     
                     
                      ),
            tabPanel("Karta", textOutput("sumText"),
                     leafletOutput(outputId="SKmap", width ="100%", height =800)
                     
                     
                    
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