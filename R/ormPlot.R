forestplot<-function(summary_object){
  print("not Implemented")
}


orm.oddstable <- function(x, ..., type="plain", digits = 5, table.env=FALSE)
{
  switch(type,
         latex = rms:::latex.summary.rms(x, ..., file='', table.env=table.env),
         html  = return(rms:::html.summary.rms(x, ...)),
         plain = {
           cstats <- x[c(FALSE, TRUE),c(1:7)]
           dimnames(cstats) <- list(dimnames(x[c(TRUE,FALSE),])[[1]], dimnames(x)[[2]][1 : 7])
           invisible(cstats)
         }
  )
}
