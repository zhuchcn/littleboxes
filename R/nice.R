dd <- function(x,l=60) {
  if (nchar(x) <= (l-10)) { # ptet pas -4 ici
    base <- (l - nchar(x) - 2)/2
    return(paste(c("####", rep(" ", floor(base)-3), x, rep(" ",
      ceiling(base)-3), "####"), collapse = ""))
  }
  
  s1 <- strsplit(x, "\\s")[[1]]
  
  # si s1 trop long on découpe arbitraitement au milieu
  if (length(s1)==1){
    coupe <- nchar(s1)/2
    s1 <- c(substr(s1,1,coupe),    substr(s1,1+coupe,nchar(s1)))
  }
  
  c(Recall(
    paste(s1[1:floor(length(s1)/2)], collapse = " "),l=l
    ), 
    Recall(
      paste(s1[(1+floor(length(s1)/2)):length(s1)],collapse = " "),l=l
      )
    )
}


toutbeau <- function(x, l = 60) {
  # print(x)
  x <- gsub("\n", " ", x)
  x <- gsub("\t", " ", x)
  x <- gsub("^[# ]+", "", x)
  x <- gsub("[# =]+$", " ", x)
  x <- gsub(" $", " ", x)
  res <- paste(c("##%",rep("#", l-6),"%##"), collapse = "")
  res <- c(res, paste(c("#", rep(" ", l - 2), "#"), collapse = ""))
  res <- c(res, do.call(c, as.list(dd(x,l=l))))
  res <- c(res, paste(c("#", rep(" ", l - 2), "#"), collapse = ""))
  res <- c(res, paste(c("##%",rep("#", l-6),"%##"), collapse = ""))
  res <- c(res, "")
  res
  res <- paste(res, collapse = "\n")
  return(res)
}

littleboxes <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  for (sel in context$selection) {
    # print(sel)
    if (sel$text != "") {
      rstudioapi::modifyRange(sel$range, toutbeau(sel$text),
        context$id)
      break
    } else {

      lign <- context$selection[[1]]$range$start[["row"]]
      value <- context$contents[lign]
      range <- structure(list(start = structure(c(lign,
        1), .Names = c("row", "column"), class = "document_position"),
        end = structure(c(lign, 77777), .Names = c("row",
          "column"), class = "document_position")), .Names = c("start",
        "end"), class = "document_range")

      if (value != "") {
        rstudioapi::modifyRange(range, toutbeau(value),
          context$id)
      }
    }
  }
}

`%+%` = function(x,y){paste0(x,y)}

headerbeau <- function(x, l = 80){
  x <- gsub("\n", " ", x)
  x <- gsub("\t", " ", x)
  x <- gsub("^[# ]+", "", x)
  x <- gsub("[# =]+$", " ", x)
  x <- gsub(" $", " ", x)
  res <- "## -------- " %+% x %+% " " %+% 
    paste(rep("-", l-13-nchar(x)), collapse = "") 
  return(res)
}

littleHeader <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  for (sel in context$selection) {
    # print(sel)
    if (sel$text != "") {
      rstudioapi::modifyRange(sel$range, headerbeau(sel$text),
                              context$id)
      break
    } else {
      
      lign <- context$selection[[1]]$range$start[["row"]]
      value <- context$contents[lign]
      range <- structure(list(
        start = structure(c(lign,1), 
                          .Names = c("row", "column"), 
                          class = "document_position"),
        end = structure(c(lign, 77777), 
                        .Names = c("row","column"), 
                        class = "document_position")), 
        .Names = c("start","end"), 
        class = "document_range")
      
      if (value != "") {
        rstudioapi::modifyRange(range, toutbeau(value),context$id)
      }
    }
  }
}

toutbeau2 = function(x){
  x <- gsub("\n", " ", x)
  x <- gsub("\t", " ", x)
  x <- gsub("^[# ]+", "", x)
  x <- gsub("[# =]+$", " ", x)
  x <- gsub(" $", " ", x)

  res <- paste(rep("#", 80), collapse = "") %+% 
    "\n##########" %+% 
    paste(rep(" ",floor((80-nchar(x)-20)/2)), collapse = "") %+%
    x %+% 
    paste(rep(" ",ceiling((80-nchar(x)-20)/2)), collapse = "") %+%
    "##########\n" %+% 
    paste(rep("#", 80), collapse = "")
  return(res)
}

littleboxes2 <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  for (sel in context$selection) {
    # print(sel)
    if (sel$text != "") {
      rstudioapi::modifyRange(sel$range, toutbeau2(sel$text),
                              context$id)
      break
    } else {
      
      lign <- context$selection[[1]]$range$start[["row"]]
      value <- context$contents[lign]
      range <- structure(list(start = structure(c(lign,
                                                  1), .Names = c("row", "column"), class = "document_position"),
                              end = structure(c(lign, 77777), .Names = c("row",
                                                                         "column"), class = "document_position")), .Names = c("start",
                                                                                                                              "end"), class = "document_range")
      
      if (value != "") {
        rstudioapi::modifyRange(range, toutbeau(value),
                                context$id)
      }
    }
  }
}