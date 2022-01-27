library(DBI)

billing <- "mpg-data-warehouse"

con <- dbConnect(
  bigrquery::bigquery(),
  project = "mpg-data-warehouse",
  dataset = "vegetation_biomass",
  billing = billing
)

con
# <BigQueryConnection>
#   Dataset: mpg-ranch-datawarehouse.vegetation_biomass
# Billing: mpg-data-warehouse

dbListTables(con)
# [1] "horizontal_cover_robel"         "pellet_count"                   "vegetation_biomass"             "vegetation_biomass_image_index"
# [5] "vegetation_pfg_biomass"

sql <- "SELECT * FROM `mpg-data-warehouse.vegetation_biomass.vegetation_biomass`"

df <- dbGetQuery(con, sql, n = 10) # n is optional
df <- dbGetQuery(con, sql)

df %>% head()
# A tibble: 6 × 7
# grid_point date    year season grass_g forb_g pooled_g
# <int> <date> <int> <chr>    <dbl>  <dbl>    <dbl>
# 1         50 NA      2016 fall     0.413  1.30        NA
# 2        245 NA      2016 fall     2.94   1.11        NA
# 3         82 NA      2016 fall    10.5    0.1         NA
# 4         51 NA      2016 fall     5.14   0.303       NA
# 5         45 NA      2016 fall     7.98   3.93        NA
# 6         14 NA      2016 fall     7.31   6.04        NA