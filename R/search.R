LongdoDict<-function(word, view=TRUE){
  if(missing(word)){
    stop("Please input a word, i.e., LongdoDict('freedom')")
  }
  api<-paste0("https://dict.longdo.com/mobile.php?search=",word)
  rawhtml<-read_html(api)
  tempDir <- tempfile()
  dir.create(tempDir)
  htmlFile <- file.path(tempDir, "longdodict.html")
  write_xml(rawhtml,htmlFile)
  if(view){
    rstudioapi::viewer(htmlFile)
  }else{
    message(paste0("Your output from Longdo Dictionary is saved at.. "))
    return(htmlFile)
  }
}


ViewLongdoDict <- function(localurl, viewer = "rstudio", ...){
  if(viewer=="rstudio"){
    rstudioapi::viewer(url = localurl,...)
  }
  if(viewer=="browser"){
    utils::browseURL(url = localurl,...)
  }
}