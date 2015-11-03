# DPLYR

## one-time install
#install.packages("dplyr") 

## now load it 
library("dplyr")          

## load data
surveys <- read.csv('data/portal_data_joined.csv')

## select columns
names(surveys)

select(surveys, plot_id, species_id, weight)
surveys[,c("plot_id", "species_id", "weight")]

# filter rows
filter(surveys, year == 1995)
nrow(filter(surveys, year == 1995))

surveys[surveys$year == 1995,]
nrow(surveys[surveys$year == 1995,])

## pipes

surveys_weight <- filter(surveys, weight < 5) 
surveys_weight_col <- select(surveys_weight, species_id, sex, weight)
surveys_weight_col

surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)


surveys_sml <- surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)
surveys_sml
class(surveys_sml)

surveys %>%
  filter(weight < 10) %>%
  filter(year == 1995) %>%
  select(species_id, sex, weight, year)

surveys %>%
  filter(weight < 10, year == 1995) %>%
  select(species_id, sex, weight, year)


## mutate

surveys %>%
  mutate(weight_kg = weight / 1000)

surveys %>%
  mutate(weight_kg = weight / 1000) %>%
  head()

surveys %>%
  mutate(weight_kg = weight / 1000) %>%
  filter(!is.na(weight)) %>%
  head()

names(surveys)


surveys <- surveys %>%
  mutate(weight_kg = weight / 1000) %>%
  filter(!is.na(weight))


## split-apply-combine or map-reduce

surveys %>%
  group_by(sex) %>%
  tally()

surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys_mw <- surveys %>%
  group_by(sex, species_id) %>%
  summarise(mean_weight = mean(weight))
class(surveys_mw)
surveys_mw

surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>%
  filter(!is.nan(mean_weight))

surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            min_weight = min(weight, na.rm = TRUE)) %>%
  filter(!is.nan(mean_weight))


## Challenges

surveys %>%
  group_by(plot_type) %>%
  tally()

c1 <- surveys %>%
  group_by(species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            min_weight = min(weight, na.rm = TRUE),
            max_weight = max(weight, na.rm = TRUE)) %>% 
  print(n=30, width=Inf)

surveys %>%
  group_by(year) %>%
  select(year, genus, species, weight) %>%
  arrange(desc(weight)) %>%
  top_n(1)

## some extras

c1 %>% glimpse()
c1 %>% arrange(min_weight)

