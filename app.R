library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(plotly)
library(RColorBrewer)



"dado" <- read.csv(file = "estado.csv")

ui <- dashboardPage( skin = "red",
  dashboardHeader(title = "Queimadas no Brasil"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
            fluidRow(
              box(width = 7,
                leafletOutput("map")
                ),
              
              box(width = 4,
                
                  plotlyOutput("area")
                  )
                         
               ),
            
            fluidRow(
              box(width = 6,
                  
                  plotlyOutput("barra")
                  
                  ),
              box(width = 2, "Lucas Cano","Nusp:1273104","Trabalho de VED sobre Queimadas no Brasil em 2020"
              
              
              
            ),
              
            )
  )
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    leaflet() %>%
     addTiles()%>%
      addCircleMarkers(lat = estado$LAT,lng = estado$LONG,color = "red",
                       popup = estado$popup_info, radius = estado$TOTAL/1000)
  })
  
  output$area <- renderPlotly({
    plot_ly(areaq, labels = areaq$Biomas, values = areaq$Prct, type = "pie",
            textposition = "inside",
            textinfo = "label+percent+",
            insidetextfont = list(color = "white"))
    
    
  })
  
  output$barra <- renderPlotly({
    plot_ly(
      x = estado$CODE,
      y = estado$TOTAL,
      name = "queim",
      type = "bar",
      color = "red"
      )
  
  })
  
  }  
shinyApp(ui, server)