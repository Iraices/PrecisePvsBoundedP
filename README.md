
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ppvsbp

<!-- badges: start -->

<!-- badges: end -->

The aim of `ppvsbp` package is to make available the code used in the
paper " A suggestion for the quantification of precise and bounded
probability to quantify epistemic uncertainty in scientific assessments"

This is a simplified version of an existing scientific assessment on the
weekly intake dose of aluminium via consumption of cocoa and chocolate
products done by BfR. The aim of the assessment was to estimate the 2017
average long-term aluminium intake (chronic toxicity) by consumption of
chocolate and cocoa products in 2017 for infants from age 0.5 years to
less than 5 years (which are not breastfed) in Germany for the 95th
percentile of the specified population (in \(\mu\)g/(kg bw)/week). The
results were compared with the tolerable weekly intake (TWI) of 1 mg/kg
for aluminium.

This is a common type of scientific assessment where the assessment
model contains several variables which are combined to estimate the
probability that a child exceeds the tolerable weekly intake of
aluminium from consuming chocolate products. …

## Installation

You can install the development version of `ppvsbp` from
[github](https://github.com/Iraices/PrecisePvsBoundedP) with:

``` r
remotes::install_github('Iraices/PrecisePvsBoundedP')
```

## Example

This example does the aluminium exposure assessment by precise
probability derived by Bayesian analysis.

First, let us estimate the frequency of exceeding the safety threshold
for an average scenario

``` r
library(ppvsbp)
## Average consumption scenario
TWI_pp_average_consumption <-
   unc_analysis_assessment(niter_ale = 5000, niter_epi = 5000,
             threshold = 1, exposure_scenario = 'av',
             suff_stat_concentration = data_assessment$log_concentration_ss_data,
             suff_stat_consumption = data_assessment$log_consumption_ss_data,
             consumption_change_vals_EKE = data_assessment$change_cons$vals,
             consumption_change_probs_EKE = data_assessment$change_cons$probs/100,
             consumers_info_sample_size = data_assessment$consumers_info_sample_size,
             concentration_mu0 = 3.5, concentration_v0 = 5,
             concentration_alpha0 = 1, concentration_beta0 = 1,
             sufficient_statistics_concentration = TRUE,
             consumption_mu0 = -3, consumption_v0 = 5,
             consumption_alpha0 = 1, consumption_beta0 = 1,
             sufficient_statistics_consumption = TRUE,
             consumption_event_alpha0 = 1,
             consumption_event_beta0 = 1)

## Expected frequency of exceeding the safety threshold
TWI_pp_average_consumption$expected_frequency_exceeding
#> [1] 0.0009878

## Highest posterior density interval of the frequency of exceeding the safety threshold
TWI_pp_average_consumption$hdi_frequency_exceeding
#>  lower  upper 
#> 0.0000 0.0026 
#> attr(,"credMass")
#> [1] 0.95
```

Second, let us estimate the frequency of exceeding the safety threshold
for a high consumption scenario. Note, the argument `exposure_scenario`
has changed `exposure_scenario = 'perc_95'`.

``` r
## High consumption scenario
 TWI_pp_high_consumption <-
   unc_analysis_assessment(niter_ale = 5000, niter_epi = 5000,
              threshold = 1, exposure_scenario = 'perc_95',
              suff_stat_concentration = data_assessment$log_concentration_ss_data,
              suff_stat_consumption = data_assessment$log_consumption_ss_data,
              consumption_change_vals_EKE = data_assessment$change_cons$vals,
              consumption_change_probs_EKE = data_assessment$change_cons$probs/100,
              consumers_info_sample_size = data_assessment$consumers_info_sample_size,
              concentration_mu0 = 3.5, concentration_v0 = 5,
              concentration_alpha0 = 1, concentration_beta0 = 1,
              sufficient_statistics_concentration = TRUE,
              consumption_mu0 = -3, consumption_v0 = 5,
              consumption_alpha0 = 1, consumption_beta0 = 1,
              sufficient_statistics_consumption = TRUE,
              consumption_event_alpha0 = 1,
              consumption_event_beta0 = 1)

## Expected probability of exceeding the safety threshold
TWI_pp_high_consumption$expected_frequency_exceeding
#> [1] 0.0682148

## Highest posterior density interval of the probability of exceeding the safety threshold
TWI_pp_high_consumption$hdi_frequency_exceeding
#>  lower  upper 
#> 0.0086 0.1388 
#> attr(,"credMass")
#> [1] 0.95
```

We can now visualize the results. Epistemic uncertainty has been
characterized by a full probability distribution.

``` r
 ## Average consumption scenario
  graph_pp(frequency_exceeding = TWI_pp_average_consumption$frequency_exceeding)
```

<img src="man/figures/README-fig1-1.png" width="70%" />

``` r
    
 ## High consumption scenario
  graph_pp(frequency_exceeding = TWI_pp_high_consumption$frequency_exceeding)
```

<img src="man/figures/README-fig1-2.png" width="70%" />

``` r
 ## both scenarios
 graph_pp_both(frequency_exceeding_average_consumption = TWI_pp_average_consumption$frequency_exceeding, 
               frequency_exceeding_high_consumption = TWI_pp_high_consumption$frequency_exceeding)
```

<img src="man/figures/README-fig2-1.png" width="85%" />

Now, let us estimate the frequency of exceeding the safety threshold by
bounded probability derived by robust Bayesian analysis.

First, let us consider the case of average consumption

``` r
## Average consumption scenario
lower_bound_average_consumption <-
    bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = FALSE,
       lower_parameters  = c(1, -5, -20),
       upper_parameters  = c(6, 1, -10),
       niter_ale = 2000, niter_epi = 2000, threshold = 1, exposure_scenario = 'av',
       suff_stat_concentration = data_assessment$log_concentration_ss_data,
       suff_stat_consumption = data_assessment$log_consumption_ss_data,
       consumption_change_vals_EKE = c(-15, 7.5),
       consumption_change_probs_EKE = c(0.25, 0.75),
       consumers_info_sample_size = data_assessment$consumers_info_sample_size,
       concentration_mu0 = 2.75,
       concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
       sufficient_statistics_concentration = TRUE,
       consumption_mu0 = -2.5,
       consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
       sufficient_statistics_consumption = TRUE,
       consumption_event_alpha0 = 1, consumption_event_beta0 = 1, percentile = NULL)
  

## Average consumption scenario
upper_bound_average_consumption <- 
   bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = TRUE,
       lower_parameters  = c(1, -5, -20),
       upper_parameters  = c(6, 1, -10),
       niter_ale = 2000, niter_epi = 2000, threshold = 1, exposure_scenario = 'av',
       suff_stat_concentration = data_assessment$log_concentration_ss_data,
       suff_stat_consumption = data_assessment$log_consumption_ss_data,
       consumption_change_vals_EKE = c(-15, 7.5),
       consumption_change_probs_EKE = c(0.25, 0.75),
       consumers_info_sample_size = data_assessment$consumers_info_sample_size,
       concentration_mu0 = 2.75,
       concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
       sufficient_statistics_concentration = TRUE,
       consumption_mu0 = -2.5,
       consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
       sufficient_statistics_consumption = TRUE,
       consumption_event_alpha0 = 1, consumption_event_beta0 = 1, percentile = NULL)
  
```

Now, let us consider the case of high consumption

``` r
  ## High consumption scenario
  lower_bound_high_consumption <- 
    bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = FALSE,
       lower_parameters  = c(1, -5, -20),
       upper_parameters  = c(6, 1, -10),
       niter_ale = 2000, niter_epi = 2000, threshold = 1, exposure_scenario = 'perc_95',
       suff_stat_concentration = data_assessment$log_concentration_ss_data,
       suff_stat_consumption = data_assessment$log_consumption_ss_data,
       consumption_change_vals_EKE = c(-15, 7.5),
       consumption_change_probs_EKE = c(0.25, 0.75),
       consumers_info_sample_size = data_assessment$consumers_info_sample_size,
       concentration_mu0 = 2.75,
       concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
       sufficient_statistics_concentration = TRUE,
       consumption_mu0 = -2.5,
       consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
       sufficient_statistics_consumption = TRUE,
       consumption_event_alpha0 = 1, consumption_event_beta0 = 1, percentile = NULL)
  
  
  
## High consumption scenario 
upper_bound_high_consumption <- 
    bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = TRUE,
       lower_parameters  = c(1, -5, -20),
       upper_parameters  = c(6, 1, -10),
       niter_ale = 2000, niter_epi = 2000, threshold = 1, exposure_scenario = 'perc_95',
       suff_stat_concentration = data_assessment$log_concentration_ss_data,
       suff_stat_consumption = data_assessment$log_consumption_ss_data,
       consumption_change_vals_EKE = c(-15, 7.5),
       consumption_change_probs_EKE = c(0.25, 0.75),
       consumers_info_sample_size = data_assessment$consumers_info_sample_size,
       concentration_mu0 = 2.75,
       concentration_v0 = 5, concentration_alpha0 = 1, concentration_beta0 = 1,
       sufficient_statistics_concentration = TRUE,
       consumption_mu0 = -2.5,
       consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1,
       sufficient_statistics_consumption = TRUE,
       consumption_event_alpha0 = 1, consumption_event_beta0 = 1, percentile = NULL)
```

In the case of bounded probability derived by robust Bayesian analysis,
epistemic uncertainty has been characterized by a probabilty box. The
results of both cases can be visualized individualy or together.

Individual cases (average consumption and high consumption)

``` r
 ## Average consumption scenario
graph_bp(lower_points = lower_bound_average_consumption$opt_freq$frequency_exceeding, 
         upper_points = upper_bound_average_consumption$opt_freq$frequency_exceeding)
```

<img src="man/figures/README-fig3-1.png" width="70%" />

``` r
    
 ## High consumption scenario 
graph_bp(lower_points = lower_bound_high_consumption$opt_freq$frequency_exceeding, 
         upper_points = upper_bound_high_consumption$opt_freq$frequency_exceeding)
```

<img src="man/figures/README-fig3-2.png" width="70%" />

Both cases together (average consumption and high consumption)

``` r
 ## Both scenarios
graph_bp_both(lower_points_average_consumption =                lower_bound_average_consumption$opt_freq$frequency_exceeding, 
             upper_points_average_consumption = upper_bound_average_consumption$opt_freq$frequency_exceeding,
              lower_points_high_consumption = lower_bound_high_consumption$opt_freq$frequency_exceeding,                      upper_points_high_consumption = 
                upper_bound_high_consumption$opt_freq$frequency_exceeding)
```

<img src="man/figures/README-fig4-1.png" width="70%" />
