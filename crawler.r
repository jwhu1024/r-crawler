# install.packages("rvest")
# http://stat4701.github.io/edav/2015/04/02/rvest_tutorial/

library(rvest)

# Store web url
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

#Scrape the website for the movie rating
rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()
rating