
orm.forestplot<-function(summary_object){
  oddstable <- orm.oddstable(summary_object)
  tableplot <- plot.oddstable(oddstable)


  return(tableplot)


}


orm.oddstable <- function(x, ..., type="plain", digits = 5, table.env=FALSE)
{
  switch(type,
         latex = rms:::latex.summary.rms(x, ..., file='', table.env=table.env),
         html  = return(rms:::html.summary.rms(x, ...)),
         plain = {
           if(nrow(x)%%2 == 0){
             cstats <- x[c(FALSE, TRUE),c(1:7)]
             dimnames(cstats) <- list(dimnames(x[c(TRUE,FALSE),])[[1]], dimnames(x)[[2]][1 : 7])
             invisible(cstats)
           }
           else{
             stop("Aborting! The number of input rows is odd!")
           }


         }
  )
}

plot.oddstable<-function(x, digits = 3){
  x<-as.data.frame(x)
  lables = colnames(x)
  tableplot<-ggplot2::ggplot(x,ggplot2::aes(y=rownames(x)))+
    ggplot2::geom_text(ggplot2::aes(x=lables[4], label=round(x[,4],digits))) +
    ggplot2::geom_text(ggplot2::aes(x=lables[6], label=round(x[,6], digits))) +
    ggplot2::geom_text(ggplot2::aes(x=lables[7], label=round(x[,7], digits))) +
    ggplot2::scale_x_discrete(position="top", name = NULL) +
    ggplot2::scale_y_discrete(limits= rev(rownames(x))) +
    ggplot2::theme(axis.ticks = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank(),
                   axis.text = ggplot2::theme_get()$text)


  invisible(tableplot)

}

plot.orm.graph<-function(x, custom.row.names = c(), ylab = "Odds ratio (95% CI)"){
    #set the theme
    ggplot2::theme_set(ggplot2::theme_bw())
    #set some other theme options#
    ggplot2::theme_update(
    axis.line = ggplot2::element_line(colour = "black"),
    panel.grid.major = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    panel.border = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank(),
    axis.title.y= ggplot2::element_blank(),
    text = ggplot2::element_text(size = 12),
    plot.margin = grid::unit(c(0,0,0,0), "lines")
  )
    x$lables <-rownames(x)
    print("70")
    if(length(custom.row.names) == nrow(x)){
      x$lables <- custom.row.names
    }

    p<-ggplot2::ggplot(x, aes(x=lables,y=Effect, ymin=`Lower 0.95`, ymax= `Upper 0.95`))+
      ggplot2::geom_pointrange() +

      # add a dotted line at x=1 after flip
      ggplot2::geom_hline(yintercept=1, lty=2) +

      # flip coordinates (puts labels on y axis)
      ggplot2::coord_flip() +
      ggplot2::ylab(ylab) +

      ggplot2::scale_y_continuous(breaks = c(0.5,1,1.5,2,3,4)) +
      # set the y lables sam for plot and table
      ggplot2::scale_x_discrete(limits = rev(tabletext[,1])) +

      # use the theme set prevoiosly
      ggplot2::theme()

    invisible(p)
}



