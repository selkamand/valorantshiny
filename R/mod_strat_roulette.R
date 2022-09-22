#' strat_roulette UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_strat_roulette_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      shinyWidgets::panel(
        heading = "Strategy",

        fluidRow(
          shinydashboard::box(
            width = 12,
            col_10(
              htmlOutput(outputId = ns("htmlout_strat"))
            ),
            col_2(
              shinyWidgets::awesomeRadio(
                inputId = ns("side"),
                label = "Side",
                choices = list("Attacking" = "Attacking", "Defending" = "Defending", "Both" = "Both"),
                selected = "Both"
              )
            )
          )
        ),
        actionButton(
          inputId = ns("in_bttn_roulette_next"),
          label = "Next",
          icon = icon("forward"),
          style = "jelly"#,
          #style= "float",
          #color = "royal",
          #width = "90%"
          #block = TRUE
          )
      )
    )
  )
}

iterate <- function(i, len){
  i_new = i+1
  if(i_new > len){
   return(1)
  }
  else
    return(i_new)
}

#' strat_roulette Server Functions
#'
#' @noRd
mod_strat_roulette_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    i_both <- reactiveVal(value = 1)
    i_attacking <- reactiveVal(value = 1)
    i_defending <- reactiveVal(value = 1)

    observeEvent(input$in_bttn_roulette_next, isolate({
      message('buttonClicked')
      message(side())
      if(side() == "Attacking")
        i_attacking(iterate(i_attacking(), length(strats_attacking())))
      else if(side() == "Defending")
        i_defending(iterate(i_defending(), length(strats_defending())))
      else if(side() == "Both")
        i_both(iterate(i_both(), length(strats_both())))
      else(
        stop("Bad coding alert - Side must be Attacking, Defending Or both")
        )
      }))

    side <- reactive({ input$side })

    seed = reactiveVal(NULL)

    strats_attacking <- reactive ({
      valorant::val_strats(side = "Attacking", seed = seed())
    })

    strats_defending <- reactive ({
      valorant::val_strats(side = "Defending", seed = seed())
    })

    strats_both <- reactive ({
      valorant::val_strats(side = "Both", seed = seed())
    })


    strat <- reactive({
      #browser()
      s = NULL
      if(side() == "Attacking")
        s <- strats_attacking()[[i_attacking()]]
      else if(side() == "Defending")
        s <- strats_defending()[[i_defending()]]
      else if(side() == "Both")
        s <- strats_both()[[i_both()]]
      else(
        stop("Bad coding alert - Side must be Attacking, Defending Or both")
      )

      return(s)
    })

    output$htmlout_strat <- renderText({strat()})
  })
}

## To be copied in the UI
# mod_strat_roulette_ui("strat_roulette_1")

## To be copied in the server
# mod_strat_roulette_server("strat_roulette_1")
