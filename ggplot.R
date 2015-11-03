# plotting package
library(ggplot2)
# piping / chaining
library(magrittr)
# modern dataframe manipulations
library(dplyr)

surveys <- read.csv('data/portal_data_joined.csv')

summary(surveys)

surveys_complete <- surveys %>%
  filter(!is.na(weight)) %>%          # remove missing weight
  filter(!is.na(hindfoot_length))     # remove missing hindfoot_length

dim(surveys_complete)


# count records per species
species_select <- surveys_complete %>%
  group_by(species_id) %>%
  tally %>%
  filter(n >= 10) %>%
  select(species_id)

species_select

surveys_select <- surveys_complete %>%
  filter(species_id %in% species_select$species_id) %>%
  select(species_id, weight, hindfoot_length, year)

plot(x = surveys_select$weight, y = surveys_select$hindfoot_length)

## ggplot
ggplot(data = surveys_select, aes(x = weight, y = hindfoot_length)) +
  geom_point()

ggplot(data = surveys_select, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)

ggplot(data = surveys_select, aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")


### boxplot
ggplot(data = surveys_select, aes(x = species_id,  y = weight)) +
  geom_boxplot()

ggplot(data = surveys_select, aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_boxplot(alpha = 0)

### Time series

# skip this at the moment to show need for year
surveys_select <- surveys_complete %>%
  filter(species_id %in% species_select$species_id) %>%
  select(species_id, weight, hindfoot_length, year)

yearly_counts <- surveys_select %>%
  group_by(year, species_id) %>%
  tally

ggplot(data = yearly_counts, aes(x = year, y = n)) +
  geom_line()

ggplot(data = yearly_counts, aes(x = year, y = n, group = species_id)) +
  geom_line()

ggplot(data = yearly_counts, aes(x = year, y = n, group = species_id, color = species_id)) +
  geom_line()

### facetting

ggplot(data = yearly_counts, aes(x = year, y = n, color = species_id)) +
  geom_line() + facet_wrap(~species_id)

### challenge

sex_values = c("F", "M")
surveys_select_sex <- surveys_complete %>%
  filter(species_id %in% species_select$species_id) %>%
  filter(sex %in% sex_values) %>% 
  select(species_id, sex, year)

yearly_sex_counts <- surveys_select_sex %>%
  group_by(year, species_id, sex) %>%
  tally

ggplot(data = yearly_sex_counts, aes(x = year, y = n, color = sex, group = sex)) +
  geom_line() + facet_wrap(~ species_id)

