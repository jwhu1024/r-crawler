# install.packages("rvest")
library(rvest)

get_page <- function (url, target_type) {
  # this function is used to route
  target_html <- read_html(url)
  
  switch (target_type,
          get_href(target_html),
          get_main_content(target_html))
}

get_main_content <- function (html) {
  # this function used to get the main content
  content <- html %>%
   html_node("#main-content") %>%
   html_text() %>%
   as.data.frame()
}

get_href <- function (html) {
  # this function used to get the href link
  
  ref <- html %>%
    html_nodes(".title a") %>%
    html_attr("href") %>%
    as.data.frame()
}