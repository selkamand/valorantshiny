#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    shinydashboard::dashboardPage(
      skin = "red",
      shinydashboard::dashboardHeader(title = "ValorantShiny"),
      shinydashboard::dashboardSidebar(
        shinydashboard::sidebarMenu(
          shinydashboard::menuItem("Strat Roulette", tabName = "strat_roulette", icon = icon("chess-board")),
          shinydashboard::menuItem("Agent Roulette", tabName = "agent_roulette", icon = icon("people-group"))
        )
        ),
      shinydashboard::dashboardBody(
        shinydashboard::tabItems(
          # First tab content
          shinydashboard::tabItem(tabName = "strat_roulette", mod_strat_roulette_ui(id = "strat_roulette")),
          shinydashboard::tabItem(tabName = "agent_roulette", mod_agent_roulette_ui(id = "agent_roulette"))

        )
    )
  ))
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "valorantshiny"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
