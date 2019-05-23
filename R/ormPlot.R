#' ormPlot: Plotting ordinal regression models from \code{\link[rms]{rms}}
#'
#' The package is an extension to the \code{\link[rms]{rms}} package that
#' facilitates plotting the ordinal regression \code{\link[rms]{orm}} model
#' objects. The aim is to get ggplot2 plots that are modifiable
#'
#' The ormPlot package provides two categories of important functions:
#' forestplotting the summary and plotting the predictions
#'
#' @section Summary plotting:
#' The forestplot function facilitates plotting the
#' \code{\link[rms]{summary.rms}} objects resulting from the
#' \code{\link[rms]{orm}} or \code{\link[rms]{lrm}} model
#'
#' See exported methods for more details:
#' \itemize{
#' \item \code{\link{plot.summary.rms}}
#' \item \code{\link{forestplot}}
#' \item \code{\link{join_ggplots}}
#' }
#'
#' @section Prediction plotting:
#' The predicion plotting function facilitates plotting the
#' \code{\link[rms]{orm}} objects using the results got from
#' \code{\link[rms]{Predict}} function. In particular it adds coeficent
#' intervals to orm prediction plots.
#'
#' See exported methods for more details:
#' \itemize{
#' \item \code{\link{plot.orm}}
#' \item \code{\link{orm.predict_with_ci}}
#' }
#'
#' @docType package
#' @name ormPlot
NULL
