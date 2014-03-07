.x <- function() {
 v=data(package='Mutsel')
 data(list = v$results[,3])
}

.First <- function(){
 library(Mutsel)
 utils::loadhistory("~/.Rhistory.Mutsel")
 cat("Mutsel .x()","\n")
}

.Last <- function() {
  if(interactive()) {
    savehistory("~/.Rhistory.Mutsel")
  }
}
options(width=150)
options(max.print=2000)
