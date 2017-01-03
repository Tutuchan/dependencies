library(shiny)
library(timevis)

ui <- fluidPage(
  tags$head(tags$script(src = "moment-with-locales.js")),

  # Application title
  titlePanel("Additional dependencies"),
  timevisOutput("tv")
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$tv <- renderTimevis({
    x <- timevis(
      data.frame(
        id = 1:2,
        content = c("one", "two"),
        start = c("2016-01-10", "2016-01-12")
      ),
      options = list(locale = "fr")
    )
    # This works interactively but not in a Shiny application either with "www" or not
    x$dependencies <- c(
      list(
        htmlDependency(
          name = "moment",
          version = "2.17.1",
          src = path.expand(file.path(getwd(), "www")),
          script = "moment-with-locales.js"
        )
      ),
      x$dependencies
    )
    x
  })
}

# Run the application
shinyApp(ui = ui, server = server)

