#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(palmerpenguins)
library(ggplot2)

# Définition de l'interface utilisateur
ui <- dashboardPage(
  dashboardHeader(title = "Analyse des Pingouins"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Histogramme des ailes", tabName = "histogram"),
      menuItem("Nuage de points bec", tabName = "scatterplot")
    )
  ),
  dashboardBody(
    tabItems(
      # Onglet Histogramme des ailes
      tabItem(
        tabName = "histogram",
        fluidRow(
          box(
            title = "Comparaison de la longueur des ailes entre les espèces de pingouins",
            status = "primary",
            solidHeader = TRUE,
            plotOutput("histogram_plot")
          )
        )
      ),
      # Onglet Nuage de points bec
      tabItem(
        tabName = "scatterplot",
        fluidRow(
          box(
            title = "Relation entre la longueur et la largeur du bec chez les pingouins",
            status = "primary",
            solidHeader = TRUE,
            plotOutput("scatterplot_plot")
          )
        )
      )
    )
  )
)

# Définition du serveur
server <- function(input, output) {
  # Histogramme des ailes
  output$histogram_plot <- renderPlot({
    ggplot(penguins, aes(x = flipper_length_mm, fill = species)) +
      geom_histogram(alpha = 0.4, position = "identity", bins = 15) +
      labs(x = "Longueur des ailes (mm)", y = "Nombre d'individus") +
      ggtitle("Comparaison de la longueur des ailes entre les espèces de pingouins") +
      scale_fill_brewer(palette = "Set1")
  })

  # Nuage de points bec
  output$scatterplot_plot <- renderPlot({
    ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE) +
      labs(x = "Longueur du bec (mm)", y = "Largeur du bec (mm)") +
      ggtitle("Relation entre la longueur et la largeur du bec chez les pingouins") +
      scale_color_brewer(palette = "Set1")
  })
}

# Exécution de l'application Shiny
shinyApp(ui, server)
