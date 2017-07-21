
LongdoDictAddin <- function() {
  
  ui <- miniPage(
      textInput("text", label =  "คำศัพท์ที่ต้องการค้นความหมาย ",value = "computer"),
       actionButton("search","ค้น",width=50),
       actionButton("exit","Exit",width =50)
    ,
    miniContentPanel(
      uiOutput("inc")
    )
    
  )
  
  server <- function(input, output) {
    writehtml <- function(inputtext){
      api<-paste0("https://dict.longdo.com/mobile.php?search=",inputtext)
      rawhtml<-read_html(api)
      tempDir <- tempfile()
      dir.create(tempDir)
      htmlfile <- file.path(tempDir, "longdodict.html")
      write_xml(rawhtml,htmlfile)
      return(htmlfile)
    }
    
    getPage<-function(inputtext) {
      htmlfile.path <- writehtml(inputtext)
      return(includeHTML(htmlfile.path))
    }
    
    observe({
      if(input$search>0)
        output$inc<-renderUI({getPage(inputtext = input$text)})
    })
    
    observe({
      if(input$exit>0)
        stopApp()
    })
    
  }
  
  runGadget(ui, server, viewer = dialogViewer("LondoDict"))
}


LongdoDictAddin()
