# Used packages
pacotes = c("shiny", "shinythemes", "plotly", "shinythemes", "ggplot2", "dplyr", "jiebaR", "jiebaRD",
            "gridExtra", "fmsb", "tidytext", "wordcloud2")

# Run the following command to verify that the required packages are installed. If some package
# is missing, it will be installed automatically
package.check <- lapply(pacotes, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
  }
})

# Data processing for ploting
accidents <- read.csv("Accidents_processed_dataset.csv")

states <- map_data("state") %>% as_tibble() %>% select(long, lat, group, region)

states_abb <- read.csv("data.csv") %>%
  mutate(State = tolower(State)) %>%
  select(State, Code) %>%
  rename("State_full" = State)

accident_count <- accidents %>%
  count(State) %>%
  left_join(states_abb, by = c("State" = "Code"))

states <- states %>%
  left_join(accident_count, by = c("region" = "State_full"))

top_10 <- accidents %>% count(State) %>%
  arrange(desc(n)) %>%
  head(10)

top_10 <- top_10$State %>% unlist()

q1 <- accidents %>% 
  filter(State %in% top_10) %>%
  count(State)

new_accident_count <- accident_count[order(accident_count$n,decreasing = TRUE),]
new_accident_count <- new_accident_count[c(1:20),]

top_10_map <- states %>%
  filter(State %in% top_10)

top_10_label <- top_10_map %>%
  group_by(region, State) %>%
  summarise(long = mean(long), lat = mean(lat))

weather <- accidents %>% group_by(Severity) %>% 
  count(Weather_Condition) %>% mutate(n = n / sum(n)) %>% filter(n > 0.02)

weather <- weather$Weather_Condition

weather_data <- freq(as.character(accidents$Weather_Condition))


