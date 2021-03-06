#'
#'This function uses the Nelder-Mead algorithm  for the optimization procedure. This algorithm
#' is implemented in the 'nmkb' function from the {dfoptim} package.
#'
#' @param obj_func_bp                          The objective function to optimize.
#' @param maximize                             A logical variable indicating whether the objective function should be maximized. Default is \code{FALSE}.
#' @param lower_parameters                     Lower bounds on the parameters. A vector of the same length as the parameters.
#' @param upper_parameters                     Upper bounds on the parameters. A vector of the same length as the parameters.
#' @param niter_ale                            number of generated samples
#' @param niter_epi                            number of generated parameters from the posterior distrbutions
#'                                             (it indicates the number of repetitions the assessment will be done)
#' @param threshold                            safety threshold
#' @param suff_stat_concentration              a vector of sufficient statistics: sample_size, sample_mean and sample_sd
#'                                             corresponding to concentration. If sufficient_statistics_concentration = \code{FALSE},
#'                                             then it is vector of observed data
#' @param suff_stat_consumption                a vector of sufficient statistics: sample_size, sample_mean and sample_sd
#'                                             corresponding to consumption. If sufficient_statistics_consumption = \code{FALSE},
#'                                             then it is vector of observed data
#' @param consumption_change_vals_EKE          a vector of elicited values from experts
#' @param consumption_change_probs_EKE         a vector of elicited probabilities from experts
#' @param consumers_info_sample_size           a vector with the sample size of non_consumer_sample_size and consumer_sample_size
#' @param concentration_mu0                    prior hyperparameter \emph{mu0} for the normal-gamma distribution corresponding to concentration
#' @param concentration_v0                     prior hyperparameter \emph{v0} for the normal-gamma distribution corresponding to concentration
#' @param concentration_alpha0                 prior hyperparameter \emph{alpha0} for the normal-gamma distribution  corresponding to concentration
#' @param concentration_beta0                  prior hyperparameter \emph{beta0} for the normal-gamma distribution corresponding to concentration
#' @param sufficient_statistics_concentration  logical; if \code{TRUE}, sufficient statistics (sample_size, sample_mean, sample_variance)
#'                                             corresponding to concentration are given as input data, otherwise
#'                                             sufficient_statistics_concentration is given as observed data. Default is \code{TRUE}
#' @param consumption_mu0                      prior hyperparameter \emph{mu0} for the normal-gamma distribution corresponding to consumption
#' @param consumption_v0                       prior hyperparameter \emph{v0} for the normal-gamma distribution corresponding to consumption
#' @param consumption_alpha0                   prior hyperparameter \emph{alpha0} for the normal-gamma distribution corresponding to consumption
#' @param consumption_beta0                    prior hyperparameter \emph{beta0} for the normal-gamma distribution corresponding to consumption
#' @param sufficient_statistics_consumption    logical; if \code{TRUE}, sufficient statistics (sample_size, sample_mean, sample_variance)
#'                                             corresponding to consumption are given as input data, otherwise
#'                                             sufficient_statistics_consumption is given as observed data. Default is \code{TRUE}
#' @param consumption_event_alpha0             prior hyperparameter \emph{alpha0} for the beta distribution corresponding to consumption event
#' @param consumption_event_beta0              prior hyperparameter \emph{beta0} for the beta distribution corresponding to consumption event
#' @param percentile                           a value between 1 and 100 which indicates a percentile. By default
#'                                             is NULL
#'
#' @return ## Two lists
#' \enumerate{
#' \item opt_value
#' \item opt_freq
#' }
#' The components of the first list (\emph{opt_value}) are
#' \describe{
#' \item{par}{Best estimate of the parameter vector found by the algorithm}
#' \item{value}{The value of the objective function at termination}
#' \item{feval}{The number of times the objective function was evaluated}
#' \item{restarts}{The number of times the algorithm had to be restarted when it stagnated}
#' \item{convergence}{An integer code indicating type of convergence. 0 indicates successful convergence. Positive integer codes indicate failure to converge}
#' \item{message}{Text message indicating the type of convergence or failure}
#' }
#' The components of the second list (\emph{opt_freq}) are
#' \describe{
#' \item{prob_consumption_event}{The estimated probability of consumption events}
#' \item{parameters_concentration}{A list with the values of the prior and posterior parameters of concentration}
#' \item{parameters_consumption}{A list with the prior and posterior parameters of consumption}
#' \item{frequency_exceeding}{A vector with the estimated frequency of exceeding the threshold (the lenght is niter_epi)}
#' \item{expected_frequency_exceeding}{The expected value of the frequency of exceeding the threshold}
#' \item{hdi_frequency_exceeding}{The highest posterior density interval of the frequency of exceeding the threshold}
#' }
#'
#' @importFrom dfoptim nmkb
#'
#' @export
#'
#' @examples
#' \dontrun{
#' lower_bound <-
#'   bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = FALSE,
#'            lower_parameters  = c(1, -5, -20),
#'            upper_parameters  = c(6, 1, -10),
#'            niter_ale = 2000, niter_epi = 2000, threshold = 1,
#'            suff_stat_concentration = data_assessment$log_concentration_ss_data,
#'            suff_stat_consumption = data_assessment$log_consumption_ss_data,
#'            consumption_change_vals_EKE = c(-15, 7.5),
#'            consumption_change_probs_EKE = c(0.25, 0.75),
#'            consumers_info_sample_size = data_assessment$consumers_info_sample_size,
#'            concentration_mu0 = 2.75,
#'            concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
#'            sufficient_statistics_concentration = TRUE,
#'            consumption_mu0 = -2.5,
#'            consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
#'            sufficient_statistics_consumption = TRUE,
#'            consumption_event_alpha0 = 1, consumption_event_beta0 = 1, percentile = NULL)
#'
#' upper_bound <-
#'  bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = TRUE,
#'            lower_parameters  = c(1, -5, -20),
#'            upper_parameters  = c(6, 1, -10),
#'            niter_ale = 2000, niter_epi = 2000, threshold = 1,
#'            suff_stat_concentration = data_assessment$log_concentration_ss_data,
#'            suff_stat_consumption = data_assessment$log_consumption_ss_data,
#'            consumption_change_vals_EKE = c(-15, 7.5),
#'            consumption_change_probs_EKE = c(0.25, 0.75),
#'            consumers_info_sample_size = data_assessment$consumers_info_sample_size,
#'            concentration_mu0 = 2.75,
#'            concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
#'            sufficient_statistics_concentration = TRUE,
#'            consumption_mu0 = -2.5,
#'            consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
#'            sufficient_statistics_consumption = TRUE,
#'            consumption_event_alpha0 = 1, consumption_event_beta0 = 1, percentile = NULL)
#'
#' }
#'
bound_frequency_exceeding_bp  <- function(obj_func_bp, maximize = FALSE,
                                  lower_parameters  = c(1, -5, -20),
                                  upper_parameters  = c(6, 1, -10),
                                  niter_ale = 1000, niter_epi = 1000, threshold = 1,
                                  suff_stat_concentration ,
                                  suff_stat_consumption,
                                  consumption_change_vals_EKE = c(-15, 7.5),
                                  consumption_change_probs_EKE = c(0.25,0.75),
                                  consumers_info_sample_size,
                                  concentration_mu0 = 2.75,
                                  concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
                                  sufficient_statistics_concentration = TRUE,
                                  consumption_mu0 = -2.5,
                                  consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
                                  sufficient_statistics_consumption = TRUE,
                                  consumption_event_alpha0 = 1, consumption_event_beta0 = 1,
                                  percentile = NULL){

  initial_parameters <- c(concentration_mu0, consumption_mu0, consumption_change_vals_EKE[1])

  ## optimizing over the expected value.

  opt_value <- nmkb(par = initial_parameters, fn = obj_func_bp, lower = lower_parameters, upper = upper_parameters,
                    control = list(maximize =  maximize),
                    niter_ale = niter_ale, niter_epi = niter_epi, threshold = threshold,
                    suff_stat_concentration = suff_stat_concentration, suff_stat_consumption = suff_stat_consumption,
                    consumption_change_vals_EKE = consumption_change_vals_EKE[2],
                    consumption_change_probs_EKE = consumption_change_probs_EKE,
                    consumers_info_sample_size = consumers_info_sample_size,
                    concentration_v0 = concentration_v0, concentration_alpha0 = concentration_alpha0,
                    concentration_beta0 = concentration_beta0, sufficient_statistics_concentration = sufficient_statistics_concentration,
                    consumption_v0 = consumption_v0, consumption_alpha0 = consumption_alpha0,
                    consumption_beta0 = consumption_beta0, sufficient_statistics_consumption = sufficient_statistics_consumption,
                    consumption_event_alpha0 = consumption_event_alpha0,
                    consumption_event_beta0 = consumption_event_beta0,
                    percentile = percentile)

  ## short cut
  out_freq <- unc_analysis_assessment_bp(niter_ale = niter_ale, niter_epi= niter_epi,
                                         threshold = threshold,
                                         suff_stat_concentration = suff_stat_concentration,
                                         suff_stat_consumption = suff_stat_consumption,
                                         consumption_change_vals_EKE = c(opt_value$par[3],consumption_change_vals_EKE[2]),
                                         consumption_change_probs_EKE = consumption_change_probs_EKE,
                                         consumers_info_sample_size = consumers_info_sample_size,
                                         concentration_mu0 = opt_value$par[1], concentration_v0 = concentration_v0,
                                         concentration_alpha0 = concentration_alpha0, concentration_beta0 = concentration_beta0,
                                         sufficient_statistics_concentration = sufficient_statistics_concentration,
                                         consumption_mu0 =  opt_value$par[2], consumption_v0 =  consumption_v0,
                                         consumption_alpha0 = consumption_alpha0, consumption_beta0 = consumption_beta0,
                                         sufficient_statistics_consumption = sufficient_statistics_consumption,
                                         consumption_event_alpha0 = consumption_event_alpha0, consumption_event_beta0 = consumption_event_beta0)

  return(list(opt_value = opt_value, opt_freq = out_freq))
}
