# install.packages("rvest")
library(rvest)

start_crawler <- function (html, type) {
  switch (type,
          get_href(html),         # 1
          get_main_content(html), # 2
          get_next_link(html))    # 3
}

get_page <- function (url) {
  # this function is used to route
  target_html <- read_html(url, encoding="UTF-8")
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
# tmp <- "https://www.ptt.cc/bbs/car/M.1447335261.A.02B.html"
# html <- get_page(tmp)
# mc <- get_main_content(html)
# source("utils.r")
# str_to_file(mc, "/home/lester/R/project/r-crawler/data/M.1447335261.A.02B.html")
# kdj <- "13312312"

# t <- get_page("https://www.ptt.cc/bbs/car/index1.html", 3)
# print(t)