#' Graph - Bounded probability
#'
#' Plot a p-box (a p-box is represented by two cdf sequences)
#'
#' @param lower_points           A vector with the lower cdf sequence
#' @param upper_points           A vector with the upper cdf sequence
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
graph_bp <- function(lower_points, upper_points){

  n_values <- length(lower_points)
  l_points <- rep(0,n_values)
  u_points <- rep(0,n_values)

  for(i in 1:n_values){
    l_points[i] <- min(lower_points[i],upper_points[i])
    u_points[i] <- max(lower_points[i],upper_points[i])
  }

  # data wide format
  data_plot_wide <- data.frame(l_points = sort(l_points),
                               u_points = sort(u_points),
                               cdf = c(1:n_values / n_values))

  app_data_plot <- data.frame(l_points= c(min(data_plot_wide$l_points),max(data_plot_wide$u_points)),
                              u_points = c(min(data_plot_wide$l_points),max(data_plot_wide$u_points)),
                              cdf=c(0,1))

  data_plot <- rbind(data_plot_wide, app_data_plot)


  # data long format
  data_plot <- gather(data_plot,"bound", "values", .data$l_points, .data$u_points, factor_key = TRUE)


  p <- data_plot %>%
    ggplot(aes(x = .data$values, y = .data$cdf, group = .data$bound, col = .data$bound)) +
    geom_line() +
    geom_hline(yintercept = 0.98, col = 'black', size = 0.4, linetype = 'dashed') +
    scale_color_manual(labels = c('Upper', 'Lower'), values = c('red', 'blue')) +
    guides(color = guide_legend("Bounds")) +
    xlim(0,0.05) +
    labs(
      title = "",
      x = "Frequency of exceeding TWI",
      y = "cdf") +
    theme_bw() +
    theme(title = element_text(size = 1),
          axis.title = element_text(size = 5), axis.text = element_text(size = 5),
          legend.title = element_text(size = 4),
          legend.text = element_text(size = 4),
          legend.position = c(0.75,0.3))
  p

}
