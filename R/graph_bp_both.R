#' Graph both - Bounded probability
#'
#' Plot two p-boxes (each p-box is represented by two cdf sequences)
#' All inputs much have the same length
#'
#' @param lower_points_average_consumption     A vector with the lower cdf sequence corresponding to average consumption scenario
#' @param upper_points_average_consumption     A vector with the upper cdf sequence corresponding to average consumption scenario
#' @param lower_points_high_consumption        A vector with the lower cdf sequence corresponding to high consumption scenario
#' @param upper_points_high_consumption        A vector with the upper cdf sequence corresponding to high consumption scenario
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
graph_bp_both <- function(lower_points_average_consumption, upper_points_average_consumption,
                          lower_points_high_consumption, upper_points_high_consumption){

  n_values <- length(lower_points_average_consumption)
  l_points_average_consumption <- rep(0,n_values)
  u_points_average_consumption <- rep(0,n_values)
  l_points_high_consumption <- rep(0,n_values)
  u_points_high_consumption <- rep(0,n_values)

  for(i in 1:n_values){
    l_points_average_consumption[i] <- min(lower_points_average_consumption[i],upper_points_average_consumption[i])
    u_points_average_consumption[i] <- max(lower_points_average_consumption[i],upper_points_average_consumption[i])

    l_points_high_consumption[i] <- min(lower_points_high_consumption[i],upper_points_high_consumption[i])
    u_points_high_consumption[i] <- max(lower_points_high_consumption[i],upper_points_high_consumption[i])
  }

  # data wide format
  data_plot_wide <- data.frame(l_points_average_consumption = sort(l_points_average_consumption),
                               u_points_average_consumption = sort(u_points_average_consumption),
                               l_points_high_consumption = sort(l_points_high_consumption),
                               u_points_high_consumption = sort(u_points_high_consumption),
                               cdf = c(1:n_values / n_values))

  app_data_plot <- data.frame(l_points_average_consumption = c(min(data_plot_wide$l_points_average_consumption),
                                                      max(data_plot_wide$u_points_average_consumption)),
                              u_points_average_consumption = c(min(data_plot_wide$l_points_average_consumption),
                                                      max(data_plot_wide$u_points_average_consumption)),
                              l_points_high_consumption = c(min(data_plot_wide$l_points_high_consumption),
                                                       max(data_plot_wide$u_points_high_consumption)),
                              u_points_high_consumption = c(min(data_plot_wide$l_points_high_consumption),
                                                       max(data_plot_wide$u_points_high_consumption)),
                              cdf = c(0,1))

  data_plot <- rbind(data_plot_wide, app_data_plot)


  # data long format
  data_plot <- gather(data_plot, "bound", "values", .data$l_points_average_consumption, .data$u_points_average_consumption,
                      .data$l_points_high_consumption, .data$u_points_high_consumption, factor_key = TRUE)

  p <- data_plot %>%
    ggplot(aes(x = .data$values, y = .data$cdf, group = .data$bound, color = .data$bound, linetype = .data$bound)) +
    geom_line(size=0.75, aes(color = .data$bound))  +
    xlim(0,1) +
    scale_linetype_manual(values = c('solid', 'solid', 'dashed', 'dashed'),
                          labels = c('Upper_average_consumption', 'Lower_average_child',
                                     'Upper_high_consumption','Lower_high_consumption'),
                          name = 'Bounds') +
    scale_color_manual(values = c('red', 'blue','red', 'blue'),
                       labels = c('Upper_average_consumption', 'Lower_average_consumption',
                                  'Upper_high_consumption','Lower_high_consumption'),
                       name = 'Bounds') +
    labs(
      title = "",
      x = "Frequency of exceeding TWI",
      y = "cdf") +
    theme_bw() +
    theme(title = element_text(size = 15),
          axis.title = element_text(size = 10), axis.text = element_text(size = 10),
          legend.title = element_text(size = 10),
          legend.text = element_text(size = 10),
          legend.position = "none")
          #legend.position = c(0.8,0.2))
  p
}
