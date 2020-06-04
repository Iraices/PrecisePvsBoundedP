
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ppvsbp

<!-- badges: start -->

<!-- badges: end -->

The aim of `ppvsbp` package is to make available the code used in the
paper " A comparison between precise and bounded probability to quantify
epistemic uncertainty in a scientific assessment" …

## Installation

You can install the development version of `ppvsbp` from
[github](https://github.com/Iraices/PrecisePvsBoundedP) with:

``` r
# remotes::install_github('Iraices/PrecisePvsBoundedP')
```

## Example

This example does the aluminium exposure assessment by precise
probability.

First, let us estimate the probability of exceeding the safety threshold
for all chidren

``` r
library(ppvsbp)
## basic example code
TWI_pp <- unc_analysis_assessment(niter_ale = 1000, niter_epi = 1000, threshold = 1,
                                  percentile_ale = NULL,
                                  suff_stat_concentration = data_assessment$log_concentration_ss_data,
                                  suff_stat_consumption = data_assessment$log_consumption_ss_data,
                                  consumption_change_vals_EKE = data_assessment$change_cons$vals,
                                  consumption_change_probs_EKE = data_assessment$change_cons$probs/100,
                                  consumers_info_sample_size = data_assessment$consumers_info_sample_size,
                                  concentration_mu0 = 3.5, concentration_v0 = 5, concentration_alpha0 = 1,
                                  concentration_beta0 = 1, sufficient_statistics_concentration = TRUE,
                                  consumption_mu0 = -3, consumption_v0 = 5, consumption_alpha0 = 1,
                                  consumption_beta0 = 1, sufficient_statistics_consumption = TRUE,
                                  consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
## Outputs
str(TWI_pp)
#> List of 6
#>  $ prob_consumption_event  :List of 7
#>   ..$ : num 0.135
#>   ..$ : num 0.641
#>   ..$ : num 0.249
#>   ..$ : num 0.126
#>   ..$ : num 0.271
#>   ..$ : num 0.502
#>   ..$ : num 0.303
#>  $ parameters_concentration:List of 7
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 3.02
#>   .. .. ..$ v    : num 158
#>   .. .. ..$ alpha: num 77.5
#>   .. .. ..$ beta : num 25.3
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 2.78
#>   .. .. ..$ v    : num 376
#>   .. .. ..$ alpha: num 186
#>   .. .. ..$ beta : num 256
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 3.3
#>   .. .. ..$ v    : num 26
#>   .. .. ..$ alpha: num 11.5
#>   .. .. ..$ beta : num 7
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 2.73
#>   .. .. ..$ v    : num 66
#>   .. .. ..$ alpha: num 31.5
#>   .. .. ..$ beta : num 34.1
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 3.75
#>   .. .. ..$ v    : num 505
#>   .. .. ..$ alpha: num 251
#>   .. .. ..$ beta : num 78.8
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 4.94
#>   .. .. ..$ v    : num 494
#>   .. .. ..$ alpha: num 246
#>   .. .. ..$ beta : num 48.6
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 3.38
#>   .. .. ..$ v    : num 56
#>   .. .. ..$ alpha: num 26.5
#>   .. .. ..$ beta : num 9.88
#>  $ parameters_consumption  :List of 7
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.21
#>   .. .. ..$ v    : num 112
#>   .. .. ..$ alpha: num 54.5
#>   .. .. ..$ beta : num 47.1
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -1.67
#>   .. .. ..$ v    : num 486
#>   .. .. ..$ alpha: num 242
#>   .. .. ..$ beta : num 266
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.3
#>   .. .. ..$ v    : num 176
#>   .. .. ..$ alpha: num 86.5
#>   .. .. ..$ beta : num 82.9
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.09
#>   .. .. ..$ v    : num 100
#>   .. .. ..$ alpha: num 48.5
#>   .. .. ..$ beta : num 78.5
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.67
#>   .. .. ..$ v    : num 199
#>   .. .. ..$ alpha: num 98
#>   .. .. ..$ beta : num 109
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -3.99
#>   .. .. ..$ v    : num 353
#>   .. .. ..$ alpha: num 175
#>   .. .. ..$ beta : num 296
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.01
#>   .. .. ..$ v    : num 226
#>   .. .. ..$ alpha: num 112
#>   .. .. ..$ beta : num 184
#>  $ prob_exceed             : num [1:1000] 0.042 0.035 0.091 0.034 0.024 0.029 0.026 0.02 0.026 0.033 ...
#>  $ expected_prob_exceed    : num 0.0392
#>  $ hdi_prob_exceed         : Named num [1:2] 0.012 0.073
#>   ..- attr(*, "names")= chr [1:2] "lower" "upper"
#>   ..- attr(*, "credMass")= num 0.95

## Expected probability of exceeding the safety threshold
TWI_pp$expected_prob_exceed
#> [1] 0.039249

## Highest posterior density interval of the probability of exceeding the safety threshold
TWI_pp$hdi_prob_exceed
#> lower upper 
#> 0.012 0.073 
#> attr(,"credMass")
#> [1] 0.95
```

Second, let us estimate the probability of exceeding the safety
threshold for a high consumer child. Note, the argument `percentile_ale`
has changed `percentile_ale = 95`.

``` r
  TWI_pp_high_consumer <- unc_analysis_assessment(niter_ale = 1000, niter_epi = 1000, threshold = 1,
                                   percentile_ale = 95,
                                   suff_stat_concentration = data_assessment$log_concentration_ss_data,
                                   suff_stat_consumption = data_assessment$log_consumption_ss_data,
                                   consumption_change_vals_EKE = data_assessment$change_cons$vals,
                                   consumption_change_probs_EKE = data_assessment$change_cons$probs/100,
                                   consumers_info_sample_size = data_assessment$consumers_info_sample_size,
                                   concentration_mu0 = 3.5, concentration_v0 = 5, concentration_alpha0 = 1,
                                   concentration_beta0 = 1, sufficient_statistics_concentration = TRUE,
                                   consumption_mu0 = -3, consumption_v0 = 5, consumption_alpha0 = 1,
                                   consumption_beta0 = 1, sufficient_statistics_consumption = TRUE,
                                   consumption_event_alpha0 = 1, consumption_event_beta0 = 1)

## Outputs
str(TWI_pp_high_consumer)
#> List of 6
#>  $ prob_consumption_event  :List of 7
#>   ..$ : num 0.176
#>   ..$ : num 0.683
#>   ..$ : num 0.249
#>   ..$ : num 0.117
#>   ..$ : num 0.281
#>   ..$ : num 0.466
#>   ..$ : num 0.325
#>  $ parameters_concentration:List of 7
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 3.02
#>   .. .. ..$ v    : num 158
#>   .. .. ..$ alpha: num 77.5
#>   .. .. ..$ beta : num 25.3
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 2.78
#>   .. .. ..$ v    : num 376
#>   .. .. ..$ alpha: num 186
#>   .. .. ..$ beta : num 256
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 3.3
#>   .. .. ..$ v    : num 26
#>   .. .. ..$ alpha: num 11.5
#>   .. .. ..$ beta : num 7
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 2.73
#>   .. .. ..$ v    : num 66
#>   .. .. ..$ alpha: num 31.5
#>   .. .. ..$ beta : num 34.1
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 3.75
#>   .. .. ..$ v    : num 505
#>   .. .. ..$ alpha: num 251
#>   .. .. ..$ beta : num 78.8
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 4.94
#>   .. .. ..$ v    : num 494
#>   .. .. ..$ alpha: num 246
#>   .. .. ..$ beta : num 48.6
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num 3.5
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num 3.38
#>   .. .. ..$ v    : num 56
#>   .. .. ..$ alpha: num 26.5
#>   .. .. ..$ beta : num 9.88
#>  $ parameters_consumption  :List of 7
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.21
#>   .. .. ..$ v    : num 112
#>   .. .. ..$ alpha: num 54.5
#>   .. .. ..$ beta : num 47.1
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -1.67
#>   .. .. ..$ v    : num 486
#>   .. .. ..$ alpha: num 242
#>   .. .. ..$ beta : num 266
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.3
#>   .. .. ..$ v    : num 176
#>   .. .. ..$ alpha: num 86.5
#>   .. .. ..$ beta : num 82.9
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.09
#>   .. .. ..$ v    : num 100
#>   .. .. ..$ alpha: num 48.5
#>   .. .. ..$ beta : num 78.5
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.67
#>   .. .. ..$ v    : num 199
#>   .. .. ..$ alpha: num 98
#>   .. .. ..$ beta : num 109
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -3.99
#>   .. .. ..$ v    : num 353
#>   .. .. ..$ alpha: num 175
#>   .. .. ..$ beta : num 296
#>   ..$ :List of 2
#>   .. ..$ prior    :List of 4
#>   .. .. ..$ mu   : num -3
#>   .. .. ..$ v    : num 5
#>   .. .. ..$ alpha: num 1
#>   .. .. ..$ beta : num 1
#>   .. ..$ posterior:List of 4
#>   .. .. ..$ mu   : num -2.01
#>   .. .. ..$ v    : num 226
#>   .. .. ..$ alpha: num 112
#>   .. .. ..$ beta : num 184
#>  $ prob_exceed             : num [1:1000] 0.614 0.528 0.479 0.896 0.511 0.62 0.494 0.414 0.586 0.165 ...
#>  $ expected_prob_exceed    : num 0.574
#>  $ hdi_prob_exceed         : Named num [1:2] 0.242 0.912
#>   ..- attr(*, "names")= chr [1:2] "lower" "upper"
#>   ..- attr(*, "credMass")= num 0.95

## Expected probability of exceeding the safety threshold
TWI_pp_high_consumer$expected_prob_exceed
#> [1] 0.573948

## Highest posterior density interval of the probability of exceeding the safety threshold
TWI_pp_high_consumer$hdi_prob_exceed
#> lower upper 
#> 0.242 0.912 
#> attr(,"credMass")
#> [1] 0.95
```

We can now visualize the results. Epistemic uncertainty has been
characterized by a full probability distribution

``` r
 ## All children
  graph_pp(prob_exceed = TWI_pp$prob_exceed)
```

<img src="man/figures/README-fig1-1.png" width="70%" />

``` r
    
 ## A high consumer child
  graph_pp(prob_exceed = TWI_pp_high_consumer$prob_exceed)
```

<img src="man/figures/README-fig1-2.png" width="70%" />

``` r
    
 ## both graphs
    graph_pp_both(prob_exceed_all = TWI_pp$prob_exceed, 
                   prob_exceed_high_consumer = TWI_pp_high_consumer$prob_exceed)
```

<img src="man/figures/README-fig1-3.png" width="70%" />

Now, let us estimate the probability of exceeding the safety threshold
by bounded probability.

First, let us consider all children

``` r
  ## All children
  lower_bound_prob <- bound_prob_exceed_bp(obj_func_bp = obj_func_bp, maximize = FALSE, 
                                            lower_parameters  = c(1, -5, -20), 
                                            upper_parameters  = c(6, 1, -10),
                                            niter_ale = 1000, niter_epi = 1000, threshold = 1, percentile_ale = NULL,
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
                                            consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
  

  
  ## All children
  upper_bound_prob <- bound_prob_exceed_bp(obj_func_bp = obj_func_bp, maximize = TRUE, 
                                           lower_parameters  = c(1, -5, -20), 
                                           upper_parameters  = c(6, 1, -10),
                                           niter_ale = 1000, niter_epi = 1000, threshold = 1, 
                                           percentile_ale = NULL,
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
                                           consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
  
```

Now, let us consider a high consumer child

``` r
  ## A high consumer child
  lower_bound_high_consumer <- bound_prob_exceed_bp(obj_func_bp = obj_func_bp, maximize = FALSE, 
                                                   lower_parameters  = c(1, -5, -20), 
                                                   upper_parameters  = c(6, 1, -10),
                                                   niter_ale = 1000, niter_epi = 1000, threshold = 1, 
                                                   percentile_ale = 95,
                                                   suff_stat_concentration = data_assessment$log_concentration_ss_data,
                                                   suff_stat_consumption = data_assessment$log_consumption_ss_data,
                                                   consumption_change_vals_EKE = c(-15, 7.5), 
                                                   consumption_change_probs_EKE = c(0.25, 0.75),
                                                   consumers_info_sample_size = data_assessment$consumers_info_sample_size,
                                                   concentration_mu0 = 2.75,
                                                   concentration_v0 = 5, concentration_alpha0 = 1, 
                                                   concentration_beta0 = 1, 
                                                   sufficient_statistics_concentration = TRUE,
                                                   consumption_mu0 = -2.5,
                                                   consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1, 
                                                   sufficient_statistics_consumption = TRUE,
                                                   consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
  
  
  
   ## A high consumer child
  upper_bound_high_consumer <- bound_prob_exceed_bp(obj_func_bp = obj_func_bp, maximize = TRUE, 
                                                    lower_parameters  = c(1, -5, -20), 
                                                    upper_parameters  = c(6, 1, -10),
                                                    niter_ale = 1000, niter_epi = 1000, threshold = 1, 
                                                    percentile_ale = 95,
                                                    suff_stat_concentration = data_assessment$log_concentration_ss_data,
                                                    suff_stat_consumption = data_assessment$log_consumption_ss_data,
                                                    consumption_change_vals_EKE = c(-15, 7.5), 
                                                    consumption_change_probs_EKE = c(0.25, 0.75),
                                                    consumers_info_sample_size = data_assessment$consumers_info_sample_size,
                                                    concentration_mu0 = 2.75,
                                                    concentration_v0 = 5, concentration_alpha0 = 1, 
                                                    concentration_beta0 = 1, 
                                                    sufficient_statistics_concentration = TRUE,
                                                    consumption_mu0 = -2.5,
                                                    consumption_v0 = 5, consumption_alpha0 = 1, consumption_beta0 = 1, 
                                                    sufficient_statistics_consumption = TRUE,
                                                    consumption_event_alpha0 = 1, consumption_event_beta0 = 1)
  
```

We can visualize the results individualy or together. In this case,
epistemic uncertainty has been characterized by a p-box.

Individual figures

``` r
 ## All children
 graph_bp(lower_points = lower_bound_prob$opt_prob$prob_exceed, 
          upper_points = upper_bound_prob$opt_prob$prob_exceed)
```

<img src="man/figures/README-fig2-1.png" width="70%" />

``` r
    
 ## A high consumer child
 graph_bp(lower_points = lower_bound_high_consumer$opt_prob$prob_exceed, 
          upper_points = upper_bound_high_consumer$opt_prob$prob_exceed)
```

<img src="man/figures/README-fig2-2.png" width="70%" />

Both figures together

``` r
 ## Both graphs
  graph_bp_both(lower_points_all = lower_bound_prob$opt_prob$prob_exceed, 
                upper_points_all = upper_bound_prob$opt_prob$prob_exceed,
                lower_points_high_consumer = lower_bound_high_consumer$opt_prob$prob_exceed, 
                upper_points_high_consumer = upper_bound_high_consumer$opt_prob$prob_exceed)
```

<img src="man/figures/README-fig3-1.png" width="70%" />

End
