#' Generate samples from a log_normal distribution using the
#' parameters from the posterior distribution
#'
#' This function generates samples from a log-normal distribution
#' given the posterior hyperparameters of the normal-gamma distribution
#'
#' @param niter_ale  number of generated samples
#' @param post the output of update_normal_gamma function. Post is a list with the prior and posterior hyperparameters of the Normal-Gamma distribution.
#'             Prior and posterior are also list with hyperparameters \emph{mu, v, alpha} and \emph{beta}.
#' @param percentile_ale a value that indicates if the assessment is done on all population by \code{NULL} (default) or on a high consumer child by 95.
#'
#'
#' @return
#' gen_sample      A vector with the generated samples
#'
#' @export
#'
#' @importFrom stats qlnorm rlnorm rgamma rnorm
#'
#' @examples
#' dta <- rnorm(100)
#' post <- update_normal_gamma(suff_stat_data = dta, mu0 = 0, v0 = 5,
#'     alpha0 = 1, beta0 = 1, sufficient_statistics = FALSE)
#'generate_samples_normal_gamma(niter_ale = 1000, post, percentile_ale = NULL)
#'
generate_samples_normal_gamma <- function(niter_ale, post, percentile_ale = NULL){

  precision <- rgamma(1, shape = post$param$posterior$alpha, rate = post$param$posterior$beta)  # precision
  sigma_n <- (1/sqrt(precision))  # standard deviation
  mu <- rnorm(1,post$param$posterior$mu, sigma_n / sqrt(post$param$posterior$v))
  if(is.null(percentile_ale)){
    gen_sample <- rlnorm(niter_ale, meanlog = mu, sdlog = sigma_n)
  }
  else{
    gen_sample <- rep(qlnorm(percentile_ale/100, meanlog = mu, sdlog = sigma_n), niter_ale)
  }

  output <- list(gen_sample = gen_sample)

  return(output)
}
