% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/index_rarefaction.R,
%   R/index_richness.R
\docType{methods}
\name{richness-index}
\alias{richness-index}
\alias{index_richness}
\alias{index_richness-method}
\alias{index_composition}
\alias{index_composition-method}
\alias{rarefaction}
\alias{rarefaction-method}
\alias{rarefaction,CountMatrix-method}
\alias{index_richness,CountMatrix-method}
\alias{index_composition,CountMatrix-method}
\alias{index_composition,IncidenceMatrix-method}
\title{Richness and Rarefaction}
\usage{
index_richness(object, ...)

index_composition(object, ...)

rarefaction(object, ...)

\S4method{rarefaction}{CountMatrix}(object, sample, method = c("hurlbert"), simplify = TRUE, ...)

\S4method{index_richness}{CountMatrix}(object, method = c("none", "margalef", "menhinick"), ...)

\S4method{index_composition}{CountMatrix}(
  object,
  method = c("chao1", "ace"),
  unbiased = FALSE,
  improved = FALSE,
  k = 10
)

\S4method{index_composition}{IncidenceMatrix}(
  object,
  method = c("chao2", "ice"),
  unbiased = FALSE,
  improved = FALSE,
  k = 10
)
}
\arguments{
\item{object}{A \eqn{m \times p}{m x p} matrix of count data.}

\item{...}{Further arguments to be passed to internal methods.}

\item{sample}{A length-one \code{\link{numeric}} vector giving the sub-sample
size.}

\item{method}{A \code{\link{character}} string or vector of strings
specifying the index to be computed (see details).
Any unambiguous substring can be given.}

\item{simplify}{A \code{\link{logical}} scalar: should the result be
simplified to a matrix? The default value, \code{FALSE}, returns a list.}

\item{unbiased}{A \code{\link{logical}} scalar. Should the bias-corrected
estimator be used? Only used with "\code{chao1}" or "\code{chao2}"
(improved) estimator.}

\item{improved}{A \code{\link{logical}} scalar. Should the improved
estimator be used? Only used with "\code{chao1}" or "\code{chao2}".}

\item{k}{A length-one \code{\link{numeric}} vector giving the threshold
between rare/infrequent and abundant/frequent species. Only used if
\code{method} is "\code{ace}" or "\code{ice}".}
}
\value{
\code{index_richness} and \code{index_composition} return a
 \linkS4class{DiversityIndex} object.

 If \code{simplify} is \code{FALSE}, then \code{rarefaction} returns a list
 (default), else return a matrix.
}
\description{
\code{index_richness} returns sample richness. \code{index_composition}
 returns asymptotic species richness.

 \code{rarefaction} returns Hurlbert's unbiased estimate of Sander's
 rarefaction.
}
\details{
The number of different taxa, provides an instantly comprehensible
 expression of diversity. While the number of taxa within a sample
 is easy to ascertain, as a term, it makes little sense: some taxa
 may not have been seen, or there may not be a fixed number of taxa
 (e.g. in an open system; Peet 1974). As an alternative, \emph{richness}
 (\eqn{S}) can be used for the concept of taxa number (McIntosh 1967).

 It is not always possible to ensure that all sample sizes are equal
 and the number of different taxa increases with sample size and
 sampling effort (Magurran 1988). Then, \emph{rarefaction} (\eqn{E(S)}) is
 the number of taxa expected if all samples were of a standard size (i.e.
 taxa per fixed number of individuals). Rarefaction assumes that imbalances
 between taxa are due to sampling and not to differences in actual
 abundances.

 The following richness measures are available for count data:
 \describe{
  \item{margalef}{Margalef richness index.}
  \item{menhinick}{Menhinick richness index.}
  \item{none}{Returns the number of observed taxa/types.}
 }
}
\section{Asymptotic Species Richness}{

 The following measures are available for count data:
 \describe{
  \item{ace}{Abundance-based Coverage Estimator.}
  \item{chao1}{(improved/unbiased) Chao1 estimator.}
 }

 The following measures are available for replicated incidence data:
 \describe{
  \item{ice}{Incidence-based Coverage Estimator.}
  \item{chao2}{(improved/unbiased) Chao2 estimator.}
 }
}

