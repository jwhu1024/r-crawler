source("utils.r")
source("crawler.r")

get_type_home_href <- 1
ppt_site <- "https://www.ptt.cc"
ppt_site_cat <- "/bbs/car/"
ppt_site_page <- "index.html"

# get full address for ptt car
href_link <- get_page(paste(ppt_site, ppt_site_cat, ppt_site_page, sep = ""), 1)

# iterator the href_link list
for (href in href_link[, 1]) {
  ppt_url <- paste(ppt_site, href, sep = "")
  print(ppt_url)
  print(1)
}
