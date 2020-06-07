#' Objective function for Bounded probability
#'
#' This is the objective function (a function to be optimized)
#' The objective function is the unc_analysis_assessment_bp function where
#' concentration_mu0, consumption_mu0 and consumption_change_vals_EKE
#' are the parameters and the rest of the inputs arguments are fixed.
#'
#' @param parameters                          parameters of the objective function (concentration_mu0, consumption_mu0, consumption_change_vals_EKE)
#' @param niter_ale                           number of generated samples
#' @param niter_epi                           number of generated parameters from the posterior distrbutions
#'                                            (it indicates the number of repetitions the assessment will be done)
#' @param threshold                           safety threshold
#' @param percentile_ale                      a value that indicates if the assessment is done on a random child  by \code{NULL} or on a high consumer child by 95. Default is \code{NULL}
#' @param suff_stat_concentration             a vector of sufficient statistics: sample_size, sample_mean and sample_sd
#'                                            corresponding to concentration. If sufficient_statistics_concentration = \code{FALSE},
#'                                            then it is vector of observed data
#' @param suff_stat_consumption               a vector of sufficient statistics: sample_size, sample_mean and sample_sd
#'                                            corresponding to consumption. If sufficient_statistics_consumption = \code{FALSE},
#'                                            then it is vector of observed data
#' @param consumption_change_vals_EKE         a vector of elicited values from experts
#' @param consumption_change_probs_EKE        a vector of elicited probabilities from experts
#' @param consumers_info_sample_size          a vector with the sample size of non_consumer_sample_size and consumer_sample_size
#' @param concentration_v0                    prior hyperparameter \emph{v0} for the normal-gamma distribution corresponding to concentration
#' @param concentration_alpha0                prior hyperparameter \emph{alpha0} for the normal-gamma distribution  corresponding to concentration
#' @param concentration_beta0                 prior hyperparameter \emph{beta0} for the normal-gamma distribution corresponding to concentration
#' @param sufficient_statistics_concentration logical; if \code{TRUE}, sufficient statistics (sample_size, sample_mean, sample_variance)
#'                                            corresponding to concentration are given as input data, otherwise
#'                                            sufficient_statistics_concentration is given as observed data. Default is \code{TRUE}
#' @param consumption_v0                      prior hyperparameter \emph{v0} for the normal-gamma distribution corresponding to consumption
#' @param consumption_alpha0                  prior hyperparameter \emph{alpha0} for the normal-gamma distribution corresponding to consumption
#' @param consumption_beta0                   prior hyperparameter \emph{beta0} for the normal-gamma distribution corresponding to consumption
#' @param sufficient_statistics_consumption   logical; if \code{TRUE}, sufficient statistics (sample_size, sample_mean, sample_variance)
#'                                            corresponding to consumption are given as input data, otherwise
#'                                            sufficient_statistics_consumption is given as observed data. Default is \code{TRUE}
#' @param consumption_event_alpha0            prior hyperparameter \emph{alpha0} for the beta distribution corresponding to consumption event
#' @param consumption_event_beta0             prior hyperparameter \emph{beta0} for the beta distribution corresponding to consumption event

#'
#' @return
#' expected_frequency_exceeding               the expected value of the frequency of exceeding the threshold
#'
#' @export
#'
obj_func_bp <- function(parameters, niter_ale, niter_epi, threshold, percentile_ale,
                        suff_stat_concentration, suff_stat_consumption,
                        consumption_change_vals_EKE, consumption_change_probs_EKE ,
                        consumers_info_sample_size, concentration_v0,
                        concentration_alpha0, concentration_beta0,
                        sufficient_statistics_concentration,
                        consumption_v0, consumption_alpha0, consumption_beta0,
                        sufficient_statistics_consumption,
                        consumption_event_alpha0, consumption_event_beta0){

  concentration_mu0 <- parameters[1]
  consumption_mu0 <- parameters[2]
  consumption_change_vals_EKE <- c(parameters[3], consumption_change_vals_EKE)


  out <- unc_analysis_assessment_bp(niter_ale = niter_ale, niter_epi= niter_epi,
                                    threshold = threshold, percentile_ale = percentile_ale,
                                    suff_stat_concentration = suff_stat_concentration,
                                    suff_stat_consumption = suff_stat_consumption,
                                    consumption_change_vals_EKE = consumption_change_vals_EKE,
                                    consumption_change_probs_EKE = consumption_change_probs_EKE,
                                    consumers_info_sample_size = consumers_info_sample_size,
                                    concentration_mu0 = concentration_mu0, concentration_v0 = concentration_v0,
                                    concentration_alpha0 = concentration_alpha0, concentration_beta0 = concentration_beta0,
                                    sufficient_statistics_concentration = sufficient_statistics_concentration,
                                    consumption_mu0 = consumption_mu0, consumption_v0 =  consumption_v0,
                                    consumption_alpha0 = consumption_alpha0, consumption_beta0 = consumption_beta0,
                                    sufficient_statistics_consumption = sufficient_statistics_consumption,
                                    consumption_event_alpha0 = consumption_event_alpha0, consumption_event_beta0 = consumption_event_beta0)

  output <- out$expected_frequency_exceeding

  return(output)
}
