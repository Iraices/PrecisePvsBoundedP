#' Graph both - Precise probability
#'
#'Plot two cumulative distribution functions: all children and a high consumer child.
#' prob_exceed_all and prob_exceed_high_consumer must have the same length
#'
#' @param prob_exceed_all  a vector of probabilities of exceedance corresponding to all children
#' @param prob_exceed_high_consumer a vector of probabilities of exceedance corresponding to a high consumer child
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
graph_pp_both <- function(prob_exceed_all, prob_exceed_high_consumer){

  # data wide format
  data_plot <- data.frame(prob_exceed_all = sort(prob_exceed_all),
                          prob_exceed_high_consumer = sort(prob_exceed_high_consumer),
                          prob_cdf = c(1:length(prob_exceed_all)/length(prob_exceed_all)))

  # data long format
  data_plot <- gather(data_plot, .data$group, .data$values, prob_exceed_all, prob_exceed_high_consumer, factor_key = TRUE)

  p <- data_plot %>%
    ggplot(aes(x = .data$values, y = .data$prob_cdf, group = .data$group, linetype = .data$group)) +
    geom_line() +
    scale_linetype_manual(values = c('solid', 'dashed'), labels = c('All_children', 'High_consumer')) +
    guides(linetype = guide_legend("Groups")) +
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
