#' Graph both - Bounded probability
#'
#' Plot two p-boxes (each p-box is represented by two cdf sequences)
#' All inputs much have the same length
#'
#' @param lower_points_random_child                   A vector with the lower cdf sequence corresponding to a random child
#' @param upper_points_random_child                  A vector with the upper cdf sequence corresponding to a random child
#' @param lower_points_high_consumer         A vector with the lower cdf sequence corresponding to a high consumer child
#' @param upper_points_high_consumer         A vector with the upper cdf sequence corresponding to a high consumer child
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
graph_bp_both <- function(lower_points_random_child, upper_points_random_child,
                          lower_points_high_consumer, upper_points_high_consumer){

  n_values <- length(lower_points_random_child)
  l_points_random_child <- rep(0,n_values)
  u_points_random_child <- rep(0,n_values)
  l_points_high_consumer <- rep(0,n_values)
  u_points_high_consumer <- rep(0,n_values)

  for(i in 1:n_values){
    l_points_random_child[i] <- min(lower_points_random_child[i],upper_points_random_child[i])
    u_points_random_child[i] <- max(lower_points_random_child[i],upper_points_random_child[i])

    l_points_high_consumer[i] <- min(lower_points_high_consumer[i],upper_points_high_consumer[i])
    u_points_high_consumer[i] <- max(lower_points_high_consumer[i],upper_points_high_consumer[i])
  }

  # data wide format
  data_plot_wide <- data.frame(l_points_random_child = sort(l_points_random_child),
                               u_points_random_child = sort(u_points_random_child),
                               l_points_high_consumer = sort(l_points_high_consumer),
                               u_points_high_consumer = sort(u_points_high_consumer),
                               cdf = c(1:n_values / n_values))

  app_data_plot <- data.frame(l_points_random_child=c(min(data_plot_wide$l_points_random_child),
                                                      max(data_plot_wide$u_points_random_child)),
                              u_points_random_child=c(min(data_plot_wide$l_points_random_child),
                                                      max(data_plot_wide$u_points_random_child)),
                              l_points_high_consumer=c(min(data_plot_wide$l_points_high_consumer),
                                                       max(data_plot_wide$u_points_high_consumer)),
                              u_points_high_consumer=c(min(data_plot_wide$l_points_high_consumer),
                                                       max(data_plot_wide$u_points_high_consumer)),
                              cdf=c(0,1))

  data_plot <- rbind(data_plot_wide, app_data_plot)


  # data long format
  data_plot <- gather(data_plot, "bound", "values", .data$l_points_all, .data$u_points_all,
                      l_points_high_consumer, u_points_high_consumer, factor_key = TRUE)

  p <- data_plot %>%
    ggplot(aes(x = .data$values, y = .data$cdf, group = .data$bound, color = .data$bound, linetype = .data$bound)) +
    geom_line() +
    scale_linetype_manual(values = c('solid', 'solid', 'dashed', 'dashed'),
                          labels = c('Upper_random_child', 'Lower_random_child',
                                     'Upper_high_consumer','Lower_high_consumer')) +
    scale_color_manual(values = c('red', 'blue','red', 'blue'),
                       labels = c('Upper_random_child', 'Lower_random_child',
                                  'Upper_high_consumer','Lower_high_consumer')) +
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
