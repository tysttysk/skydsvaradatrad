# UI side

header = dashboardHeader(title = "Skyddsvärda träd",
  dropdownMenu(
    type = "messages",
    messageItem(
      from = "Matti",
      message = "Kolla information om skyddsvärda träd!",
      href = "https://www.naturvardsverket.se/upload/stod-i-miljoarbetet/vagledning/miljoovervakning/handledning/metoder/undersokningstyper/landskap/skyddsvarda-trad.pdf"
    )
  )
)

sidebar = dashboardSidebar(
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Information",
               tabName = "info"
      ),
      menuItem("Dashboard",
               tabName = "dashboard"
      ),
      menuItem("Karta",
               tabName = "karta")
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
            tabPanel("Bakgrund", 
                      p("Biologisk mångfald utgörs av den mosaik av naturtyper, livsmiljöer och organismer som finns
                      i landskapet – i odlade marker, i vattendrag och sjöar liksom i våtmarker och skogar. En stor
                      del av den biologiska mångfalden är knuten till gamla träd i kulturlandskapet. "),
                      p("I själva verket är dessa träd i många avseenden nyckeln till bevarandet av en mängd hotade
                      växter och djur. God kunskap om tillståndet i miljöer med skyddsvärda träd ökar förutsättningarna för att bevara och förstärka de natur- och kulturvärden som är kopplade till dessa
                      miljöer. Kunskap om var värdefulla miljöer finns ökar också förutsättningarna för människor
                      till ett rikt friluftsliv och en god folkhälsa. Undersökningstypen har därför stark koppling till
                      miljömål såsom Ett rikt odlingslandskap, Levande skogar och Ett rikt växt- och djurliv. "),
                      p("I en del regioner av landet har kunskapsinsamling avseende skyddsvärda träd redan gjorts i
                      större eller mindre omfattning, dock med sinsemellan något skild metodik. Föreliggande undersökningstyp är framtagen dels genom en översyn och sammanvägning av använda metoder
                      (Ref. 1-4), dels i en strävan att harmonisera undersökningstyp och Trädportal. Vissa parametrar har utvecklats i mer objektiv riktning. "),
                      p("Information från Naturvårdsverkets undersökningstyp Version1:0 : 2009-04-06")
                     ),
            tabPanel("Syfte",
                      p("Syftet med undersökningstypen är att tillhandahålla en nationellt enhetlig och uppföljningsbar
                     metod för inventering och miljöövervakning av miljöer med skyddsvärda träd. Inventering av
                     skyddsvärda träd med datafångst som visar antal och fördelning av träd, förekomst av håligheter m.m. ger, 
                     tillsammans med datafångst för omvärldsparametrar ett bra underlag för bedömning av ett träds eller ett områdes skötselbehov eller bevarandestatus."),
                      p("Vid inventering av större landskapsavsnitt utgör insamlade data ett värdefullt instrument för
                      naturvård med landskapsstrategisk inriktning. "))
    )
),            
          
    tabItem(tabName = "dashboard",
          
            tabBox(width = 12,
              tabPanel("Data som tabell", DT::dataTableOutput(outputId="DataSk")),
              tabPanel("Visualiseringar", 
                       
                       sliderInput(inputId = "stamk",
                                   label = "Trädiameter inkluderat",
                                   min = min(sktradjkp$Stamomkret),
                                   max = max(sktradjkp$Stamomkret),
                                   value = c(min(sktradjkp$Stamomkret),max(sktradjkp$Stamomkret)),
                                   sep = "",
                                   step = 10
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
                                      selected = " "
                       ),
                       
                       selectizeInput(inputId = "SkyS",
                                      label = "Välj en eller skyddsvärden",
                                      choices = unique(sktradjkp$Skyddsvrde),
                                      multiple = T,
                                      selected = " "
                       ),
                       
                       plotOutput(outputId="BarPlot"),
                       
                       selectInput(
                         inputId = "IntToPlot",
                         label = "Bara Stamomkrets selekterbar för nu",
                         choices = c("Stamomkret"),
                         selected = "Stamomkret"
                         
                       ),
                       
                       #selector for categorcial variable to plot
                       
                       selectInput(
                         inputId = "StrToPlot",
                         label = "Välj en kategori",
                         choices = c("Kommun", "Tradslag", "Skyddsvrde", "Tradstatus"),
                         selected = "Kommun"
                         
                       )
                       
          )
        )
    ),

    tabItem(tabName = "karta",
            
            tabBox(width = 12,
                   tabPanel("Karta", leafletOutput(outputId="SKmap")))
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