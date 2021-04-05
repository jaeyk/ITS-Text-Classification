## -----------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
        tidyverse, # the tidyverse framework
        ggpubr, # arranging ggplots
        ggthemes, # fancy ggplot themes
        tidytext, # tidytext
        patchwork, # arranging images,
        purrr, # functional programming
        here, # reproducibility
        httr, # httr connection 
        jsonlite, # parsing JSON
        glue, # gluing objects and strings         
        rio # import and export files  
)

devtools::install_github("jaeyk/rnytapi", dependencies = TRUE)

library(rnytapi)


## -----------------------------------------------------
#Sys.setenv(nyt_key = "<insert key>")
key <- Sys.getenv("nyt_key")

# Parameters 

begin_year <- 1996:2005
end_year <- 1997:2006
term <- "muslim+muslims"


## -----------------------------------------------------
df1996 <- extract_all(term = 'muslim+muslims', begin_date = '19960911', end_date = '19970911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df1997 <- extract_all(term = 'muslim+muslims', begin_date = '19970911', end_date = '19980911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df1998 <- extract_all(term = 'muslim+muslims', begin_date = '19980911', end_date = '19990911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df1999 <- extract_all(term = 'muslim+muslims', begin_date = '19990911', end_date = '20000911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2000 <- extract_all(term = 'muslim+muslims', begin_date = '20000911', end_date = '20010911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')

df2001a <- extract_all(term = 'muslim+muslims', begin_date = '20010911', end_date = '20011231', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2001b <- extract_all(term = 'muslim+muslims', begin_date = '20021231', end_date = '20030311', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2001c <- extract_all(term = 'muslim+muslims', begin_date = '20020311', end_date = '20020911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')

df2002a <- extract_all(term = 'muslim+muslims', begin_date = '20020911', end_date = '20021231', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2002b <- extract_all(term = 'muslim+muslims', begin_date = '20021231', end_date = '20030311', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2002c <- extract_all(term = 'muslim+muslims', begin_date = '20030311', end_date = '20030911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')

df2003a <- extract_all(term = 'muslim+muslims', begin_date = '20030911', end_date = '20031231', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2003b <- extract_all(term = 'muslim+muslims', begin_date = '20031231', end_date = '20040311', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2003c <- extract_all(term = 'muslim+muslims', begin_date = '20040311', end_date = '20040911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')

df2004a <- extract_all(term = 'muslim+muslims', begin_date = '20040911', end_date = '20041231', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2004b <- extract_all(term = 'muslim+muslims', begin_date = '20051231', end_date = '20050311', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2004c <- extract_all(term = 'muslim+muslims', begin_date = '20050311', end_date = '20050911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')

df2005a <- extract_all(term = 'muslim+muslims', begin_date = '20050911', end_date = '20051231', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2005b <- extract_all(term = 'muslim+muslims', begin_date = '20051231', end_date = '20060311', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2005c <- extract_all(term = 'muslim+muslims', begin_date = '20060311', end_date = '20060711', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')
df2005d <- extract_all(term = 'muslim+muslims', begin_date = '20060711', end_date = '20060911', key = 'lJWFqmFXKLE8yoxN95xLjnyqMFk67a5I')

save(list = ls(pattern = "^df"), file = here("processed_data/nyt_parts.Rdata"))

df <- bind_rows(mget(ls(pattern = "^df")))

df <- df %>%
  # Filter non-successful search results
  filter(status == "OK") %>%
  # Remove duplicates 
  distinct()

write_rds(df, here("processed_data/nyt_articles.Rdata"))


## ----eval=FALSE---------------------------------------
## knitr::purl(input = here("code", "07_additional_text_analysis.Rmd"),
##             output = here("code", "07_additional_text_analysis.r"))

