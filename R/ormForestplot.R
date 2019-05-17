#' Get an extended rms summary object
#'
#' This fuctions adds a \code{summary.orm} class attribute to a
#' \code{summary.rms} output to facilitate the automatic plotting
#'  of orm summary into a ggplot forestplot
#'
#' @param object a \code{\link[rms]{orm}}  model object
#' @param ... parameters passed to \code{\link[rms]{summary.rms}}
#' @aliases summary.orm
#' @method summary orm
#' @export
"summary.orm"<-function(object, ...){
    UseMethod("orm_summary")

}

#' @rdname summary.orm
#' @export
orm_summary.default<-function(object,...){
    summary_obj<-rms:::summary.rms(object, ...)
    #for plotting function to use the custom plot for orm
    attr(summary_obj, "class") <- c("summary.orm", class(summary_obj))
    return(summary_obj)
}

#' Forest Plot of an orm model summary
#'
#' Convinience function to create a plot of the \code{\link[rms]{orm}}  model
#' summary. For further customising the plots use \code{return_ggplots = TRUE}
#' This will create 2 \code{ggplot2} objects that can be joined with the
#' \code{\link{join_ggplots}} commands.
#'
#' @inheritParams forestplot
#' @param ... paremeters passed to \code{\link{forestplot}}
#' @method plot summary.orm
#' @export
"plot.summary.orm"<-function(x, ...){
    UseMethod("forestplot")
}


#' Forest Plot of an orm model summary
#'
#' Convinience function to create a plot of the \code{\link[rms]{orm}}  model
#' summary. For further customising the plots use \code{return_ggplots = TRUE}
#' This will create 2 \code{ggplot2} objects that can be joined with the
#' \code{\link{join_ggplots}} commands.
#'
#' @param return_ggplots if \code{TRUE} the fuction returns 2 ggplot objects
#'  in a list instead of drawing a tablegrid
#' @param  x result of a \code{summary} command on
#'  \code{\link[rms]{orm}}  model ie a summary.orm class object
#' @inheritParams join_ggplots
#' @inheritDotParams oddstable_graph
#' @aliases forestplot.orm
#' @export
forestplot <- function(x, return_ggplots = FALSE,
                               plot.widths = c(0.5, 0.5),
                               title = "Odds Ratio" , ...) {

    oddstable <- oddstable(x)

    tableplot <- oddstable_graph(oddstable, ...)

    tablegraph <- orm_graph(oddstable, ...)

    if (return_ggplots) {
        return(list(tableplot, tablegraph))

    } else {
        forestplot <- join_ggplots(tableplot, tablegraph, ...)
        invisible(forestplot)
    }



}
#' @rdname forestplot
#' @export
forestplot.default <- function(x, ...){
    forestplot(x, ...)
}

#' Join two ggplot objects side by side
#'
#' Function to get aligned table of two ggplot objects
#'
#'
#' @param leftplot the left side plot
#' @param rightplot the plot on the right
#' @param plot.widths the relative widths of the left and right plot
#' should be a vector (\code{c()})  with 2 elements that sum to 1 defaults to
#' equal widths
#' @param title the tile row of the drawn plot
#'
#' @export
join_ggplots <- function(leftplot, rightplot,
                         plot.widths = c(0.5, 0.5),
                         title = "Odds Ratio") {
    if (length(plot.widths) != 2 || signif(sum(plot.widths), 3) != 1)
        stop("plot.widths should be a vector with 2 elements that sum to 1")

    tablewidth <- grid::unit(c(plot.widths[1], plot.widths[2]), c("npc"))
    p1g <- ggplot2::ggplotGrob(leftplot + ggplot2::labs(subtitle = ""))
    p2g <- ggplot2::ggplotGrob(rightplot + ggplot2::labs(subtitle = title))
    forestplot <- gtable::gtable_row("forestplot", list(p1g, p2g),
                                     widths = tablewidth,
                                     height = grid::unit(1, "npc"))
    grid::grid.newpage()
    grid::grid.draw(forestplot)
    invisible(forestplot)
}
#' Get row names from odd an values form even columns
#' @param x a \code{maxtrix} with even number of rows
oddstable <- function(x) {
        if (nrow(x) %% 2 == 0) {
            cstats <- x[c(FALSE, TRUE), c(1:7)]
            dimnames(cstats) <- list(dimnames(x[c(TRUE, FALSE), ])[[1]],
                                     dimnames(x)[[2]][1:7])
            invisible(cstats)
        } else {
            stop("Aborting! The number of input rows is odd!")
        }

}

