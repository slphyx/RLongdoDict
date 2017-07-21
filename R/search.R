LongdoDict<-function(engword, view=TRUE){
  api<-paste0("https://dict.longdo.com/mobile.php?search=",engword)
  rawhtml<-read_html(api)
  tempDir <- tempfile()
  dir.create(tempDir)
  htmlFile <- file.path(tempDir, "longdodict.html")
  write_xml(rawhtml,htmlFile)
  if(view){
    rstudioapi::viewer(htmlFile)
  }else{
    return(htmlFile)
  }
}
