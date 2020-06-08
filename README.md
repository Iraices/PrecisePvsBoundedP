
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ppvsbp

<!-- badges: start -->

<!-- badges: end -->

The aim of `ppvsbp` package is to make available the code used in the
paper " A comparison between precise and bounded probability to quantify
epistemic uncertainty in a scientific assessment"

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
# remotes::install_github('Iraices/PrecisePvsBoundedP')
```

## Example

This example does the aluminium exposure assessment by precise
probability derived by Bayesian analysis.

First, let us estimate the frequency of exceeding the safety threshold
for a random child

``` r
library(ppvsbp)
## basic example code
TWI_pp_random_child <- unc_analysis_assessment(niter_ale = 5000, niter_epi = 5000, threshold = 1,
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

## Expected frequency of exceeding the safety threshold
TWI_pp_random_child$expected_frequency_exceeding
#> [1] 0.00967968

## Highest posterior density interval of the frequency of exceeding the safety threshold
TWI_pp_random_child$hdi_frequency_exceeding
#>  lower  upper 
#> 0.0034 0.0172 
#> attr(,"credMass")
#> [1] 0.95
```

Second, let us estimate the frequency of exceeding the safety threshold
for a high consumer child. Note, the argument `percentile_ale` has
changed `percentile_ale = 95`.

``` r
  TWI_pp_high_consumer_child <- unc_analysis_assessment(niter_ale = 5000, niter_epi = 5000, threshold = 1,
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

## Expected probability of exceeding the safety threshold
TWI_pp_high_consumer_child$expected_frequency_exceeding
#> [1] 0.06332524

## Highest posterior density interval of the probability of exceeding the safety threshold
TWI_pp_high_consumer_child$hdi_frequency_exceeding
#>  lower  upper 
#> 0.0176 0.1210 
#> attr(,"credMass")
#> [1] 0.95
```

We can now visualize the results. Epistemic uncertainty has been
characterized by a full probability distribution.

``` r
 ## A random children
  graph_pp(frequency_exceeding = TWI_pp_random_child$frequency_exceeding)
```

<img src="man/figures/README-fig1-1.png" width="70%" />

``` r
    
 ## A high consumer child
  graph_pp(frequency_exceeding = TWI_pp_high_consumer_child$frequency_exceeding)
```

<img src="man/figures/README-fig1-2.png" width="70%" />

``` r
 ## both graphs
 graph_pp_both(frequency_exceeding_random_child = TWI_pp_random_child$frequency_exceeding, 
               frequency_exceeding_high_consumer_child = TWI_pp_high_consumer_child$frequency_exceeding)
```

<img src="man/figures/README-fig2-1.png" width="85%" /> Now, let us
estimate the frequency of exceeding the safety threshold by bounded
probability derived by robust Bayesian analysis.

First, let us consider the case of a random child

``` r
  ## A random child
  lower_bound_random_child <- bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = FALSE, 
                                            lower_parameters  = c(1, -5, -20), 
                                            upper_parameters  = c(6, 1, -10),
                                            niter_ale = 2000, niter_epi = 2000, threshold = 1, percentile_ale = NULL,
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
  

  
  ## A random child
  upper_bound_random_child <- bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = TRUE, 
                                           lower_parameters  = c(1, -5, -20), 
                                           upper_parameters  = c(6, 1, -10),
                                           niter_ale = 2000, niter_epi = 2000, threshold = 1, 
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

Now, let us consider the case of a high consumer child.

``` r
  ## A high consumer child
  lower_bound_high_consumer_child <- bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = FALSE, 
                                                   lower_parameters  = c(1, -5, -20), 
                                                   upper_parameters  = c(6, 1, -10),
                                                   niter_ale = 2000, niter_epi = 2000, threshold = 1, 
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
  upper_bound_high_consumer_child <- bound_frequency_exceeding_bp(obj_func_bp = obj_func_bp, maximize = TRUE, 
                                                    lower_parameters  = c(1, -5, -20), 
                                                    upper_parameters  = c(6, 1, -10),
                                                    niter_ale = 2000, niter_epi = 2000, threshold = 1, 
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

In the case of bounded probability derived by robust Bayesian analysis,
epistemic uncertainty has been characterized by a probabilty box. The
results of both cases can be visualized individualy or together.

Individual cases (a random child and a high consumer child)

``` r
 ## All children
 graph_bp(lower_points = lower_bound_random_child$opt_freq$frequency_exceeding, 
          upper_points = upper_bound_random_child$opt_freq$frequency_exceeding)
```

<img src="man/figures/README-fig3-1.png" width="70%" />

``` r
    
 ## A high consumer child
 graph_bp(lower_points = lower_bound_high_consumer_child$opt_freq$frequency_exceeding, 
          upper_points = upper_bound_high_consumer_child$opt_freq$frequency_exceeding)
```

<img src="man/figures/README-fig3-2.png" width="70%" />

Both cases together (a random child and a high consumer child)

``` r
 ## Both graphs
  graph_bp_both(lower_points_random_child = lower_bound_random_child$opt_freq$frequency_exceeding, 
                upper_points_random_child = upper_bound_random_child$opt_freq$frequency_exceeding,
                lower_points_high_consumer_child = lower_bound_high_consumer_child$opt_freq$frequency_exceeding, 
                upper_points_high_consumer_child = upper_bound_high_consumer_child$opt_freq$frequency_exceeding)
```

<img src="man/figures/README-fig4-1.png" width="70%" />

As an example: Let us assume that a decision maker wants to know if the
frequency of exceeding the safety threshold is low. Let us set 0.05, as
an acceptable level of frequency of exceeding.

Thus, the decision maker is interested in \[P(h > 0.05)\] is low.

In the precise probability case, the probability that the frequency of
exceeding the safety threshold of a random child exceeds the acceptable
level is

\[P(h >= 0.05) = 1 - P(h <= 0.05) = \text{prob}\]

``` r

index =  which(sort(TWI_pp_random_child$frequency_exceeding)>= 0.05)[1]

val <- function(index, frequency_exceeding){
  if(is.na(index)){
  bound <- 0
  }
  else{
  bound <- 1 - index / length(frequency_exceeding)
  }
  bound
}

prob = val(index = index, frequency_exceeding = TWI_pp_random_child$frequency_exceeding)
prob
#> [1] 0
```

In the bounded probability case, the probability that the frequency of
exceeding the safety threshold of a random child exceeds the acceptable
level is

\(P(h >= 0.05) = 1 - P(h <= 0.05)\)

\(lower_bound <= 1 - P(h <= 0.05) <= upper_bound\)

``` r

index_lower <- which(sort(lower_bound_random_child$opt_freq$frequency_exceeding)>= 0.05)[1]
index_upper <- which(sort(upper_bound_random_child$opt_freq$frequency_exceeding)>= 0.05)[1] 

lower_bound = val(index = index_lower, frequency_exceeding = lower_bound_random_child$opt_freq$frequency_exceeding)
upper_bound = val(index = index_upper, frequency_exceeding = upper_bound_random_child$opt_freq$frequency_exceeding)

lower_bound
#> [1] 0
upper_bound
#> [1] 0.6515
```
