
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

This examples does the aluminium exposure assessment by precise
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
#>   ..$ : num 0.15
#>   ..$ : num 0.655
#>   ..$ : num 0.213
#>   ..$ : num 0.118
#>   ..$ : num 0.271
#>   ..$ : num 0.477
#>   ..$ : num 0.291
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
#>  $ prob_exceed             : num [1:1000] 0.026 0.057 0.027 0.027 0.051 0.034 0.005 0.03 0.024 0.027 ...
#>  $ expected_prob_exceed    : num 0.039
#>  $ hdi_prob_exceed         : Named num [1:2] 0.008 0.074
#>   ..- attr(*, "names")= chr [1:2] "lower" "upper"
#>   ..- attr(*, "credMass")= num 0.95

## Expected probability of exceeding the safety threshold
TWI_pp$expected_prob_exceed
#> [1] 0.039002

## Highest posterior density interval of the probability of exceeding the safety threshold
TWI_pp$hdi_prob_exceed
#> lower upper 
#> 0.008 0.074 
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
#>   ..$ : num 0.169
#>   ..$ : num 0.652
#>   ..$ : num 0.226
#>   ..$ : num 0.134
#>   ..$ : num 0.279
#>   ..$ : num 0.509
#>   ..$ : num 0.278
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
#>  $ prob_exceed             : num [1:1000] 0.498 0.698 0.777 0.659 0.799 0.633 0.942 0.74 0.19 0.613 ...
#>  $ expected_prob_exceed    : num 0.58
#>  $ hdi_prob_exceed         : Named num [1:2] 0.254 0.933
#>   ..- attr(*, "names")= chr [1:2] "lower" "upper"
#>   ..- attr(*, "credMass")= num 0.95

## Expected probability of exceeding the safety threshold
TWI_pp_high_consumer$expected_prob_exceed
#> [1] 0.580302

## Highest posterior density interval of the probability of exceeding the safety threshold
TWI_pp_high_consumer$hdi_prob_exceed
#> lower upper 
#> 0.254 0.933 
#> attr(,"credMass")
#> [1] 0.95
```

We can now visualize the results. Epistemic uncertainty has been
characterized by a full probability distribution

``` r
 ## All children
  graph_pp(prob_exceed = TWI_pp$prob_exceed)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

``` r
    
 ## A high consumer child
  graph_pp(prob_exceed = TWI_pp_high_consumer$prob_exceed)
```

<img src="man/figures/README-unnamed-chunk-5-2.png" width="100%" />

``` r
    
 ## both graphs
   # graph_pp_both(prob_exceed_all = TWI_pp$prob_exceed, 
   #                prob_exceed_high_consumer = TWI_pp_high_consumer$prob_exceed)
```

Now, let us estimate the probability of exceeding the safety threshold
by bounded probability.

First, let us consider all children
