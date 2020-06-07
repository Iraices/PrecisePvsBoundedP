#' Assessment model -- Bounded Probability
#'
#' This function does the aluminium exposure assessment. It estimates the expected value and
#' the highest posterior density of the frequency of exceeding the threshold.
#' Note: the difference respect to the precise probability is that a normal distribution is fitted to the elicited
#' values from experts using two percentiles and by specifying bounds on a percentile.
#'
#' @param niter_ale                     number of generated samples
#' @param niter_epi                     number of generated parameters from the posterior distrbutions
#'                                      (it indicates the number of repetitions the assessment will be done)
#' @param threshold                     safety threshold
#' @param percentile_ale                a value that indicates if the assessment is done on a random child by \code{NULL} or on a high consumer child by 95. Default is \code{NULL}
#' @param suff_stat_concentration       a vector of sufficient statistics: sample_size, sample_mean and sample_sd
#'                                      corresponding to concentration. If sufficient_statistics_concentration = \code{FALSE},
#'                                      then it is vector of observed data
#' @param suff_stat_consumption         a vector of sufficient statistics: sample_size, sample_mean and sample_sd
#'                                      then it is vector of observed data
#' @param consumption_change_vals_EKE   a vector of elicited values from experts
#' @param consumption_change_probs_EKE  a vector of elicited probabilities from experts
#' @param consumers_info_sample_size    a vector with the sample size of non_consumer_sample_size and consumer_sample_size
#' @param concentration_mu0             prior hyperparameter \emph{mu0} for the normal-gamma distribution corresponding to concentration
#' @param concentration_v0              prior hyperparameter \emph{v0} for the normal-gamma distribution corresponding to concentration
#' @param concentration_alpha0          prior hyperparameter \emph{alpha0} for the normal-gamma distribution  corresponding to concentration
#' @param concentration_beta0           prior hyperparameter \emph{beta0} for the normal-gamma distribution corresponding to concentration
#' @param sufficient_statistics_concentration  logical; if \code{TRUE}, sufficient statistics (sample_size, sample_mean, sample_variance)
#'                                      corresponding to concentration are given as input data, otherwise
#'                                      sufficient_statistics_concentration is given as observed data. Default is \code{TRUE}
#' @param consumption_mu0               prior hyperparameter \emph{mu0} for the normal-gamma distribution corresponding to consumption
#' @param consumption_v0                prior hyperparameter \emph{v0} for the normal-gamma distribution corresponding to consumption
#' @param consumption_alpha0            prior hyperparameter \emph{alpha0} for the normal-gamma distribution corresponding to consumption
#' @param consumption_beta0             prior hyperparameter \emph{beta0} for the normal-gamma distribution corresponding to consumption
#' @param sufficient_statistics_consumption    logical; if \code{TRUE}, sufficient statistics (sample_size, sample_mean, sample_variance)
#'                                             corresponding to consumption are given as input data, otherwise
#'                                             sufficient_statistics_consumption is given as observed data. Default is \code{TRUE}
#' @param consumption_event_alpha0      prior hyperparameter \emph{alpha0} for the beta distribution corresponding to consumption event
#' @param consumption_event_beta0       prior hyperparameter \emph{beta0} for the beta distribution corresponding to consumption event
#'
#'
#' @return a list with the following components
#' \describe{
#' \item{prob_consumption_event}{The estimated probability of consumption events}
#' \item{parameters_concentration}{A list with the values of the prior and posterior parameters of concentration}
#' \item{parameters_consumption}{A list with the prior and posterior parameters of consumption}
#' \item{frequency_exceeding}{A vector with the estimated frequency of exceeding the threshold (the lenght is niter_epi)}
#' \item{expected_frequency_exceeding}{The expected value of the frequency of exceeding the threshold}
#' \item{hdi_frequency_exceeding}{The highest posterior density interval of the frequency of exceeding the threshold}
#' }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' lower_bound_random_child = bound_prob_exceed_bp(obj_func_bp = obj_func_bp, maximize = FALSE,
#'                                         lower_parameters  = c(1, -5, -20),
#'                                         upper_parameters  = c(6, 1, -10),
#'                                         niter_ale = 2000, niter_epi = 2000, threshold = 1, percentile_ale = NULL,
#'                                         suff_stat_concentration = data_assessment$log_concentration_ss_data,
#'                                         suff_stat_consumption = data_assessment$log_consumption_ss_data,
#'                                         consumption_change_vals_EKE = c(-15, 7.5),
#'                                         consumption_change_probs_EKE = c(0.25, 0.75),
#'                                         consumers_info_sample_size = data_assessment$consumers_info_sample_size,
#'                                         concentration_mu0 = 2.75,
#'                                         concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
#'                                         sufficient_statistics_concentration = TRUE,
#'                                         consumption_mu0 = -2.5,
#'                                         consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
#'                                         sufficient_statistics_consumption = TRUE,
#'                                         consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
#'
#' upper_bound_random_child = bound_prob_exceed_bp(obj_func_bp = obj_func_bp, maximize = TRUE,
#'                                         lower_parameters  = c(1, -5, -20),
#'                                         upper_parameters  = c(6, 1, -10),
#'                                         niter_ale = 2000, niter_epi = 2000, threshold = 1, percentile_ale = NULL,
#'                                         suff_stat_concentration = data_assessment$log_concentration_ss_data,
#'                                         suff_stat_consumption = data_assessment$log_consumption_ss_data,
#'                                         consumption_change_vals_EKE = c(-15, 7.5),
#'                                         consumption_change_probs_EKE = c(0.25, 0.75),
#'                                         consumers_info_sample_size = data_assessment$consumers_info_sample_size,
#'                                         concentration_mu0 = 2.75,
#'                                         concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
#'                                         sufficient_statistics_concentration = TRUE,
#'                                         consumption_mu0 = -2.5,
#'                                         consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
#'                                         sufficient_statistics_consumption = TRUE,
#'                                         consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
#'
#' lower_bound_high_consumer = bound_prob_exceed_bp(obj_func_bp = obj_func_bp, maximize = FALSE,
#'                                                  lower_parameters  = c(1, -5, -20),
#'                                                  upper_parameters  = c(6, 1, -10),
#'                                                  niter_ale = 2000, niter_epi = 2000, threshold = 1, percentile_ale = 95,
#'                                                  suff_stat_concentration = data_assessment$log_concentration_ss_data,
#'                                                  suff_stat_consumption = data_assessment$log_consumption_ss_data,
#'                                                  consumption_change_vals_EKE = c(-15, 7.5),
#'                                                  consumption_change_probs_EKE = c(0.25, 0.75),
#'                                                  consumers_info_sample_size = data_assessment$consumers_info_sample_size,
#'                                                  concentration_mu0 = 2.75,
#'                                                  concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
#'                                                  sufficient_statistics_concentration = TRUE,
#'                                                  consumption_mu0 = -2.5,
#'                                                  consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
#'                                                  sufficient_statistics_consumption = TRUE,
#'                                                  consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
#'
#'
#' upper_bound_high_consumer = bound_prob_exceed_bp(obj_func_bp = obj_func_bp, maximize = TRUE,
#'                                                  lower_parameters  = c(1, -5, -20),
#'                                                  upper_parameters  = c(6, 1, -10),
#'                                                  niter_ale = 2000, niter_epi = 2000, threshold = 1, percentile_ale = 95,
#'                                                  suff_stat_concentration = data_assessment$log_concentration_ss_data,
#'                                                  suff_stat_consumption = data_assessment$log_consumption_ss_data,
#'                                                  consumption_change_vals_EKE = c(-15, 7.5),
#'                                                  consumption_change_probs_EKE = c(0.25, 0.75),
#'                                                  consumers_info_sample_size = data_assessment$consumers_info_sample_size,
#'                                                  concentration_mu0 = 2.75,
#'                                                  concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
#'                                                  sufficient_statistics_concentration = TRUE,
#'                                                  consumption_mu0 = -2.5,
#'                                                  consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
#'                                                  sufficient_statistics_consumption = TRUE,
#'                                                  consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
#'
#'}
unc_analysis_assessment_bp <- function(niter_ale, niter_epi,
                                       threshold, percentile_ale,
                                       suff_stat_concentration, suff_stat_consumption,
                                       consumption_change_vals_EKE,
                                       consumption_change_probs_EKE,
                                       consumers_info_sample_size,
                                       concentration_mu0, concentration_v0, concentration_alpha0,
                                       concentration_beta0, sufficient_statistics_concentration,
                                       consumption_mu0, consumption_v0, consumption_alpha0,
                                       consumption_beta0, sufficient_statistics_consumption,
                                       consumption_event_alpha0, consumption_event_beta0){

  nr_products <-  length(suff_stat_concentration)
  prob_consumption_event <- parameters_consumption <- parameters_concentration <- vector('list', nr_products)

  # Probability of a child i consumes chocolate product k
  param_consumption_event <-  lapply(consumers_info_sample_size, update_bernoulli_beta, alpha0 = consumption_event_alpha0, beta0 = consumption_event_beta0)

  for(k in 1:nr_products){
    prob_consumption_event[[k]] <-  rbeta(1,shape1 = param_consumption_event[[k]]$param$posterior$alpha,
                                          shape2 = param_consumption_event[[k]]$param$posterior$beta)
  }

  frequency_exceeding <- rep(0, niter_epi)

  post_concentration <-  lapply(suff_stat_concentration, update_normal_gamma, mu0 = concentration_mu0,
                                v0 = concentration_v0, alpha0 = concentration_alpha0,
                                beta0 = concentration_beta0, sufficient_statistics = sufficient_statistics_concentration)

  post_consumption <-  lapply(suff_stat_consumption, update_normal_gamma, mu0 = consumption_mu0,
                              v0 = consumption_v0, alpha0 = consumption_alpha0,
                              beta0 = consumption_beta0, sufficient_statistics = sufficient_statistics_consumption)
  for(j in 1:nr_products){
    parameters_concentration[[j]] <-  post_concentration[[j]]$param

    parameters_consumption[[j]] <-  post_consumption[[j]]$param
  }

  fit_normal_dist_EKE <- estimate_parameters_normal_dist_from_two_percentiles(vals = consumption_change_vals_EKE,
                                                                              probs = consumption_change_probs_EKE)

  for(i in 1:niter_epi){

    gen_data_concentration <-  lapply(post_concentration, generate_samples_normal_gamma, niter_ale = niter_ale, percentile_ale = NULL)

    gen_data_consumption_prime <-  lapply(post_consumption, generate_samples_normal_gamma, niter_ale = niter_ale, percentile_ale = percentile_ale)

    gen_data_consumption <- gen_data_consumption_prime

    gen_data_EKE = rnorm(1, mean =  fit_normal_dist_EKE[[1]], sd =  fit_normal_dist_EKE[[2]])

    for(k in 1:nr_products){

      gen_data_consumption[[k]]$gen_sample  <- gen_data_consumption_prime[[k]]$gen_sample * rbinom(n = niter_ale, size = 1, prob = prob_consumption_event[[k]])
    }

    frequency_excceding[[i]] <- combine_uncertainty(gen_data_concentration =  gen_data_concentration, gen_data_consumption = gen_data_consumption,
                                            gen_data_EKE = gen_data_EKE, threshold =  threshold, niter_ale = niter_ale)

  }

  expected_frequency_exceeding <- mean(frequency_exceeding)
  hdi_frequency_exceeding <- hdi(frequency_exceeding, credMass = 0.95) # Highest (Posterior) Density Interval

  return(list(prob_consumption_event = prob_consumption_event,
              parameters_concentration = parameters_concentration,
              parameters_consumption = parameters_consumption,
              frequency_exceeding = frequency_exceeding,
              expected_frequency_exceeding = expected_frequency_exceeding,
              hdi_frequency_exceeding = hdi_frequency_exceeding))
}
