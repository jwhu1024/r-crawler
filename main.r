library("stringr")
source("utils.r")
source("crawler.r")

ppt_site <- "https://www.ptt.cc"
ppt_site_cat <- "/bbs/car/"
ppt_site_page <- "index.html"
ppt_car_home <- paste(ppt_site, ppt_site_cat, ppt_site_page, sep = "")

# some definition for this process
get_type_href <- 1
get_type_m_content <- 2

subdir <- "data"

# initial before running
basedir <- str_c(getwd(), "/", subdir)
create_output_folder(basedir)

# get full address for ptt car
href_link <- get_page(ppt_car_home, get_type_href)

# iterator the href_link list
for (href in href_link[, 1]) {
  
  ppt_url <- str_c(ppt_site, href)
  
  # fetch main content
  mc <- get_page(ppt_url, get_type_m_content)
  
  # path concatenation
  full_path <- str_c(basedir,
                     "/",
                     str_sub(href, str_length(ppt_site_cat) + 1, str_length(href) - 5))
  
  # write to file (just for debug?)
  str_to_file(mc, full_path)
}
 