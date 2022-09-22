#' agent_roulette UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_agent_roulette_ui <- function(id){
  ns <- NS(id)
  tagList(
    shinyWidgets::panel(
      heading = "Agent Roulette",
      shinycssloaders::withSpinner(plotOutput(outputId = ns('out_plot_agent_roulette'))),

      shinyWidgets::panel(
        heading = "Options",
        numericInput(inputId = ns('in_num_attackers'), value = 5, label = "Team Size (ATTACKERS)", min = 1, max = 5, step = 1) |> col_4(),
        numericInput(inputId = ns('in_num_defenders'), value = 5, label = "Team Size (DEFENDERS)", min = 1, max = 5, step = 1) |> col_4(),
        selectInput(inputId = ns('in_sel_agents_to_exclude'), label = "Agents To Exclude", choices = valorant::valorant_agents(), multiple = TRUE) |> col_4()
      )
    )
  )
}

#' agent_roulette Server Functions
#'
#' @noRd
mod_agent_roulette_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    gg <- reactive({
      valorant::agent_roulette_customs_visualise(
        attacking_nplayers = input$in_num_attackers,
        defending_nplayers = input$in_num_defenders,
        agents_to_exclude = input$in_sel_agents_to_exclude
        )
      })

    output$out_plot_agent_roulette <- renderPlot({gg()})
  })
}

## To be copied in the UI
# mod_agent_roulette_ui("agent_roulette_1")

## To be copied in the server
# mod_agent_roulette_server("agent_roulette_1")
