source("data_cleaning.R")

thematic_shiny()

ui <- page_fluid(
  theme = bs_theme(preset = "minty"),
  headerPanel("Table 5 - The relationship between Reach and outcomes as reported across studies (N = 3)"),
  reactableOutput("Table5"),
  textInput("footnote", "Note. Effect Size is presented as reported in paper",
            width = "100%")
  )

server <- function(input, output) {
  output$Table5 <- renderReactable({
    reactable(Table5,
              theme = default(centered = TRUE),
              filterable = TRUE,
              bordered = FALSE,
              striped = FALSE,
              highlight = TRUE,
              searchable = TRUE,
              defaultPageSize = 16,
              groupBy = "Outcome Domain",
              columns = list(
                Study_ID = colDef(
                  align = "center",
                  maxWidth = 130,
                  name = "Study ID",
                  cell = function(value, index) {
                    label2 <- DOITable5[index, "Study_ID"] # had to create a separate file for the DOIs for this table and just replaced label1 with label2 in case there was the risk of some overwriting
                    DOI2 <- DOITable5[index, "DOI"]
                    htmltools::div(
                      htmltools::p(
                        htmltools::tags$a(href = DOI2, target = "_blank", label2)
                      ),
                    )
                  }
                ),
                "First Author" = colDef(
                  align = "left",
                  maxWidth = 130
                ),
                Year = colDef(
                  align = "center",
                  maxWidth = 130
                ),
                Country = colDef(
                  header = with_tooltip("Country", 
                                        "Country where data was collected"),
                  maxWidth = 130
                ),
                CountryFlag = colDef(
                  name = "",
                  maxWidth = 70,
                  align = "center",
                  cell = embed_img("Country",
                                   height = "25",
                                   width = "40")
                ),
                "Outcome Domain" = colDef(
                  align = "center",
                  header = with_tooltip("Outcome Domain", 
                                        "Student outcome(s) assessed"),
                ),
                "Classification" = colDef(
                  header = with_tooltip("Classification", "Classification Quality"),
                  align = "center",
                  maxWidth = 120,
                  cell = pill_buttons(Table5,
                                      color_ref = "Classification_colours", 
                                      opacity = 0.7),
                ),
                "Classification_colours" = colDef(
                  show = FALSE),
                "Total Tests" = colDef(
                  align = "center",
                  header = with_tooltip(
                    "Total Tests", 
                    "Total of statistical tests performed"),
                  cell = data_bars(Table5,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)),
                "Statistically Significant Tests" = colDef(
                  align = "center",
                  maxWidth = 190,
                  header = with_tooltip(
                    "Statistically Significant Tests", 
                    "Total of statistically significant tests"),
                  cell = data_bars(Table5,
                                   text_position = "center",
                                   round_edges = TRUE,
                                   box_shadow = TRUE,
                                   bar_height = 15)),
                "Effect Size" = colDef(
                  align = "center",
                  header = with_tooltip(
                    "Effect Size", 
                    "Effect Sizes and their range, where applicable, for statistically significant effects")
                )
              )
    )
})

}

# Run the application 
shinyApp(ui = ui, server = server)
