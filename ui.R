navbarPage("The US traffic accidents in 2019", theme = shinytheme("yeti"),
           #===================== Intro tab =====================
           tabPanel("Introduction",
                    fluidRow(
                      HTML('<center><img src="cover.jpg" width = "95%", height = "70%"/></center>'),
                      column(4,
                             h1("Corraition of accident cause", style = "font-size:18px", align = "center"),
                             HTML('<center><img src="heat map.png" width = "300", height = "300"/></center>')),
                      column(4,
                             h1("Common casue of death", style = "font-size:18px", align = "center"),
                             HTML('<center><img src="death.png" width = "290", height = "290"/></center>')),
                      column(4,
                             h1("Word cloud about accident description", style = "font-size:18px", align = "center"),
                             br(),
                             HTML('<center><img src="wc.png" width = "290", height = "200"/></center>'))
                    ),
                    br(),
                    sidebarLayout(
                      sidebarPanel(
                        h1("Description", style = "font-size:25px; font-weight: bold"),
                        p("This is a interactive visualisation of the US traffic accident in 2019, displaying
         some interctive graph based on below dataset."),
                        br(),
                        p("For an introduction about dataset, visit the ",
                          a("here.", 
                            href = "https://www.kaggle.com/sobhanmoosavi/us-accidents#US_Accidents_Dec19.csv")),
                        img(src = "icon.jpg", height = 120, width = 200)
                      ),
                      mainPanel(
                        h1("Background", style = "font-size:25px; font-weight: bold"),
                        p("Although transportation brings many conveniences to people in nowadays, it also brings 
        hidden safety risks. In many countries, traffic safety is a very serious topic. The number 
        of casualties and property losses caused by traffic accidents are very huge each year."), 
                        p("For more detail information about motor vehicle fatality rate in the US, visit the ",
                          a("here.", 
                            href = "https://en.wikipedia.org/wiki/Motor_vehicle_fatality_rate_in_U.S._by_year")),
                        h1("Question", style = "font-size:25px; font-weight: bold"),
                        p("1. Which continent has the highest proportion of traffic accidents in 2019? 
        Which month is the highest incidence of accidents in 2019?"),
                        p("2.	How traffic accidents are distributed in the time dimension?"),
                        p("3.	How weather conditions affect the severity of traffic accidents?"),
                        br()
                      )
                    ),
                    wellPanel(
                      fluidRow(
                        h1("Accident distribution in the U.S.", 
                           style = "font-size:25px; font-weight: bold", align = "center"),
                        p("This dataset contains traffic accident records in 49 states. 
                      We can use a interactive map to see the accident distribution in 2019. 
                      All the states in the United States with the accident count are highlighted 
                      in the map, and the colour represents the amount of accidents. The darker the 
                      colour, the greater the number of accidents."),
                        column(12, 
                               plotlyOutput(outputId = 'mapPlot', height = 550)
                        )
                      )
                    )
           ),
           #==================== Quantity tab =====================
           tabPanel("Quantity",
                    wellPanel(
                      sidebarLayout(
                        sidebarPanel(
                          h1("Description", style = "font-size:25px; font-weight: bold"),
                          p("This graph shows the percentage of traffic accidents that 
                            occurred in the states of the United States. The results show 
                            that California has the largest number of accidents in all states 
                            of the United States. Its proportion reached 26%")
                        ),
                        mainPanel(
                          fluidRow(
                            h1("The precentage of top 20 States in the US with the most accidents", 
                               style = "font-size:25px; font-weight: bold", align = "center"),
                            br(),
                            column(12,
                                   plotlyOutput(outputId = 'barPlot', height = 550)
                            )
                          )
                        )
                      ),
                      br(),
                      br(),
                      sidebarLayout(
                        sidebarPanel(
                          h1("Description", style = "font-size:25px; font-weight: bold"),
                          p("This graph shows a line chart of the number of traffic accidents 
                            in the United States each month in 2019. We can see from the picture 
                            that the accident count experiences an obvious increase after July and 
                            a sudden decrease in January. In addition, October is the month with the 
                            most traffic accidents.")
                        ),
                        mainPanel(
                          fluidRow(
                            h1("The number of accident in monthly", 
                               style = "font-size:25px; font-weight: bold", align = "center"),
                            column(12,
                                   plotlyOutput(outputId = 'linePlot', height = 550)
                            )
                          ),
                          br()
                        )
                      )
                    )
           ),
           #===================== Time tab =====================
           tabPanel("Time",
                    wellPanel(
                      sidebarLayout(
                        sidebarPanel(
                          h1("Description", style = "font-size:25px; font-weight: bold"),
                          p("From the graph, it seems most accidents happen at these two intervals: 
                            7am - 8am, 16pm - 17pm, and we can roughly infer that most accidents happen 
                            during daytime."),
                          selectInput(inputId = 'showBarchart',
                                      label = h1('Showing Bar(Line) chart', style = "font-size:18px; font-weight: bold"),
                                      choices = c("Yes", "No"),
                                      selected = 'Yes')
                        ),
                        mainPanel(
                          fluidRow(
                            h1("Time Distribution of Accidents", 
                               style = "font-size:25px; font-weight: bold", align = "center"),
                            column(12,
                                   plotlyOutput(outputId = 'barTimePlot', height = 550)
                            )
                          )
                        )
                      ),
                      br(),
                    )
           ),
           #===================== Weather Conditions tab =====================
           tabPanel("Weather Conditions",
                    wellPanel(
                      h1("Impact of weather conditions on accidents severity", 
                         style = "font-size:25px; font-weight: bold", align = "center"),
                      br(),
                      HTML('<center><img src="weather condition.png" width = "80%", height = "80%"/></center>'),
                    ),
                    p("Common sense suggests that weather condition should have a great impact
                        on accident severity. It's reasonable to think severe accidents happen more 
                        often during bad weathers, and less severe ones happen more often during clear days. 
                        However, the result of visualization seems to be against this opinion."),
                    p("Actually, when we plot the most common weather conditions under each severity level, 
                          the distribution looks similar in each level. And we can see more severe accidents 
                          (level 3 and 4) also happen a lot during clear days. Therefore, it seems the severity 
                          of an accident is not mainly affected by weather conditions. "),
                    br(),
                    sidebarLayout(
                      sidebarPanel(
                        h1("Word cloud", 
                           style = "font-size:25px; font-weight: bold"),
                        p("This is a interactive visualisation of word cloud about weather condition, 
                          displaying the number of occurence of different weather conditions."),
                        br()
                      ),
                      mainPanel(
                        wordcloud2Output("weather_wc")
                      )
                    )
           )
)

  
  
  