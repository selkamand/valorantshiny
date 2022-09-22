#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  mod_strat_roulette_server("strat_roulette")
  mod_agent_roulette_server("agent_roulette")
}
