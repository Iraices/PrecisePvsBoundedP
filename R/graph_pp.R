#' Graph - Precise probability
#'
#' Plot a cumulative distribution function.
#'
#' @param prob_exceed  a vector of probabilities of exceedance
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
graph_pp <- function(prob_exceed){

  prob_cdf <- c(1:length(prob_exceed))/(length(prob_exceed))
  data_plot <- data.frame(prob_exceed = sort(prob_exceed), prob_cdf = prob_cdf)

  data_plot %>%
    ggplot(mapping = aes(y = prob_cdf,  x = prob_exceed)) +
    geom_line() +
    labs(
      title = "Uncertainty",
      x = "Frequency of exceeding TWI",
      y = "cdf") +
    theme(axis.title = element_text(size = 30), axis.text = element_text(size = 15))

}
