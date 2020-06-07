#' Graph both - Precise probability
#'
#'Plot two cumulative distribution functions: a random child  and a high consumer child.
#' frequency_exceeding_random_child and frequency_exceeding_high_consumer must have the same length
#'
#' @param frequency_exceeding_random_child  a vector of frequency of exceedance corresponding to a random child
#' @param frequency_exceeding_high_consumer a vector of probabilities of exceedance corresponding to a high consumer child
#'
#' @return
#' a plot
#'
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#' @importFrom rlang .data
#'
#' @export
#'
graph_pp_both <- function(frequency_exceeding_random_child, frequency_exceeding_high_consumer){

  # data wide format
  data_plot_wide <- data.frame(frequency_exceeding_random_child = sort(frequency_exceeding_random_child),
                               frequency_exceeding_high_consumer = sort(frequency_exceeding_high_consumer),
                               frequency_exceeding_cdf = c(1:length(frequency_exceeding_random_child)/length(frequency_exceeding_random_child)))

  # data long format
  data_plot_long <- gather(data_plot_wide, "group", "values", .data$frequency_exceeding_random_child,
                      .data$frequency_exceeding_high_consumer, factor_key = TRUE)

  p <- data_plot_long %>%
    ggplot(aes(x = .data$values, y = .data$frequency_exceeding_cdf, group = .data$group, linetype = .data$group)) +
    geom_line() +
    scale_linetype_manual(values = c('solid', 'dashed'), labels = c('Random_child', 'High_consumer_child')) +
    guides(linetype = guide_legend("Cases")) +
    labs(
      title = "Uncertainty",
      x = "Frequency of exceeding TWI",
      y = "cdf") +
    theme(title = element_text(size = 15),
          axis.title = element_text(size = 15), axis.text = element_text(size = 15),
          legend.title = element_text(size = 15),
          legend.text = element_text(size = 15))
  p
}
