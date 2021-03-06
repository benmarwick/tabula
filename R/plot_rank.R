# PLOT RANK
#' @include AllClasses.R AllGenerics.R
NULL

#' @export
#' @rdname plot_line
#' @aliases plot_rank,CountMatrix-method
setMethod(
  f = "plot_rank",
  signature = signature(object = "CountMatrix"),
  definition = function(object, log = NULL, facet = FALSE) {
    freq <- methods::as(object, "AbundanceMatrix")
    plot_rank(freq, log = log, facet = facet)
  }
)

#' @export
#' @rdname plot_line
#' @aliases plot_rank,AbundanceMatrix-method
setMethod(
  f = "plot_rank",
  signature = signature(object = "AbundanceMatrix"),
  definition = function(object, log = NULL, facet = FALSE) {
    ## Prepare data
    data <- prepare_rank(object)

    ## ggplot
    log_x <- log_y <- NULL
    if (!is.null(log)) {
      if (log == "x" || log == "xy" || log == "yx")
        log_x <- ggplot2::scale_x_log10()
      if (log == "y" || log == "xy" || log == "yx")
        log_y <- ggplot2::scale_y_log10()
    }
    if (facet) {
      facet <- ggplot2::facet_wrap(
        facets = ggplot2::vars(.data$row),
        ncol = nrow(object)
      )
      aes_plot <- ggplot2::aes(x = .data$x, y = .data$y)
    } else {
      facet <- NULL
      aes_plot <- ggplot2::aes(x = .data$x, y = .data$y, colour = .data$row)
    }
    ggplot2::ggplot(data = data, mapping = aes_plot) +
      ggplot2::geom_point() +
      ggplot2::geom_line() +
      ggplot2::labs(
        x = "Rank",
        y = "Frequency",
        colour = "Assemblage"
      ) +
      log_x + log_y + facet
  }
)

## Prepare data for rank plot
## Must return a data.frame
prepare_rank <- function(object) {
  ## Get rank
  rk <- apply(
    X = object,
    MARGIN = 1,
    FUN = function(x) rank(-x)
  )

  ## Build a long table for ggplot2 (preserve original ordering)
  data <- arkhe::as_long(object, factor = TRUE)

  data$x <- as.vector(t(rk))
  data$y <- data$value

  ## Remove zeros in case of log scale
  data <- data[data$value > 0, ]

  return(data)
}
