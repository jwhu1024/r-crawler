library(stringr)
source("utils.r")
source("crawler.r")

ppt_site      <- "https://www.ptt.cc"
ppt_site_cat  <- "/bbs/car/"
ppt_site_page <- "index.html"
ppt_car_home  <- paste(ppt_site, ppt_site_cat, ppt_site_page, sep = "")

# some definition for this process
get_type_href      <- 1
get_type_m_content <- 2
get_type_next_link <- 3

subdir <- "data"

# initial before running 
basedir <- str_c(getwd(), "/", subdir)
create_output_folder(basedir)

idx_s    <- 1    # set init value for index before crawling (R is one-based)
update   <- TRUE # update flag indicates that when we should get page again
ref_len  <- 0    # times we should get in current page
total_th <- 0    # record how many thread we have crawled

repeat {
  try({
    if (update == TRUE) {
      # get full address for ptt car
      home_html <- get_page(ppt_car_home)
      href_link <- start_crawler(home_html, get_type_href);
      
      # get the list length
      ref_len <- length(href_link[ ,1])
      update <- FALSE
    }
    
    href <- href_link[idx_s, 1]
    idx_s <- idx_s + 1
    
    ppt_url <- str_c(ppt_site, href)
    
    # fetch main content
    thr_html <- get_page(ppt_url)
    mc <- start_crawler(thr_html, get_type_m_content);
    
    # path concatenation
    full_path <- str_c(basedir,
                       "/",
                       str_sub(href, str_length(ppt_site_cat) + 1, str_length(href) - 5))
    
    # write to file (just for debug?)
    str_to_file(mc, full_path)
    
    # next page
    if (idx_s - 1 == ref_len) {
      
      next_link <- start_crawler(home_html, get_type_next_link);
      
      # maybe this page is the last
      if (is.na(next_link)) {
        print("last page arrived!")
        break;
      }
      
      # update the next page address
      ppt_car_home <- str_c(ppt_site, next_link)
      
      # total
      total_th <- total_th + ref_len
      print(str_c("Until now we crawled ", total_th))
      
      # reset some variable for the next page
      idx_s <- 1
      update <- TRUE
      
      cleanMem()
      
      # We'll get 503 error if we hit that site too quickly
      Sys.sleep(3)
    }
    print(".")
    Sys.sleep(0.3)
  })
}

print("DONE")