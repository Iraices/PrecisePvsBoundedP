#' Combine uncertainty
#'
#' This function estimates the frequency of exceeding the weekly intake
#'
#' @param gen_data_concentration  generated concentration samples after Bayesian inference (output of function generate_samples_normal_gamma)
#' @param gen_data_consumption    generated consumption samples after Bayesian inference (output of function generate_samples_normal_gamma)
#' @param gen_data_EKE            a generated sample from the fitted distribution to the expert's elicited values
#' @param threshold               safety threshold
#' @param niter_ale               number of generated samples
#'
#' @return
#' frequency_exceeding_wi         the frequency of exceeding the weekly intake
#'
#' @export
#'
#'
combine_uncertainty <- function(gen_data_concentration, gen_data_consumption,
                                gen_data_EKE, threshold, niter_ale){

  gen_data_concentration <- matrix(unlist(gen_data_concentration), ncol = 7, nrow = niter_ale)
  gen_data_consumption <- matrix(unlist(gen_data_consumption), ncol = 7, nrow = niter_ale)

  weekly_intake <- rowSums((1 + (gen_data_EKE/ 100) )* (gen_data_consumption * 0.001) * gen_data_concentration)

  frequency_exceeding_wi <- mean(weekly_intake > threshold)

  return(frequency_exceeding_wi = frequency_exceeding_wi)

}
