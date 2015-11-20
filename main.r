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
get_type_next_link <- 3

subdir <- "data"

# initial before running
basedir <- str_c(getwd(), "/", subdir)
create_output_folder(basedir)

# set init value for index before crawling (R is one-based)
idx_s <- 1

repeat{
  
  # get full address for ptt car
  href_link <- get_page(ppt_car_home, get_type_href)
  
  # get the list length
  ref_len <- length(href_link[,1])
  
  href <- href_link[idx_s, 1]
  idx_s <- idx_s + 1
  
  ppt_url <- str_c(ppt_site, href)
  
  # fetch main content
  mc <- get_page(ppt_url, get_type_m_content)
  
  # path concatenation
  full_path <- str_c(basedir,
                     "/",
                     str_sub(href, str_length(ppt_site_cat) + 1, str_length(href) - 5))
  
  # write to file (just for debug?)
  str_to_file(mc, full_path)
  
  # next page not exist) {
  if (idx_s == ref_len) {
    next_link <- get_page(ppt_car_home, get_type_next_link)
    
    # maybe this page is the last
    if (is.na(next_link)) {
      print("last page arrived!")
      break;
    }
    
    # update the next page address
    ppt_car_home <- paste(ppt_site, next_link, sep = "")
    
    # reset this index for the next page
    idx_s <- 1
  }
}

print("done")