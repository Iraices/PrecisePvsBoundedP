#' Bernoulli-Beta conjugate model
#'
#'
#' This function implements the conjugate model (B | pi) ~ Bernoulli(pi); pi ~ Beta(alpha0,beta0)
#' See wikipedia for details https://en.wikipedia.org/wiki/Conjugate_prior
#'
#' @param suff_stat_data a vector of sufficient statistics: non_consumer_sample_size and consumer_sample_size
#' @param alpha0  prior hyperparameter \emph{alpha0} for the beta distribution
#' @param beta0   prior hyperparameter \emph{beta0} for the beta distribution
#'
#' @return
#' param  A list with the prior and posterior hyperparameters. It constains the following components
#' \describe{
#' \item{prior}{A list with the prior hyperparameters \emph{alpha, beta}}
#' \item{posterior}{A list with the posterior hyperparameters \emph{alpha, beta}}
#' }
#' @export
#'
#' @examples
#' data <- c(non_consumer_sample_size = 20, consumer_sample_size = 10)
#' update_bernoulli_beta(suff_stat_data = data, alpha0 = 1, beta0 = 1)
#'
update_bernoulli_beta <- function(suff_stat_data, alpha0 = 1, beta0 = 1){
  n_non_consumer <- suff_stat_data[['non_consumer_sample_size']]
  n_consumer <- suff_stat_data[['consumer_sample_size']]

  alpha_n <- alpha0 + n_consumer
  beta_n <- beta0 + n_non_consumer

  output <- list(param = list(prior = list(alpha = alpha0, beta = beta0),
                              posterior = list(alpha = alpha_n, beta = beta_n)))

  return(output)
}
