#' Graph both - Bounded probability
#'
#' Plot two p-boxes (each p-box is represented by two cdf sequences)
#' All inputs much have the same length
#'
#' @param lower_points_random_child               A vector with the lower cdf sequence corresponding to a random child
#' @param upper_points_random_child               A vector with the upper cdf sequence corresponding to a random child
#' @param lower_points_high_consumer_child        A vector with the lower cdf sequence corresponding to a high consumer child
#' @param upper_points_high_consumer_child        A vector with the upper cdf sequence corresponding to a high consumer child
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
                          lower_points_high_consumer_child, upper_points_high_consumer_child){

  n_values <- length(lower_points_random_child)
  l_points_random_child <- rep(0,n_values)
  u_points_random_child <- rep(0,n_values)
  l_points_high_consumer_child <- rep(0,n_values)
  u_points_high_consumer_child <- rep(0,n_values)

  for(i in 1:n_values){
    l_points_random_child[i] <- min(lower_points_random_child[i],upper_points_random_child[i])
    u_points_random_child[i] <- max(lower_points_random_child[i],upper_points_random_child[i])

    l_points_high_consumer_child[i] <- min(lower_points_high_consumer_child[i],upper_points_high_consumer_child[i])
    u_points_high_consumer_child[i] <- max(lower_points_high_consumer_child[i],upper_points_high_consumer_child[i])
  }

  # data wide format
  data_plot_wide <- data.frame(l_points_random_child = sort(l_points_random_child),
                               u_points_random_child = sort(u_points_random_child),
                               l_points_high_consumer_child = sort(l_points_high_consumer_child),
                               u_points_high_consumer_child = sort(u_points_high_consumer_child),
                               cdf = c(1:n_values / n_values))

  app_data_plot <- data.frame(l_points_random_child = c(min(data_plot_wide$l_points_random_child),
                                                      max(data_plot_wide$u_points_random_child)),
                              u_points_random_child = c(min(data_plot_wide$l_points_random_child),
                                                      max(data_plot_wide$u_points_random_child)),
                              l_points_high_consumer_child = c(min(data_plot_wide$l_points_high_consumer_child),
                                                       max(data_plot_wide$u_points_high_consumer_child)),
                              u_points_high_consumer_child = c(min(data_plot_wide$l_points_high_consumer_child),
                                                       max(data_plot_wide$u_points_high_consumer_child)),
                              cdf = c(0,1))

  data_plot <- rbind(data_plot_wide, app_data_plot)


  # data long format
  data_plot <- gather(data_plot, "bound", "values", .data$l_points_random_child, .data$u_points_random_child,
                      .data$l_points_high_consumer_child, .data$u_points_high_consumer_child, factor_key = TRUE)

  p <- data_plot %>%
    ggplot(aes(x = .data$values, y = .data$cdf, group = .data$bound, color = .data$bound, linetype = .data$bound)) +
    geom_line() +
    xlim(0,1) +
    scale_linetype_manual(values = c('solid', 'solid', 'dashed', 'dashed'),
                          labels = c('Upper_random_child', 'Lower_random_child',
                                     'Upper_high_consumer_child','Lower_high_consumer_child'),
                          name = 'Bounds') +
    scale_color_manual(values = c('red', 'blue','red', 'blue'),
                       labels = c('Upper_random_child', 'Lower_random_child',
                                  'Upper_high_consumer_child','Lower_high_consumer_child'),
                       name = 'Bounds') +
    labs(
      title = "Uncertainty",
      x = "Frequency of exceeding TWI",
      y = "cdf") +
    theme(title = element_text(size = 15),
          axis.title = element_text(size = 15), axis.text = element_text(size = 15),
          legend.title = element_text(size = 15),
          legend.text = element_text(size = 15),
          legend.position = c(0.7,0.18))
  p
}
