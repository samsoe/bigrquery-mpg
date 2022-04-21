library(bigrquery)
library(DBI)

billing <- "motus-mpg"

con_motus_raw <- dbConnect(
  bigrquery::bigquery(),
  project = "motus-mpg",
  dataset = "motus_output",
  billing = billing
)

con_motus_raw
# <BigQueryConnection>
#   Dataset: mpg-ranch-datawarehouse.vegetation_biomass
# Billing: mpg-data-warehouse

dbListTables(con_motus_raw)
# [1] "horizontal_cover_robel"         "pellet_count"                   "vegetation_biomass"             "vegetation_biomass_image_index"
# [5] "vegetation_pfg_biomass"

con_motus_summaries <- dbConnect(
  bigrquery::bigquery(),
  project = "motus-mpg",
  dataset = "motus_summaries",
  billing = billing
)

dbListTables(con_motus_summaries)
# [1] "dates_min_max"         "hits_by_site"          "hits_by_site_filtered"



sql_raw <- "SELECT * FROM `motus-mpg.motus_output.alltags_450` LIMIT 1000"

df <- dbGetQuery(con, sql, n = 10) # n is optional
df <- dbGetQuery(con_motus_raw, sql_raw)

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