#' Make a ggplot table
#'
#' Function to get a ggplot table from a matrix
#'
#' @param x a \code{maxtrix} or a \code{data.frame}
#' @param digits the number of siginficants digits to display
#' @param theme the desired ggplot2 theme
#' @param header names of the table columns
#' @param row.names.y new names for the variable rows
#' @inheritDotParams ggplot2::theme
#'
oddstable_graph <- function(x, digits = 3, theme = ggplot2::theme_get(),
                           header = NULL, row.names.y = NULL, ...) {
    columns <- c(4, 6, 7)

    if (is.null(row.names.y))
        row.names.y <- rownames(x)

    if (is.vector(header) && length(header) == length(columns)) {
        # keep the provided header
    } else {
        header <- colnames(x[, columns])
        #rename the first
        header[1] <- "Est."
    }
    # setting the theme from the function
    ggplot2::theme_set(theme)

    if (!is.data.frame(x))
        x <- as.data.frame(x)

    tableplot <- ggplot2::ggplot(x, ggplot2::aes(y = rownames(x))) +
        ggplot2::scale_x_discrete(position = "top",
                                  name = NULL,
                                  labels = header,
                                  breaks = colnames(x[, columns]))

    tableplot <- tableplot +
        ggplot2::geom_text(ggplot2::aes(x = colnames(x)[4],
                                        label = round(x[, 4], digits))) +
        ggplot2::geom_text(ggplot2::aes(x = colnames(x)[6],
        label = round(x[, 6], digits))) +
        ggplot2::geom_text(ggplot2::aes(x = colnames(x)[7],
                                        label = round(x[, 7], digits)))

    tableplot <- tableplot +
        ggplot2::scale_y_discrete(limits = rev(rownames(x)),
                                  labels = rev(row.names.y)) +
        ggplot2::theme(axis.ticks = ggplot2::element_blank(),
        panel.grid.major = ggplot2::element_blank(),
        panel.grid.minor = ggplot2::element_blank(),
        panel.background = ggplot2::element_blank(),
        axis.line.x = ggplot2::element_line(colour = "black"),
        axis.title.y = ggplot2::element_blank(),
        axis.line.y = ggplot2::element_blank(),
        axis.text.y = ggplot2::element_text(hjust = 1),
        axis.text = theme$text,
        plot.margin = grid::unit(c(0, 0, 0, 0), "lines"))

    tableplot <- tableplot + ggplot2::theme(...)

    invisible(tableplot)

}
#' Make a ggplot figure
#'
#' Function to get a ggplot figure from a matrix x
#'
#' @param x a \code{maxtrix} or a \code{data.frame}
#' @param theme the desired ggplot2 theme
#' @param header names of the table columns
#' @param row.names.y new names for the variable rows
#' @inheritDotParams ggplot2::theme
#'
orm_graph <- function(x, theme = ggplot2::theme_get(), header = NULL,
                           row.names.y = NULL,
                            ...) {
    # set the theme
    ggplot2::theme_set(theme)

    if (!is.data.frame(x))
        x <- as.data.frame(x)

    if (is.null(row.names.y))
        row.names.y <- rownames(x)


    if (!length(row.names.y) == nrow(x)) {
        vars <- paste(rownames(x), collapse = "\", \"")
        stop(paste("The provided variable names are not covering all options: ",
                   vars))
    }
    if(is.null(header)){
        header <- c(colnames(x)[4], colnames(x)[6], colnames(x)[7])
    }

    colnames(x)<-make.names(colnames(x))
    x$names <- row.names.y
    p <- ggplot2::ggplot(x, ggplot2::aes_string(x = "names", y = "Effect",
                                         ymin = "Lower.0.95",
                                         ymax = "Upper.0.95")) +
        ggplot2::geom_pointrange() +
    # add a dotted line at x=1 after flip
    ggplot2::geom_hline(yintercept = 1, lty = 2) +
    # flip coordinates (puts labels on y axis)
    ggplot2::coord_flip() +
    # TODO set the breaks at appropriate places automatically and allow override
    ggplot2::scale_y_continuous(breaks = c(0.5, 1, 1.5, 2, 3, 4),
                                position = "right") +
    # set the y lables sam for plot and table
    ggplot2::scale_x_discrete(limits = rev(row.names.y)) +
    # use the theme set prevoiosly
    ggplot2::theme(axis.ticks.x.top = ggplot2::element_line(colour = "black"),
                   axis.line = ggplot2::element_line(colour = "black"),
                   panel.grid.major = ggplot2::element_blank(),
                   panel.grid.minor = ggplot2::element_blank(),
                   panel.border = ggplot2::element_blank(),
                   panel.background = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank(),
                   axis.title.y = ggplot2::element_blank(),
                   axis.title.x = ggplot2::element_blank(),
                   text = ggplot2::element_text(size = 12),
                   axis.text = theme$text,
                   plot.margin = grid::unit(c(0, 0, 0, 0), "lines"))

    #add theme elements from passed on objects
    p <- p + ggplot2::theme(...)

    invisible(p)
}
