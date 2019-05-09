
orm.predictwithCI<-function(x, ... , np = 100, fun = plogis, boot.type = "bca" ){
  pred_frame<-rms::Predict(x, ..., type = "model.frame",np=np)
  items<-nrow(pred_frame)
  last_pred <- data.frame(yhat=rep(0,items), lower=rep(0,items), upper=rep(0,items))
  preds<-list()
  j <- 1
  for(i in ((length(x$yunique)-1):1)){
    pred<-rms::Predict(x, ..., type = "predictions", np=np, fun = fun, kint = i, conf.type = "mean", boot.type = boot.type)[9:11]-last_pred
    preds[[j]]<-pred
    j <- j + 1
    all_preds<-last_pred + pred
    last_pred<-pred

  }
  preds[[length(x$yunique)]]<-1-all_preds

  preds <- rev(preds)

  all_preds <- data.frame(preds,check.names = FALSE)

  counter <- 1
  all_preds<-data.frame()
  for(item in x$yunique){

    all_preds <- rbind(all_preds, cbind(pred_frame,preds[[counter]],dependent=item))
    counter <- counter + 1
  }

  #rename columns and set types
  colnames(all_preds)[9]<-c("Propability")
  all_preds$dependent<-as.factor(all_preds$dependent)

  invisible(all_preds)
}



plot.orm.predictwithCI<-function(model, ... , plot_cols = NULL, plot_rows = NULL, label_with_colname = TRUE, facet_lables = NULL, xlab = NULL, ylab= NULL, np = 100, fun = plogis, boot.type = "bca"){

  if(is.null(plot_cols) && is.null(plot_rows)) {
    vars<-ggplot2::vars(...)
    if(length(vars)>1){
      plot_cols<-vars[2]
    }
    if(length(vars)>2){
      plot_rows<-vars[3:length(vars)]
    }

  }
  else{
    plot_cols<-do.call(ggplot2::vars, lapply(plot_cols, as.name))
    plot_rows<-do.call(ggplot2::vars, lapply(plot_rows, as.name))
  }

  res<-orm.predictwithCI(model, ...)
  x<-deparse(substitute(...))
  if(!is.null(facet_lables) && is.list(facet_lables)){
    label_with_colname = FALSE
    for (i in 1:length(facet_lables)){
      levels(res[,names(facet_lables[i])])<-facet_lables[[i]]
    }
  }

  facet_labler<-function(with_colname){
    if(with_colname) return(ggplot2::label_both)
    else return (ggplot2::label_value)
  }


  #set what data to draw and where/how i.e. cran residSD in x etc.
  pred_plot<-ggplot2::ggplot(res, ggplot2::aes_string(x=x, y="Propability", color="dependent")) +

    # add the lines
    ggplot2::geom_line(size=1) +

    # add the coefidence intervals
    ggplot2::geom_ribbon(ggplot2::aes(ymin=lower, ymax=upper, fill= dependent, color=dependent), alpha=0.4, linetype=0) +

    # plot by Rural  sex and max_SEP_3
    ggplot2::facet_grid(rows=plot_rows, cols = plot_cols, labeller =  facet_labler(label_with_colname)) +

    ggplot2::theme_bw() +

    # set the theme values
    ggplot2::theme(
      text = ggplot2::element_text(size = 12),
      axis.text = ggplot2::theme_get()$text
    )

  if(!is.null(xlab)){ pred_plot <- pred_plot + ggplot2::xlab(xlab)}
  if(!is.null(ylab)) {pred_plot <- pred_plot + ggplot2::ylab(ylab)}

  #show the plot
  pred_plot

}
