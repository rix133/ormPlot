
orm.forestplot<-function(summary_object, plot.widths = c(0.5, 0.5), digits = 3, theme = ggplot2::theme_get(), header = NULL, row.names.y = NULL, return_ggplots = FALSE){
  if(length(plot.widths)!=2 || signif(sum(plot.widths),3)!=1) stop("plot.widths should be a vector with 2 elements that sum to 1")

  oddstable <- orm.oddstable(summary_object)

  if(is.null(row.names.y)) row.names.y = rownames(oddstable)

  tableplot <- plot.oddstable(oddstable, digits = digits, theme = theme, header = header, row.names.y = row.names.y)
  tablegraph <- plot.orm.graph(oddstable, theme = theme, header = header, row.names.y = row.names.y)

  if(return_ggplots){
    return(list(tableplot,tablegraph))

  }
  else{
    forestPlot<- join.ggplots(tableplot, tablegraph, plot.widths)

    invisible(forestPlot)
  }



}

join.ggplots<-function(leftplot, rightplot, plot.widths = c(0.5, 0.5)){
  tablewidth = grid::unit(c(plot.widths[1], plot.widths[2]), c("npc"))
  p1g<-ggplot2::ggplotGrob(leftplot)
  p2g<-ggplot2::ggplotGrob(rightplot)
  forestPlot<-gtable::gtable_row("forestplot", list(p1g, p2g),widths = tablewidth, height = grid::unit(1, "npc"))

  invisible(forestPlot)
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

plot.oddstable<-function(x, digits = 3, theme = ggplot2::theme_get(), header = NULL, row.names.y = rownames(x) ){
  columns = c(4,6,7)

  if(is.vector(header) && length(header) == length(columns)){
    #keep the provided header
  }
  else {
    header <- colnames(x[,columns])
  }
  #setting the theme from the function
  ggplot2::theme_set(theme)

  if(!is.data.frame(x)) x<-as.data.frame(x)

  tableplot<- ggplot2::ggplot(x,ggplot2::aes(y=rownames(x))) +
    ggplot2::scale_x_discrete(position="top", name = NULL, labels = header, breaks =colnames(x[,columns]))

  tableplot<- tableplot +
    ggplot2::geom_text(ggplot2::aes(x=colnames(x)[4], label=round(x[,4],digits))) +
    ggplot2::geom_text(ggplot2::aes(x=colnames(x)[6], label=round(x[,6],digits))) +
    ggplot2::geom_text(ggplot2::aes(x=colnames(x)[7], label=round(x[,7],digits)))

  tableplot <- tableplot +  ggplot2::scale_y_discrete(limits= rev(rownames(x)), labels = rev(row.names.y)) +
    ggplot2::theme(axis.ticks = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_blank(),
                   panel.grid.minor = ggplot2::element_blank(),
                   panel.background = ggplot2::element_blank(),
                   axis.line.x = ggplot2::element_line(colour = "black"),
                   axis.title.y = ggplot2::element_blank(),
                   axis.line.y = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_text(hjust = 1),
                   axis.text = theme$text)

  invisible(tableplot)

}

plot.orm.graph<-function(x, theme = ggplot2::theme_get(), header = NULL, row.names.y = rownames(x),  ylab = "Odds ratio (95% CI)"){
  #set the theme
  ggplot2::theme_set(theme)

  if(!is.data.frame(x)) x<-as.data.frame(x)


  if(!length(row.names.y) == nrow(x)){
    row.names.y = rownames(x)
  }

  p<-ggplot2::ggplot(x, ggplot2::aes(x=row.names.y,y=Effect, ymin=`Lower 0.95`, ymax= `Upper 0.95`))+
    ggplot2::geom_pointrange() +

    # add a dotted line at x=1 after flip
    ggplot2::geom_hline(yintercept=1, lty=2) +

    # flip coordinates (puts labels on y axis)
    ggplot2::coord_flip() +
    #ggplot2::ylab(ylab) +
    #TODO set the breaks at appropriate places automatically and allow override
    ggplot2::scale_y_continuous(breaks = c(0.5,1,1.5,2,3,4), position = "right") +
    # set the y lables sam for plot and table
    ggplot2::scale_x_discrete(limits = rev(row.names.y)) +

    # use the theme set prevoiosly
    ggplot2::theme(
      axis.ticks.x.top = ggplot2::element_line(colour = "black"),
      axis.line = ggplot2::element_line(colour = "black"),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      panel.border = ggplot2::element_blank(),
      panel.background = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank(),
      axis.title.y= ggplot2::element_blank(),
      axis.title.x= ggplot2::element_blank(),
      text = ggplot2::element_text(size = 12),
      axis.text = theme$text,
      plot.margin = grid::unit(c(0,0,0,0), "lines")
    )

  invisible(p)
}



