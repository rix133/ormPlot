forestplot<-function(summary_object){
  print("not Implemented")
}


orm.oddstable <- function(x, ..., type="plain", digits = 5, table.env=FALSE)
{
  switch(type,
         latex = rms:::latex.summary.rms(x, ..., file='', table.env=table.env),
         html  = return(rms:::html.summary.rms(x, ...)),
         plain = {
           rows <- nrow(x)%/%2
           cstats <- dimnames(x)[[1]][seq(1,rows,2)]
           for(i in 1 : 7) {
             cstats <- cbind(cstats, format(signif(x[c(FALSE, TRUE), i], digits)))
             }
           dimnames(cstats) <- list(rep("", nrow(cstats)), 
                                    c("Factor", dimnames(x)[[2]][1 : 7]))
           return(cstats)
         }
  )
  invisible()
}