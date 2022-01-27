library(bigrquery)
library(dplyr)

billing <- "mpg-data-warehouse"

# dataset connection variables
con <- dbConnect(
  bigrquery::bigquery(),
  project = "mpg-data-warehouse",
  dataset = "weather_summaries",
  billing = billing
)

# connect to dataset
weather <- tbl(con, "mpg_ranch")

# get list of column names
weather %>%
  collect() %>% 
  names()

# load table into dataframe
df <- weather %>%
  select(station_name, datetime, temp_f) %>% # column selection
  head(10) %>% # omit for full dataset
  collect()

df %>% head()
