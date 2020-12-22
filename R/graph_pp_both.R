#' Graph both - Precise probability
#'
#'Plot two cumulative distribution functions: average consumption and high consumption
#' frequency_exceeding_average_consumption and frequency_exceeding_high_consumption must have the same length
#'
#' @param frequency_exceeding_average_consumption     A vector of frequency of exceeding corresponding to average consumption
#' @param frequency_exceeding_high_consumption        A vector of frequency of exceeding corresponding to high consumption
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
graph_pp_both <- function(frequency_exceeding_average_consumption,
                          frequency_exceeding_high_consumption){

  # data wide format
  data_plot_wide <- data.frame(frequency_exceeding_average_consumption = sort(frequency_exceeding_average_consumption),
                               frequency_exceeding_high_consumption = sort(frequency_exceeding_high_consumption),
                               frequency_exceeding_cdf = c(1:length(frequency_exceeding_average_consumption)/length(frequency_exceeding_average_consumption)))

  # data long format
  data_plot_long <- gather(data_plot_wide, "group", "values", frequency_exceeding_average_consumption,
                      frequency_exceeding_high_consumption, factor_key = TRUE)

  p <- data_plot_long %>%
    ggplot(aes(x = .data$values, y = .data$frequency_exceeding_cdf, group = .data$group, linetype = .data$group)) +
    geom_line(size = 0.75) +
    scale_linetype_manual(values = c('solid', 'dashed'), labels = c('Average_consumption', 'High_consumption')) +
    guides(linetype = guide_legend("Scenarios")) +
    xlim(0,1) +
    labs(
      title = "",
      x = "Frequency of exceeding TWI",
      y = "cdf") +
    theme_bw() +
    theme(title = element_text(size = 15),
          axis.title = element_text(size = 10), axis.text = element_text(size = 10),
          legend.title = element_text(size = 10),
          legend.text = element_text(size = 10),
          legend.position = c(0.7,0.2))
  p
}
