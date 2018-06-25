get_bookmarks_date <- function(file){
  file %>% 
    strsplit("\\.") %>% 
    `[[`(1) %>% 
    `[`(1) %>% 
    strsplit("_") %>% 
    `[[`(1) %>%  
    `[`(2:4) %>% 
    paste(collapse = "-") %>% 
    as.Date(format = "%m-%d-%y") -> date
  
  return(date)
}
