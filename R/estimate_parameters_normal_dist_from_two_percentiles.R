#' Fit a normal distribution using two quantiles
#'
#' Estimate the parameters of a normal distribution using two quantiles
#'
#' @param vals A vector of elicited values
#' @param probs A vector of elicited probabilities
#'
#' @return A vector with the parameters mean (\emph{mu_EKE}) and standard deviation (\emph{sigma_EKE}) of the fitted normal distribution.
#'
#'
#' @export
#'
#' @importFrom stats qnorm
#'
#' @examples
#' vals = c(-30, -15, 05, 7.5, 20)
#' probs = c(0.01, 0.25,0.5, 0.75,0.99)
#' estimate_parameters_normal_dist_from_two_percentiles(vals, probs)
#'
estimate_parameters_normal_dist_from_two_percentiles <- function(vals, probs){
  sigma = (vals[1] - vals[2]) / (qnorm(probs[1]) - qnorm(probs[2]))
  mu = vals[1] - qnorm(probs[1]) * sigma
  return(normal_parameters = c(mu_EKE = mu, sigma_EKE = sigma))
}
