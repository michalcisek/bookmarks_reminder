library(tidyverse)
library(magrittr)
library(rvest)
library(mailR)
library(jsonlite)

source("/home/cisu/bookmarks_reminder/functions.R")

#read bookmarks saved as html file
list.files("/home/cisu/bookmarks_reminder/data/", pattern = "bookmarks.*html") %>% 
  sapply(get_bookmarks_date) %>% 
  which.max %>% 
  names -> books
  
books <- read_html(paste0("/home/cisu/bookmarks_reminder/data/", books))

#extract links from bookmarks
books %>% 
  html_nodes("a") %>% 
  html_attr("href") %>% 
  unique -> links

#load list of already seen bookmarks
if (!file.exists("/home/cisu/bookmarks_reminder/seen_bookmarks.rds")){
  seen_books <- NULL
} else {
  seen_books <- readRDS("/home/cisu/bookmarks_reminder/seen_bookmarks.rds")
}

#remove already seen bookmarks from list
links <- setdiff(links, seen_books)

#sample 7 bookmarks
chosen <- sample(links, 7)

#add sampled links to list of seen bookmarks 
seen_books %<>% c(chosen)

#save already seen bookmarks
saveRDS(seen_books, "/home/cisu/bookmarks_reminder/seen_bookmarks.rds")

#prepare and send mail with chosen bookmarks
body <- paste0("<ul>", paste0("<li>", chosen, "</li>", collapse = ""), "</ul>")
passwd <- read_json("/home/cisu/bookmarks_reminder/passwordGmail.json")$password

send.mail(from = "mcisek93@gmail.com",
          to = "mcisek93@gmail.com",
          subject = "Weekly bookmarks dose!",
          body = body,
          smtp = list(host.name = "smtp.gmail.com", port = 465, 
                      user.name = "mcisek93@gmail.com", passwd = passwd, 
                      ssl = TRUE), 
          authenticate = TRUE, 
          send = TRUE, 
          html = TRUE)
#DISCLAIMER: remember to enable access to 'less secure apps' on your google
#account! http://www.google.com/settings/security/lesssecureapps
