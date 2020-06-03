#' Conjugate Model Normal - Normal Gamma
#'
#' The conjugate model is
#' (x| mu,tau) ~ Normal(mu, tau);
#' (mu, tau) ~ Normal-Gamma(mu0,v0,alpha0,beta0)
#' See wikipedia for details https://en.wikipedia.org/wiki/Conjugate_prior
#'
#' @param suff_stat_data a vector of sufficient statistics: sample_size, sample_mean and sample_sd. If sufficient_statistics = \code{FALSE}, then it is vector of observed data
#' @param mu0 prior hyperparameter \emph{mu0} for the normal-gamma distribution
#' @param v0 prior hyperparameter \emph{v0} for the normal-gamma distribution
#' @param alpha0 prior hyperparameter \emph{alpha0} for the normal-gamma distribution
#' @param beta0 prior hyperparameter \emph{beta0} for the normal-gamma distribution
#' @param sufficient_statistics logical; if \code{TRUE}, sufficient statistics, suff_stat_data, are given as input data, otherwise suff_stat_data is given as observed data. Default is \code{TRUE}
#'
#' @return
#' param  A list with the prior and posterior hyperparameters. It constains the following components
#'
#' \describe{
#'   \item{prior}{A list with the prior hyperparameters \emph{mu, v, alpha, beta}}
#'
#'   \item{posterior}{A list with the posterior hyperparameters \emph{mu, v, alpha, beta}}
#' }
#'
#'
#' @export
#'
#' @importFrom stats var
#'
#' @examples
#' dta <- rnorm(100)
#' update_normal_gamma(suff_stat_data = dta, mu0 = 0,
#'                    v0 = 5, alpha0 = 1, beta0 = 1, sufficient_statistics = FALSE)
#'
update_normal_gamma <- function(suff_stat_data, mu0, v0, alpha0, beta0, sufficient_statistics){

  if(sufficient_statistics == TRUE){
    n <- suff_stat_data[['sample_size']]
    m <- suff_stat_data[['sample_mean']]
    S2 <- suff_stat_data[['sample_sd']]^2  # sample variance
  }
  else{
    n <- length(suff_stat_data)
    m <- mean(suff_stat_data)
    S2 <- var(suff_stat_data)
  }

  v_n <-  v0 + n
  alpha_n <- alpha0 + n/2

  mu_n <- (v0 * mu0 + n * m ) / (v0 + n)
  beta_n <- beta0 + 1/2*S2*(n - 1) + (n*v0/(v0 + n) * (m - mu0)^2)

  output <- list(param = list(prior = list(mu = mu0, v = v0, alpha = alpha0, beta = beta0),
                              posterior = list(mu = mu_n, v = v_n , alpha = alpha_n, beta = beta_n)))

  return(output)
}
