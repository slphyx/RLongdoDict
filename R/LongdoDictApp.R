LongdoDictAddin <- function() {
  
  ui <- miniPage(
    miniTitleBar(title = "LongdoDict"),
       textInput("text", label =  "Enter Thai or English word",value = "computer"),
       actionButton("search","Go!",width=50),
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
    
    
    observeEvent(input$search,{
      out.page <- getPage(inputtext = input$text)
      output$inc <- renderUI(out.page)}
      )    

    observeEvent(input$exit,stopApp())
    
  }
  
  runGadget(ui, server, viewer = dialogViewer("LondoDict"))
}