\examples{
## Richness
## Margalef and Menhinick index
## Data from Magurran 1988, p. 128-129
trap <- CountMatrix(data = c(9, 3, 0, 4, 2, 1, 1, 0, 1, 0, 1, 1,
                             1, 0, 1, 0, 0, 0, 1, 2, 0, 5, 3, 0),
                    nrow = 2, byrow = TRUE, dimnames = list(c("A", "B"), NULL))
index_richness(trap, method = "margalef") # 2.55 1.88
index_richness(trap, method = "menhinick") # 1.95 1.66

## Asymptotic species richness
## Chao1-type estimators
## Data from Chao & Chiu 2016
brazil <- CountMatrix(
  data = rep(x = c(1:21, 23, 25, 27, 28, 30, 32, 34:37, 41,
                   45, 46, 49, 52, 89, 110, 123, 140),
             times = c(113, 50, 39, 29, 15, 11, 13, 5, 6, 6, 3, 4,
                       3, 5, 2, 5, 2, 2, 2, 2, 1, 2, 1, 1, 1, 1, 1,
                       0, 0, 2, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0)),
  nrow = 1, byrow = TRUE
)

index_composition(brazil, method = c("chao1"), unbiased = FALSE) # 461.625
index_composition(brazil, method = c("ace"), k = 10) # 445.822

## Rarefaction
rarefaction(trap, sample = 13) # 6.56
}
\references{
Chao, A. (1984). Nonparametric Estimation of the Number of Classes in a
 Population. \emph{Scandinavian Journal of Statistics}, 11(4), 265-270.

 Chao, A. (1987). Estimating the Population Size for Capture-Recapture Data
 with Unequal Catchability. \emph{Biometrics} 43(4), 783-791.
 \doi{10.2307/2531532}.

 Chao, A. & Chiu, C.-H. (2016). Species Richness: Estimation and Comparison.
 \emph{In} Balakrishnan, N., Colton, T., Everitt, B., Piegorsch, B., Ruggeri,
 F. & Teugels, J. L. (Eds.), \emph{Wiley StatsRef: Statistics Reference Online}.
 Chichester, UK: John Wiley & Sons, Ltd., 1-26.
 \doi{10.1002/9781118445112.stat03432.pub2}

 Chao, A. & Lee, S.-M. (1992). Estimating the Number of Classes via Sample
 Coverage. \emph{Journal of the American Statistical Association}, 87(417),
 210-217. \doi{10.1080/01621459.1992.10475194}.

 Chiu, C.-H., Wang, Y.-T., Walther, B. A. & Chao, A. (2014). An improved
 nonparametric lower bound of species richness via a modified good-turing
 frequency formula. \emph{Biometrics}, 70(3), 671-682.
 \doi{10.1111/biom.12200}.

 Hurlbert, S. H. (1971). The Nonconcept of Species Diversity: A Critique and
 Alternative Parameters. \emph{Ecology}, 52(4), 577-586.
 \doi{10.2307/1934145}.

 Magurran, A. E. (1988). \emph{Ecological Diversity and its Measurement}.
 Princeton, NJ: Princeton University Press. \doi{10.1007/978-94-015-7358-0}.

 Kintigh, K. W. (1989). Sample Size, Significance, and Measures of
 Diversity. In Leonard, R. D. and Jones, G. T., \emph{Quantifying Diversity
 in Archaeology}. New Directions in Archaeology. Cambridge:
 Cambridge University Press, p. 25-36.

 Magurran, A E. & Brian J. McGill (2011). \emph{Biological Diversity:
 Frontiers in Measurement and Assessment}. Oxford: Oxford University Press.

 Margalef, R. (1958). Information Theory in Ecology. \emph{General Systems},
 3, 36-71.

 Menhinick, E. F. (1964). A Comparison of Some Species-Individuals Diversity
 Indices Applied to Samples of Field Insects. \emph{Ecology}, 45(4), 859-861.
 \doi{10.2307/1934933}.

 McIntosh, R. P. (1967). An Index of Diversity and the Relation of Certain
 Concepts to Diversity. \emph{Ecology}, 48(3), 392-404.
 \doi{10.2307/1932674}.

 Sander, H. L. (1968). Marine Benthic Diversity: A Comparative Study.
 \emph{The American Naturalist}, 102(925), 243-282.
}
\seealso{
\link{plot_diversity}, \link{refine}

Other diversity: 
\code{\link{heterogeneity-index}},
\code{\link{similarity}()},
\code{\link{turnover-index}}
}
\author{
N. Frerebeau
}
\concept{diversity}
