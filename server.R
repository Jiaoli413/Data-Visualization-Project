shinyServer(
  function(input, output, session) {
    output$mapPlot = renderPlotly({
      df <- accident_count
      df$hover <- with(df, paste(State_full, '<br>', "Number of accidents:", n))
      l <- list(color = toRGB("grey"), width = 0.5)
      g <- list(
        scope = 'usa',
        projection = list(type = 'albers usa'),
        showlakes = TRUE,
        lakecolor = toRGB('white')
      )
      
      fig <- plot_geo(df, locationmode = 'USA-states')
      fig <- fig %>% add_trace(
        z = ~n, text = ~hover, locations = ~State,
        color = ~n, colors = 'Blues'
      )
      fig <- fig %>% colorbar(title = "Accident Count")
      fig <- fig %>% layout(
        geo = g
      )
      
      fig
    })
    #===================================================
    #===============   Quantity tab    ================= 
    #===================================================
    
    output$barPlot = renderPlotly({
      fig <- new_accident_count %>% plot_ly(labels = ~State_full, values = ~n)
      fig <- fig %>% add_pie(hole = 0.6)
      fig <- fig %>% layout(title = "",  showlegend = T,
                            xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                            yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

      fig
    })
    
    output$linePlot = renderPlotly({
      month <- c('January', 'February', 'March', 'April', 'May', 'June', 'July',
                 'August', 'September', 'October', 'November', 'December')
      number_of_accidnets <- table(accidents$Month)
      month_data <- data.frame(month, number_of_accidnets)
      month_data$month <- factor(month_data$month, levels = month_data[["month"]])
      
      fig <- plot_ly(month_data, x = ~month, y = ~number_of_accidnets, 
                     type = 'scatter', mode = 'lines',
                     line = list(color = 'rgb(158,202,225)', width = 4)) 
      fig <- fig %>% layout(paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
                            xaxis = list(title = ""),
                            yaxis = list(title = "The number of accidents",
                                         gridcolor = 'rgb(255,255,255)'))
      fig
    })
    
    #===================================================
    #=================    Time tab     ================= 
    #===================================================
    output$barTimePlot = renderPlotly({
      if (input$showBarchart == "Yes") {
        x <- c("00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00",
               "08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00",
               "16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00")
        y <- c(table(accidents$Hour))
        time_data <- data.frame(x,y)
        fig <- plot_ly(time_data, x = ~x, y = ~y, type = 'bar',
                       marker = list(color = c('rgb(158,202,225)', 'rgb(158,202,225)','rgb(158,202,225)', 'rgb(158,202,225)',
                                               'rgb(158,202,225)', 'rgb(158,202,225)','rgb(158,202,225)', 'rgb(255,102,102)',
                                               'rgb(255,102,102)', 'rgb(158,202,225)','rgb(158,202,225)', 'rgb(158,202,225)',
                                               'rgb(158,202,225)', 'rgb(158,202,225)','rgb(158,202,225)', 'rgb(158,202,225)',
                                               'rgb(255,102,102)', 'rgb(255,102,102)','rgb(158,202,225)', 'rgb(158,202,225)',
                                               'rgb(158,202,225)', 'rgb(158,202,225)','rgb(158,202,225)', 'rgb(158,202,225)')))
        fig <- fig %>% layout(xaxis = list(title = "", tickangle = -45),
                              yaxis = list(title = ""))
        fig
      }
      else {
        x <- c("00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00",
               "08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00",
               "16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00")
        y <- c(table(accidents$Hour))
        time_data <- data.frame(x,y)
        fig <- plot_ly(time_data, x = ~x, y = ~y, type = 'scatter', mode = 'lines',
                       line = list(color = 'rgb(255,102,102)', width = 4)) 
        fig <- fig %>% layout(title = "",
                              xaxis = list(title = ""),
                              yaxis = list (title = ""))
        
        fig
      }
    })
    
    #===================================================
    #=========     Weather Conditions tab    =========== 
    #===================================================
    
    output$weather_wc = renderWordcloud2(
      wordcloud2(weather_data, size = 2, minRotation = -pi/2, maxRotation = -pi/2)
    )
})
