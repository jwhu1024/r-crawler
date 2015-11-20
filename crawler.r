# install.packages("rvest")
library(rvest)

get_page <- function (url, target_type) {
  # this function is used to route
  target_html <- read_html(url, encoding="UTF-8")

  switch (target_type,
          get_href(target_html),         # 1
          get_main_content(target_html), # 2
          get_next_link(target_html))    # 3
}

get_main_content <- function (html) {
  # this function used to get the main content
  content <- html %>%
   html_node("#main-content") %>%
   html_text() %>%
   as.character()
  
  return(content)
}

get_href <- function (html) {
  # this function used to get the href link
  
  ref <- html %>%
    html_nodes(".title a") %>%
    html_attr("href") %>%
    as.data.frame()
  
  return(ref)
}

get_next_link <- function (html) {
  n_link <- html %>%
    html_nodes(".wide:nth-child(2)") %>%
    html_attr("href") %>%
    as.character()
  
  return(n_link)
}

# test area
# t <- get_page("https://www.ptt.cc/bbs/car/index1.html", 3)
# print(t)