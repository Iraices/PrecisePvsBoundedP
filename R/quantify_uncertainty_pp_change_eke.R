#' Fit a Normal distribution from Expert Kwonledge elicitation
#'
#' Takes elicited probabilities as inputs, and fits a normal distribution using least squares on
#' the cumulative distribution function. If separate judgements from multiple experts are specified,
#' the function will fit one set of distributions per expert.
#'
#' @param vals A vector of elicited values for one expert, or a matrix of elicited values for multiple
#'             experts (one column per expert). Note that the an elicited judgement about X should be of the form P(X<= vals[i,j]) = probs[i,j]
#'
#' @param probs A vector of elicited probabilies for one expert, or a matrix of elicited values for multiple
#'          experts (one column per expert). A single vector can be used if the probabilities are the same
#'          for each expert. For each expert, the smallest elicited probability must be less than 0.4,
#'          and the largest elicited probability must be greater than 0.6.
#'
#' @return A vector with the parameters mean (\emph{mu_EKE}) and standard deviation (\emph{sigma_EKE}) of the fitted normal distribution.
#'
#'
#' @export
#'
#' @importFrom SHELF fitdist
#'
#' @examples
#' vals = c(-30, -15, 05, 7.5, 20)
#' probs = c(0.01, 0.25,0.5, 0.75,0.99)
#' quantify_uncertainty_pp_change_eke(vals, probs)
#'
quantify_uncertainty_pp_change_eke <- function(vals, probs){
  l <- length(vals)
  change_cocoa_dist <- SHELF::fitdist(vals = vals[2:(l-1)], probs = probs[2:(l-1)], lower = min(vals), upper = max(vals))

  return(normal_parameters = c(mu_EKE = change_cocoa_dist$Normal$mean, sigma_EKE = change_cocoa_dist$Normal$sd))
}
