install.packages("RSQLite")
library("RSQLite")

download.file("http://files.figshare.com/1919743/portal_mammals.sqlite","data/portal_mammals.sqlite")

portaldb <- src_sqlite("data/portal_mammals.sqlite")

portaldb

surveys <- tbl(portaldb, "surveys")

class(surveys)

surveys_sql <- surveys %>%
  filter(!is.na(weight)) %>%          # remove missing weight
  filter(!is.na(hindfoot_length))     # remove missing hindfoot_length

dim(surveys_sql)
surveys_sql
