list2ascii <- function (x, file=paste(deparse(substitute(x)), ".txt", sep="")) {
  
  # MHP July 7, 2004
  # R or S function to write an R list to an ASCII file.
  # This can be used to create files for those who want to use
  # a spreadsheet or other program on the data.
  #
  tmp.wid = getOption("width")  # save current width
  options(width=10000)          # increase output width
  sink(file)                    # redirect output to file
  print(x)                      # print the object
  sink()                        # cancel redirection
  options(width=tmp.wid)        # restore linewidth
  return(invisible(NULL))       # return (nothing) from function
}

substrRight <- function(x, n) {
  substr(x, nchar(x)-n+1, nchar(x))
}

str_to_file <- function (str, fn) {
  write(str, file = fn, append = FALSE, sep = "")
  print(substrRight(str_c("content output to ", fn), 18))
}

create_output_folder <- function(path) {
  dir.create(path, showWarnings = FALSE)
}
  