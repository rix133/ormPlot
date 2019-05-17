#' Create a Prediction data.frame with coeficent intervals
#'
#' returns a \code{data.frame} object similar to the \code{\link[rms]{Predict}}
#' however it adds a column dependent that lists all factor levels with
#' appropriate cofficent intervals calcualted for each level
#'
#' @inheritParams rms::Predict
#'
#' @return a \code{data.frame}
#'
#' @seealso \code{\link[rms]{Predict}}
#' @export
orm.predict_with_ci <- function(x, ..., np = 100,
                              fun = stats::plogis,
                              conf.int = 0.95,
                              boot.type = "bca") {

    pred_frame <- rms::Predict(x, ..., type = "model.frame", np = np)
    items <- nrow(pred_frame)
    last_pred <- data.frame(yhat = rep(0, items),
                            lower = rep(0, items),
                            upper = rep(0, items))
    preds <- list()
    j <- 1
    for (i in ( ( length(x$yunique) - 1):1)) {
        pred <- rms::Predict(x, ..., type = "predictions",
                             np = np, fun = fun, kint = i,
                             conf.type = "mean",
                             conf.int = conf.int,
                             boot.type = boot.type)[9:11] - last_pred
        preds[[j]] <- pred
        j <- j + 1
        all_preds <- last_pred + pred
        last_pred <- pred

    }
    preds[[length(x$yunique)]] <- 1 - all_preds

    preds <- rev(preds)

    all_preds <- data.frame(preds, check.names = FALSE)

    counter <- 1
    all_preds <- data.frame()
    for (item in x$yunique) {

        all_preds <- rbind(all_preds, cbind(pred_frame, preds[[counter]],
                                            dependent = item))
        counter <- counter + 1
    }

    # rename columns and set types
    colnames(all_preds)[9] <- c("Propability")
    all_preds$dependent <- as.factor(all_preds$dependent)

    invisible(all_preds)
}

#' Plot the prediction with coeficent intervals
#'
#' This fuction plots the model predictions given that all variables that are
#' not included in the plot are kept constant. Hence it requres at least one
#' variable to produce a plot.
#' returns a \code{ggplot} object that can be further customized like any
#' other ggplot
#
#'
#' @inheritParams orm.predict_with_ci
#' @param xval The model value plotted on the x axis
#' @param xlab A custom x-axis value (if specified)
#' @param ylab A custom y-axis value (if specified)
#' @param plot_rows  A vector of strings with other model components that
#'  should be plotted. These are put on rows.
#' @param plot_cols A vector of strings with  other model components that
#'  should be plotted. These are put on columns.
#' @param facet_labels A  named list of new names for varaibles on rows and
#'  columns
#' @param label_with_colname Should he variable name also be included on plot
#' row and column names
#' @param ... additional paremeters taht will be passed to \code{\link[rms]{Predict}}
#'
#'
#'
#' @return a \code{ggplot} plot object
#'
#' @seealso \code{\link[rms]{Predict}}
#' @export
plot.orm <- function(x, xval, plot_cols = c(),
                     plot_rows = c(),
                     label_with_colname = TRUE,
                     facet_labels = NULL,
                     xlab = NULL, ylab = NULL, np = 100,
                     fun = stats::plogis, boot.type = "bca",
                     conf.int = 0.95, ...) {

    plot_rows_str <- c()
    plot_cols_str <- c()
    if(tryCatch(is.character(plot_cols), error = function(e) FALSE))
    {plot_cols_str <- plot_cols}
    else{
        char_cols <- as.character(substitute(plot_cols))
        if(is.name(substitute(plot_cols))) { plot_cols_str <- char_cols}
        else if (is.call(substitute(plot_cols)) && char_cols[1] == "c" )
        { plot_cols_str <- char_cols[-1]}
        else  stop("Invalid plot_columns")
    }


    if(tryCatch(is.character(plot_rows), error = function(e) FALSE))
    {plot_rows_str <- plot_rows}
    else{
        char_rows <- as.character(substitute(plot_rows))
        if(is.name(substitute(plot_rows))) { plot_rows_str <- char_rows}
        else if (is.call(substitute(plot_rows)) && char_rows[1] == "c" )
        { plot_rows_str <- char_rows[-1]}
        else  stop("Invalid plot_rows ")
    }


    plot_cols <- do.call(ggplot2::vars, lapply(plot_cols_str, as.name))
    plot_rows <- do.call(ggplot2::vars, lapply(plot_rows_str, as.name))


    new_args<-c(substitute(xval), plot_cols_str, plot_rows_str, list(...))

    res <- do.call(orm.predict_with_ci,c(list(x=x),
                                         as.list(new_args),
                                         list(fun = fun,
                                         boot.type = boot.type,
                                         conf.int = conf.int)))


    if (!is.null(facet_labels) && is.list(facet_labels)) {
        label_with_colname <- FALSE
        for (i in 1:length(facet_labels)) {
            levels(res[, names(facet_labels[i])]) <- facet_labels[[i]]
        }
    }

    facet_labelr <- function(with_colname) {
        if (with_colname)
            return(ggplot2::label_both) else return(ggplot2::label_value)
    }


    # set what data to draw and where/how i.e. cran residSD in x etc.
    pred_plot <- ggplot2::ggplot(res,
                                 ggplot2::aes_string(
                                     x = as.character(substitute(xval)),
                                     y = "Propability",
                                     color = "dependent")) +
    # add the lines
    ggplot2::geom_line(size = 1) +
    # add the coefidence intervals
    ggplot2::geom_ribbon(ggplot2::aes(ymin = lower,
                                      ymax = upper,
                                      fill = dependent,
                                      color = dependent),
                         alpha = 0.4, linetype = 0) +
    # plot by Rural sex and max_SEP_3
    ggplot2::facet_grid(rows = plot_rows,
                        cols = plot_cols,
                        labeller = facet_labelr(label_with_colname)) +
    ggplot2::theme_bw() +
    # set the theme values
    ggplot2::theme(text = ggplot2::element_text(size = 12),
                   axis.text = ggplot2::theme_get()$text)

    if (!is.null(xlab)) {
        pred_plot <- pred_plot + ggplot2::xlab(xlab)
    }
    if (!is.null(ylab)) {
        pred_plot <- pred_plot + ggplot2::ylab(ylab)
    }

    # show the plot
    pred_plot

}

#' Function to convert any input to string vector
#'
#' @param x string, object name or vector of theese
#' @return vector of strings
convert_arg<-function(x){

    sx <- substitute(x)
    a <- tryCatch(is.character(x), error = function(e) FALSE)
    if (a) {
        new_x <- x
    } else {
        cx <- as.character(sx)
        if (is.name(sx)) {
            new_x <- cx
        } else if (is.call(sx) && cx[1] == "c") {
            new_x <- cx[-1]
        } else {
            stop("Invalid column or row names")
        }
    }

    invisible(c(new_x))
}
