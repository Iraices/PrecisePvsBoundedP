#' Graph - Precise probability
#'
#' Plot a cumulative distribution function.
#'
#' @param frequency_exceeding  a vector of frequency of exceeding
#'
#' @return
#' a plot
#'
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#'
#' @export
#'
graph_pp <- function(frequency_exceeding){

  frequency_exceeding_cdf <- c(1:length(frequency_exceeding))/(length(frequency_exceeding))
  data_plot <- data.frame(frequency_exceeding = sort(frequency_exceeding), frequency_exceeding_cdf = frequency_exceeding_cdf)

  data_plot %>%
    ggplot(mapping = aes(y = frequency_exceeding_cdf,  x = frequency_exceeding)) +
    geom_line() +
    xlim(0,0.5) +
    labs(
      title = "Uncertainty",
      x = "Frequency of exceeding TWI",
      y = "cdf") +
    theme_bw() +
    theme(axis.title = element_text(size = 30), axis.text = element_text(size = 15))

}
