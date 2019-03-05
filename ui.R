# UI side

header = dashboardHeader(
  dropdownMenu(
    type = "messages",
    messageItem(
      from = "Matti",
      message = "Kolla information om skyddsvärda träd!",
      href = "https://www.lansstyrelsen.se/jonkoping/tjanster/publikationer/information-och-fakta/skyddsvarda-trad.html"
    )
  )
)

sidebar = dashboardSidebar(
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuItem("Data",
               tabName = "data"
      ),
      menuItem("Dashboard",
               tabName = "dashboard")
    )
  )
)

body = dashboardBody()

dashboardPage(
  header=header,
  sidebar=sidebar,
  body=body,
  title="Skydsvärda träd",
  skin="blue"
)