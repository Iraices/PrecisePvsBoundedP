update_normal_gamma <- function(suff_stat_data, mu0, v0, alpha0, beta0, sufficient_statistics){
  
  if(sufficient_statistics == TRUE){
    n <- suff_stat_data[['sample_size']]
    m <- suff_stat_data[['sample_mean']]
    S2 <- suff_stat_data[['sample_sd']]^2  # sample variance
  }
  else{
    n <- length(suff_stat_data)
    m <- mean(suff_stat_data)
    S2 <- var(suff_stat_data)
  }
  
  v_n <-  v0 + n
  alpha_n <- alpha0 + n/2
  
  mu_n <- (v0 * mu0 + n * m ) / (v0 + n)
  beta_n <- beta0 + 1/2*S2*(n - 1) + (n*v0/(v0 + n) * (m - mu0)^2)
  
  output <- list(param = list(prior = list(mu = mu0, v = v0, alpha = alpha0, beta = beta0),
                              posterior = list(mu = mu_n, v = v_n , alpha = alpha_n, beta = beta_n)))
  
  return(output)
}

################################################################################

generate_samples_normal_gamma <- function(niter_ale, post){
  
  precision <- rgamma(1, shape = post$param$posterior$alpha, rate = post$param$posterior$beta)  # precision
  sigma_n <- (1/sqrt(precision))  # standard deviation
  mu <- rnorm(1,post$param$posterior$mu, sigma_n / sqrt(post$param$posterior$v))
  
  
  gen_sample <- rlnorm(niter_ale, meanlog = mu, sdlog = sigma_n)
  
  output <- list(gen_sample = gen_sample)
  
  return(output)
}

################################################################################

update_bernoulli_beta <- function(suff_stat_data, alpha0 = 1, beta0 = 1){
  n_non_consumer <- suff_stat_data[['non_consumer_sample_size']]
  n_consumer <- suff_stat_data[['consumer_sample_size']]
  
  alpha_n <- alpha0 + n_consumer
  beta_n <- beta0 + n_non_consumer
  
  output <- list(param = list(prior = list(alpha = alpha0, beta = beta0),
                              posterior = list(alpha = alpha_n, beta = beta_n)))
  
  return(output)
}

################################################################################

quantify_uncertainty_pp_change_eke <- function(vals, probs){
  l <- length(vals)
  change_cocoa_dist <- SHELF::fitdist(vals = vals[2:(l-1)], probs = probs[2:(l-1)], lower = min(vals), upper = max(vals))
  
  return(normal_parameters = c(mu_EKE = change_cocoa_dist$Normal$mean, sigma_EKE = change_cocoa_dist$Normal$sd))
}

################################################################################

combine_uncertainty_mod <- function(gen_data_concentration, gen_data_consumption,
                                gen_data_EKE, threshold, niter_ale){
  
  gen_data_concentration <- matrix(unlist(gen_data_concentration), ncol = 7, nrow = niter_ale)
  gen_data_consumption <- matrix(unlist(gen_data_consumption), ncol = 7, nrow = niter_ale)
  
  weekly_intake <- rowSums((1 + (gen_data_EKE/ 100) )* (gen_data_consumption * 0.007) * gen_data_concentration)
  
  frequency_exceeding_wi <- mean(weekly_intake > threshold)
  
  return(list(weekly_intake = weekly_intake, frequency_exceeding_wi = frequency_exceeding_wi))
}

################################################################################

vals <- c(-30, -15, -5, 7.5, 20)
probs = c(0.01, 0.25,0.5, 0.75,0.99)
fit_normal_dist_EKE <- quantify_uncertainty_pp_change_eke(vals, probs)
#gen_data_EKE <- rnorm(1, fit_normal_dist_EKE[['mu_EKE']], fit_normal_dist_EKE[['sigma_EKE']])


post_concentration <-  lapply(data_assessment$log_concentration_ss_data, update_normal_gamma, 
                              mu0 = 3.5, v0 = 5, alpha0 = 1, beta0 = 1, 
                              sufficient_statistics = TRUE)

#gen_data_concentration <-  lapply(post_concentration, generate_samples_normal_gamma, niter_ale = 100)



post_consumption <- lapply(data_assessment$log_consumption_ss_data, update_normal_gamma,
                           mu0 = -3, v0 = 5, alpha0 = 1, beta0 = 1, 
                           sufficient_statistics = TRUE)

#gen_data_consumption_prime <-  lapply(post_consumption, generate_samples_normal_gamma, niter_ale = 100)

param_consumption_event <-  lapply(data_assessment$consumers_info_sample_size, update_bernoulli_beta, alpha0 = 1, beta0 = 1)

prob_consumption_event <- vector('list', 7)

####################################################
## 2D distribution weekly intake

exposure_scenario = 'Null' # 'av', 'perc_95'
threshold = 1
niter_ale = 5000
niter_epi = 20

