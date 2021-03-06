% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ormPredictionplot.R
\name{plot.orm}
\alias{plot.orm}
\title{Plot the prediction with confidence intervals}
\usage{
\method{plot}{orm}(
  x,
  xval,
  plot_cols = c(),
  plot_rows = c(),
  label_with_colname = TRUE,
  facet_labels = NULL,
  xlab = NULL,
  ylab = NULL,
  np = 100,
  fun = stats::plogis,
  boot.type = "bca",
  conf.int = 0.95,
  ...
)
}
\arguments{
\item{x}{an object created by \code{Predict}}

\item{xval}{The model value plotted on the x axis}

\item{plot_cols}{A vector of strings with  other model components that
should be plotted. These are put on columns.}

\item{plot_rows}{A vector of strings with other model components that
should be plotted. These are put on rows.}

\item{label_with_colname}{Should he variable name also be included on plot
row and column names}

\item{facet_labels}{A  named list of new names for variables on rows and
columns}

\item{xlab}{A custom x-axis value (if specified)}

\item{ylab}{A custom y-axis value (if specified)}

\item{np}{
	the number of equally-spaced points computed for continuous
	predictors that vary, i.e., when the specified value is \code{.}
	or \code{NA}
  }

\item{fun}{an optional transformation of the linear predictor.
	Specify \code{fun='mean'} if the fit is a proportional odds model
	fit and you ran \code{bootcov} with \code{coef.reps=TRUE}.  This
	will let the mean function be re-estimated for each bootstrap rep to
	properly account for all sources of uncertainty in estimating the
	mean response.  \code{fun} can be a general function and can compute
	confidence limits (stored as a list in the \code{limits} attribute) of
the transformed parameters such as means.}

\item{boot.type}{set to \code{'bca'} to compute BCa confidence
	limits or \code{'basic'} to use the basic bootstrap.  The default is
	to compute percentile intervals}

\item{conf.int}{
	confidence level (highest posterior density interval probability for
	Bayesian models).  Default is 0.95.  Specify \code{FALSE} to suppress.}

\item{...}{additional parameters that will be passed to \code{\link[rms]{Predict}}}
}
\value{
a \code{ggplot} plot object
}
\description{
This function plots the model predictions given that all variables that are
not included in the plot are kept constant. Hence it requires at least one
variable to produce a plot.
returns a \code{ggplot} object that can be further customized like any
other ggplot
}
\examples{
#load the libraries
library(rms)
library(ormPlot)

#make the datadist
dd<-datadist(educ_data)
options(datadist='dd')

#create the model
cran_model <- orm(educ_3 ~ Rural + sex + max_SEP_3 + cran_rzs, data = educ_data)

#plot the predictions of the model for varying one variable only
plot(cran_model, cran_rzs)

#customize the plotting varying all variables
plot(cran_model, cran_rzs,
      plot_cols = max_SEP_3,
      plot_rows = c(Rural, sex),

      #setting new x-label (optional)
     xlab = "Cranial volume (residuals to age an birth date)",

     #setting new facet labels (optional)
     facet_labels = list(Rural = c("Urban", "Rural"),
                          sex = c("Boys","Girls"))
     )
}
\seealso{
\code{\link[rms]{Predict}}, \code{\link[rms]{datadist}}, \code{\link[rms]{orm}}
}
