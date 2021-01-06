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
  
  ggplot(data = data_plot, aes(y = frequency_exceeding_cdf,  x = frequency_exceeding)) +
    geom_line() +
    geom_hline(yintercept = 0.98, col = 'black', size = 0.4, linetype = 'dashed') +
    xlim(0,0.0025) +
    labs(
      title = "",
      x = "Frequency of exceeding TWI",
      y = "cdf") +
    theme_bw() +
    theme(title = element_text(size = 1), axis.title = element_text(size = 5), axis.text = element_text(size = 5))

}