weekly_intake = matrix(0, nrow = niter_ale, ncol = niter_epi)

for(i in 1:niter_epi){
  
  gen_data_EKE = rnorm(1, mean =  fit_normal_dist_EKE[[1]], sd =  fit_normal_dist_EKE[[2]])
  
  gen_data_concentration <-  lapply(post_concentration, generate_samples_normal_gamma, niter_ale = niter_ale)
  
  gen_data_consumption_prime <-  lapply(post_consumption, generate_samples_normal_gamma, niter_ale = niter_ale)
  
  gen_data_consumption <- gen_data_consumption_prime
  
  for(k in 1:7){
    
    prob_consumption_event[[k]] <-  rbeta(1,shape1 = param_consumption_event[[k]]$param$posterior$alpha,
                                          shape2 = param_consumption_event[[k]]$param$posterior$beta)
    
    gen_data_consumption[[k]]$gen_sample  <- gen_data_consumption_prime[[k]]$gen_sample * rbinom(n = niter_ale, size = 1, prob = prob_consumption_event[[k]])
    
    
    if(exposure_scenario == 'perc_95'){
      gen_data_consumption[[k]]$gen_sample <- rep(quantile(gen_data_consumption[[k]]$gen_sample, probs = 0.95), niter_ale)
      
    }
    else if(exposure_scenario == 'av'){
     gen_data_consumption[[k]]$gen_sample <- rep(mean(gen_data_consumption[[k]]$gen_sample), niter_ale)
    }
    else{
      gen_data_consumption[[k]]$gen_sample
    }
  }
  
  a <- combine_uncertainty_mod(gen_data_concentration =  gen_data_concentration, gen_data_consumption = gen_data_consumption,
                               gen_data_EKE = gen_data_EKE, threshold =  threshold, niter_ale = niter_ale)
  
  weekly_intake[,i] <- a$weekly_intake
  
}

# plot 2D distribution for weekly intake (the data is for column)
plot(sort(weekly_intake[,1]), (1:length(weekly_intake[,1]))/ length(weekly_intake[,1]), 
     xlab = 'weekly_intake', ylab = 'cdf', xlim= c(0,1.2), type = 'l', col = 'lightgrey')
for(i in 2:niter_epi){
  lines(sort(weekly_intake[,i]), (1:length(weekly_intake[,1]))/ length(weekly_intake[,1]), col = 'lightgrey')
}
abline(h = 0.95, col = 'red')
abline(v = 1, col = 'black')

############################################
## using ggplot
## 2D distribution for weekly intake

for(i in 2:niter_epi){
  lines(sort(weekly_intake[,i]), (1:length(weekly_intake[,1]))/ length(weekly_intake[,1]), col = 'lightgrey')
}


data_plot <- data.frame(weekly_intake)
ncol = dim(data_plot)[2]
for(i in 1:ncol){
  data_plot[,i] <- sort(data_plot[,i])
}

# data wide format
pp = (1:length(data_plot[,1]))/ length(data_plot[,1])
data_plot <- cbind(data_plot, pp)

# data long format
data_plot_long <- gather(data_plot, group, values, 
                    X1:X20, factor_key = TRUE)

ggplot() +
  geom_line(data = data_plot_long, mapping = aes(group = group, x=values, y=pp), size =  0.4, color="grey", show.legend = FALSE) +
  geom_hline(yintercept = 0.95, col = 'red', size = 0.4) + 
  geom_vline(xintercept = 1, col = 'black', size = 0.4) + 
  coord_cartesian(expand = FALSE) +
  xlim(0, 1.2) +
  ylim(0,1.05) +
  labs(
    title = "",
    x = "weekly intake",
    y = "cdf") +
  theme_bw() +
  theme(title = element_text(size = 1), axis.title = element_text(size = 5), axis.text = element_text(size = 5),
        legend.title = element_text(size = -2),
        legend.text = element_text(size = 4),
        legend.justification =  'bottom', legend.position = 'None')

ggsave('2d_weekly_intake.png', width = 2.25, height = 2, units = 'in')


#######################################################
## histogram

WI_95 <- unlist(lapply(1:ncol,function(i){quantile(data_plot[,i], probs = 0.95)}))

WI_95_plot <- data.frame(WI_95)

ggplot(data = WI_95_plot, aes(x= WI_95)) + 
  geom_histogram(bins = 5, col = 'grey', fill="lightgrey", size = 0.4) + 
  labs(
    title = "",
    x = "95th weekly intake",
    y = "") + 
  theme_bw() +
  theme(title = element_text(size = 1), axis.title = element_text(size = 5), axis.text = element_text(size = 5),
        legend.title = element_text(size = -2),
        legend.text = element_text(size = 4),
        legend.justification =  'bottom', legend.position = 'None')

ggsave('95perc_hist_weekly_intake.png', width = 2.25, height = 2, units = 'in')

