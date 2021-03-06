## Different ways to represent uncertainty at the variable and parameter levels
## This is the script for Figure 1 Title
## Example Body weight

library(tidyverse)
library(tidybayes)
library(cowplot)

######################################################
## Case 1 - 2D distribution
## Variable level


df <- data.frame(x = rnorm(n = 10, mean = 20, sd = sqrt(15)))

sample_param <- function(data, sigma2, mu_0, sigma2_0){
## Generates a parameter from the posterior distribution and
## computes the hyperparameters of the posterior distribution for a conjugate normal model with known variance.
##
## The model is described as follows
## Let X_1, ., X_n be a sample from a N(mu, sigma2) distribution, with sigma2 known. 
## We assume a prior distribution on mu; mu ~ N(mu_0, sigma2_0). 
## The posterior distribution is then mu|X_1, ...m X_n ~ N(mu_n, sigma2_n) with
##
## Arguments
## data      a data frame with observed data
## sigma2    the variance of the data
## mu_0      hyperparameter, mean of the prior distribution with unknown parameter mu
## sigma2_0  hyperparameter, variance of the prior distribution with unknown parameter mu
##  
## Output
## mu        a generated parameter from the posterior distribution
## sigma2    the variance of the data
## mu_n      hyperparameter, mean of the posterior distribution with unknown parameter mu
## sigma2_n  hyperparameter, variance of the posterior distribution with unknown parameter mu
## mu_0      hyperparameter, mean of the prior distribution with unknown parameter mu
## sigma2_0  hyperparameter, variance of the prior distribution with unknown parameter mu
  
  n <- length(data)
  
  sigma2_n <- 1/((1 / sigma2_0) + (n/sigma2))
  mu_n <- sigma2_n *((mu_0 / sigma2_0) + sum(data)/sigma2)
  
  mu <- rnorm(1,mean = mu_n, sd = sqrt(sigma2_n))
  return(list(mu = mu, sigma2 = sigma2, 
              mu_n = mu_n, sigma2_n = sigma2_n,
              mu_0 = mu_0, sigma2_0 = sigma2_0))
}



#Update the parameter (posterior distribution)
ndraws <- 15 ## number of spaghetti straws
sample_param_df <- map_dfr(seq(ndraws), 
                           ~sample_param(data = df$x,
                                         sigma2 = 10, mu_0 = 25, sigma2_0 = 5)) %>% 
  tibble::rownames_to_column(var = "grp")


# 2 d plots 
df_ale <- sample_param_df  %>% 
  mutate(q=map2(mu, sqrt(sigma2), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                          vals=qnorm(qs, mean=.x, sd=.y),
                                          ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

## Posterior predictive

sample_param_df_2 <- map_dfr(1, 
                             ~sample_param(data = df$x,
                                           sigma2 = 10, mu_0 = 25, sigma2_0 = 5)) 


df_ale_pred <- sample_param_df_2  %>% 
  mutate(q=map2(mu_n, sqrt(sigma2 + sigma2_n), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                                       vals=qnorm(qs, mean=.x, sd=.y),
                                                       ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

## Plot 2D distribution and posterior predictive distribution
ggplot() +
  geom_line(data = df_ale, mapping = aes(group = grp, x=vals, y=qs), size =  0.4, color="lightgray", show.legend = FALSE) +
  geom_line(data = df_ale %>% filter(grp == 1), aes(x = vals, y = qs, group = NULL, color = "lightgray"), size = 0.4, alpha = 0.2) + ## Workaround for the legend
  geom_line(data = df_ale_pred, aes(x = vals, y = qs, group = NULL, color = "black"),size = 0.6) + ## adds the cdf of the posterior predictive distribution
  coord_cartesian(expand = FALSE) +
  scale_colour_manual(name = 'nam', values = c("black","lightgray"),
                      labels = c('Predictive distribution','2D distribution')) +
  xlim(5, 41) +
  ylim(0,1.05) +
  labs(
    title = "",
    x = "body weight",
    y = "cdf") +
  theme_bw() +
  theme(title = element_text(size = 1), axis.title = element_text(size = 5), axis.text = element_text(size = 5),
        legend.title = element_text(size = -2),
        legend.text = element_text(size = 4),
        legend.justification =  'bottom', legend.position = c(0.74,0.05))

## var_2d_postpred
ggsave('var_2d_postpred_1.png', width = 2.25, height = 1.82, units = 'in')

##############################################################################
######################
## Parameter levels (mu)

# 2d plots  - posterior mu 
df_epi <- sample_param_df  %>% 
  mutate(q=map2(mu_n, sqrt(sigma2_n), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                              vals=qnorm(qs, mean=.x, sd=.y),
                                              ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

# 2d plots - prior mu
df_epi_prior <- sample_param_df  %>% 
  mutate(q=map2(mu_0, sqrt(sigma2_0), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                              vals=qnorm(qs, mean=.x, sd=.y),
                                              ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

## cdf plot - prior and posterior mu 
graph_prior_posterior_mu <- function(mu_0_vals, mu_n_vals, qs){
  
  # data wide format
  data_plot <- data.frame(mu_0_vals = sort(mu_0_vals), 
                          mu_n_vals = sort(mu_n_vals), 
                          qs = qs)
  
  # data long format
  data_plot <- gather(data_plot, group, values, 
                      mu_0_vals, mu_n_vals, factor_key = TRUE)
  
  p <- data_plot %>% 
    ggplot(aes(x = values, y = qs, group = group, linetype = group)) +
    geom_line() +
    scale_linetype_manual(name = '', values = c('dashed','solid'), labels = c( 'Prior','Posterior')) +
    xlim(10, 40) + 
    labs(
      title = "",
      x = expression(mu),
      y = "cdf") +
    theme_bw() +
    theme(title = element_text(size = 1), 
          axis.title = element_text(size = 5), axis.text = element_text(size = 5),
          legend.title = element_text(size = -0.5),
          legend.text = element_text(size = 4),
          legend.justification =  'bottom', legend.position = c(0.73,0.05))
  p
}

# extract one iteration from df_ale (for plotting)
df_epi_posterior_mu_n  <- df_epi[df_epi$grp == 1,]
df_epi_prior_mu_0  <- df_epi_prior[df_epi_prior$grp == 1,]

graph_prior_posterior_mu(mu_0_vals =  df_epi_prior_mu_0$vals, 
                                               mu_n_vals =  df_epi_posterior_mu_n$vals, qs = df_epi_prior_mu_0$qs)

## param_2d_postpred
ggsave('param_2d_postpred_1.png', width = 2.25, height = 1.82, units = 'in')

##################################################################################
### Case 3 - P-boxes

graph_bp <- function(lower_points, upper_points, xlim){
  
  n_values <- length(lower_points)
  l_points <- rep(0,n_values)
  u_points <- rep(0,n_values)
  
  for(i in 1:n_values){
    l_points[i] <- min(lower_points[i],upper_points[i]) 
    u_points[i] <- max(lower_points[i],upper_points[i])
  }
  
  # data wide format
  data_plot_wide <- data.frame(l_points = sort(l_points), 
                               u_points = sort(u_points), 
                               cdf = c(1:n_values / n_values))
  
  app_data_plot <- data.frame(l_points= c(min(data_plot_wide$l_points),max(data_plot_wide$u_points)),
                              u_points = c(min(data_plot_wide$l_points),max(data_plot_wide$u_points)),
                              cdf=c(0,1))
  
  data_plot <- rbind(data_plot_wide, app_data_plot)
  
  
  # data long format
  data_plot <- gather(data_plot, bound, values, l_points, u_points, factor_key = TRUE)
  
  
  p <- data_plot %>% 
    ggplot(aes(x = values, y = cdf, col = bound)) +
    geom_line(size = 0.5) +
    scale_color_manual(labels = c('Upper', 'Lower'), values = c('red', 'blue')) +
    guides(color = guide_legend("Bounds")) +
    xlim(xlim[1], xlim[2]) +
    labs(
      title = "",
      x = "body weight",
      y = "cdf")
  p + theme_bw() + theme(title = element_text(size = 1), axis.title = element_text(size = 5), axis.text = element_text(size = 5), 
                         legend.title = element_text(size = 5), legend.text = element_text(size = 4),
                         legend.justification =  'bottom', legend.position = c(0.83,0.03))
}

## Variable level 
## Normal([mu_1, mu_2],sigma2)
mu_1 <- 20
mu_2 <- 30

sample_param_df_3_mu0_1 <- data.frame(mu = 20, sigma = sqrt(10))

sample_param_df_3_mu0_2 <- data.frame(mu = 30, sigma = sqrt(10))

df_ale_3_mu0_1 <- sample_param_df_3_mu0_1  %>% 
  mutate(q=map2(mu, sigma, ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                   vals=qnorm(qs, mean=.x, sd=.y),
                                   ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

df_ale_3_mu0_2 <- sample_param_df_3_mu0_2  %>% 
  mutate(q=map2(mu, sigma, ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                   vals=qnorm(qs, mean=.x, sd=.y),
                                   ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)


pbox_plot <- graph_bp(lower_points = df_ale_3_mu0_1$vals, upper_points = df_ale_3_mu0_2$vals, xlim = c(10,40))
pbox_plot

## var_pbox
png("var_pbox_1.png", width = 2.25, res = 300, height = 1.82, units = 'in')
pbox_plot
dev.off()

# Parameter level (interval)

sample_param_df_3_mu0 <- data.frame(min = sample_param_df_3_mu0_1$mu, max = sample_param_df_3_mu0_2$mu)

data_sample_param_df_3_mu0_param_pbox <- data.frame(x = c(sample_param_df_3_mu0_1$mu, sample_param_df_3_mu0_1$mu, sample_param_df_3_mu0_2$mu,
                                                          sample_param_df_3_mu0_1$mu, sample_param_df_3_mu0_2$mu, sample_param_df_3_mu0_2$mu), 
                                                    y = c(0,1,1,0,0,1),
                                                    grp = c(1,1,1,2,2,2))

pp <- data_sample_param_df_3_mu0_param_pbox %>%
  ggplot(aes(x = x, y = y, group = grp, col = as.factor(grp))) +
  geom_line(size = 0.5) +
  scale_color_manual(labels = c('Upper', 'Lower'), values = c('red', 'blue')) +
  guides(color = guide_legend("Bounds")) +
  xlim(10, 41) +
  ylim(0,1) + 
  labs(
    title = "",
    x = expression(mu),
    y = "cdf")
pp + theme_bw() + theme(title = element_text(size = 1), axis.title = element_text(size = 5), axis.text = element_text(size = 5), 
                        legend.title = element_text(size = 5), legend.text = element_text(size = 4),
                        legend.justification =  'bottom', legend.position = c(0.80,0.1))

## param_pbox
ggsave('param_pbox_1.png', width = 2.25, height = 1.82, units = 'in')

#######################################################################################
### Case 4 - Set of priors 
## Variable level 
# A normal-normal conjugate model
# X|\mu   ~ N(\mu, \simga2)   (Likelihood)
# \mu     ~ N(\mu_0, \sigma2_0)  (Prior distribution)   where  \mu_0 \in [\mu_01, \mu_02]

# \mu|X   ~ N(\mu_n, \sigma2_n)  (Posterior distribution) where \mu_n \in [\mu_n1, \mu_n2 ]

# x_new|X ~ N(\mu_n, \sigma2_n + sigma2) (Posterior predictive distribution) where \mu_n \in [\mu_n1, \mu_n2 ]

mu_01 <- 20
mu_02 <- 30
sigma2_0 <- 5

post1 <- sample_param(data = df$x, sigma2 = 10, mu_0 = mu_01, sigma2_0 = 5)

post2 <- sample_param(data = df$x, sigma2 = 10, mu_0 = mu_02, sigma2_0 = 5)


## Posterior predictive dist
sample_param_df_3_mu_n1 <- data.frame(mu_n = post1$mu_n, sigma2_n = post1$sigma2_n, sigma2 = post1$sigma2,
                                      mu_01 = post1$mu_0, sigma2_0 = post1$sigma2_0)

sample_param_df_3_mu_n2 <- data.frame(mu_n = post2$mu_n, sigma2_n = post2$sigma2_n, sigma2 = post2$sigma2,
                                      mu_02 = post2$mu_0, sigma2_0 = post2$sigma2_0)

# Parameter level (set of priors)

## posterior mu

df_epi_mu_n1 <- sample_param_df_3_mu_n1   %>% 
  mutate(q=map2(mu_n, sqrt(sigma2_n), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                              vals=qnorm(qs, mean=.x, sd=.y),
                                              ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

df_epi_mu_n2 <- sample_param_df_3_mu_n2  %>% 
  mutate(q=map2(mu_n, sqrt(sigma2_n), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                              vals=qnorm(qs, mean=.x, sd=.y),
                                              ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)


## prior mu
df_epi_mu_01 <- sample_param_df_3_mu_n1   %>% 
  mutate(q=map2(mu_01, sqrt(sigma2_0), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                               vals=qnorm(qs, mean=.x, sd=.y),
                                               ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

df_epi_mu_02 <- sample_param_df_3_mu_n2  %>% 
  mutate(q=map2(mu_02, sqrt(sigma2_0), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                               vals=qnorm(qs, mean=.x, sd=.y),
                                               ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)


## p-box plot posterior and prior mu
graph_bp_both <- function(lower_points_mu_0, upper_points_mu_0,
                          lower_points_mu_n, upper_points_mu_n, qs){
  
  n_values <- length(lower_points_mu_0)
  l_points_mu_0 <- rep(0,n_values)
  u_points_mu_0 <- rep(0,n_values)
  l_points_mu_n <- rep(0,n_values)
  u_points_mu_n <- rep(0,n_values)
  
  for(i in 1:n_values){
    l_points_mu_0[i] <- min(lower_points_mu_0[i],upper_points_mu_0[i])
    u_points_mu_0[i] <- max(lower_points_mu_0[i],upper_points_mu_0[i])
    
    l_points_mu_n[i] <- min(lower_points_mu_n[i],upper_points_mu_n[i])
    u_points_mu_n[i] <- max(lower_points_mu_n[i],upper_points_mu_n[i])
  }
  
  # data wide format
  data_plot_wide <- data.frame(l_points_mu_0 = sort(l_points_mu_0),
                               u_points_mu_0 = sort(u_points_mu_0),
                               l_points_mu_n = sort(l_points_mu_n),
                               u_points_mu_n = sort(u_points_mu_n),
                               cdf = qs)
  
  app_data_plot <- data.frame(l_points_mu_0 = c(min(data_plot_wide$l_points_mu_0),
                                                max(data_plot_wide$u_points_mu_0)),
                              u_points_mu_0 = c(min(data_plot_wide$l_points_mu_0),
                                                max(data_plot_wide$u_points_mu_0)),
                              l_points_mu_n = c(min(data_plot_wide$l_points_mu_n),
                                                max(data_plot_wide$u_points_mu_n)),
                              u_points_mu_n = c(min(data_plot_wide$l_points_mu_n),
                                                max(data_plot_wide$u_points_mu_n)),
                              cdf = c(0,1))
  
  data_plot <- rbind(data_plot_wide, app_data_plot)
  
  
  # data long format
  data_plot <- gather(data_plot, "bound", "values", 
                      .data$l_points_mu_0, .data$u_points_mu_0,
                      .data$l_points_mu_n, .data$u_points_mu_n, factor_key = TRUE)
  
  p_rba <- data_plot %>%
    ggplot(aes(x = .data$values, y = .data$cdf, group = .data$bound, 
               linetype = .data$bound)) +
    geom_line(aes(color = .data$bound), size = 0.5) +
    xlim(5,41) +
    scale_linetype_manual(values = c('dashed', 'dashed','solid', 'solid' ),
                          labels = c('Prior', 'Prior',
                                     'Posterior','Posterior'),
                          name = '') +
    scale_color_manual(values = c('red', 'blue','red', 'blue'),
                       labels = c('Upper_bound_prior', 'Lower_bound_prior',
                                  'Upper_bound_posterior','Lower_bound_posterior'),
                       name = 'Bounds') +
    labs(
      title = "",
      x = expression(mu),
      y = "cdf") +
    theme_bw() +
    theme(title = element_text(size = 1),
          axis.title = element_text(size = 5), axis.text = element_text(size = 5),
          legend.title = element_text(size = 5),
          legend.text = element_text(size = 4),
          #legend.position = c(0.8,0.25),
          legend.position = "none")
  p_rba
}

# param_rba 
plot_rba_mu <- graph_bp_both(lower_points_mu_0 = df_epi_mu_01$vals, 
                             upper_points_mu_0 = df_epi_mu_02$vals,
                             lower_points_mu_n = df_epi_mu_n1$vals, 
                             upper_points_mu_n = df_epi_mu_n2$vals, qs = df_epi_mu_01$qs)
plot_rba_mu 

## param_rba
png("param_rba_1.png", width = 2.25, res = 300, height = 1.82, units = 'in')
plot_rba_mu 
dev.off()

##########################################################################
## Variable rba 
#Update the parameter (posterior distribution)  

ndraws <- 10 ## number of spaghetti straws
## prior mu_0 = 20
sample_param_df_mu_01 <- map_dfr(seq(ndraws), 
                                 ~sample_param(data = df$x,
                                               sigma2 = 10, mu_0 = 20, sigma2_0 = 5)) %>% 
  tibble::rownames_to_column(var="grp")


# 2 d plots 
df_ale_mu_01 <- sample_param_df_mu_01 %>% 
  mutate(q=map2(mu, sqrt(sigma2), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                          vals=qnorm(qs, mean=.x, sd=.y),
                                          ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

# prior mu_0 = 30
sample_param_df_mu_02 <- map_dfr(seq(ndraws), 
                                 ~sample_param(data = df$x,
                                               sigma2 = 10, mu_0 = 30, sigma2_0 = 5)) %>% 
  tibble::rownames_to_column(var="grp")


# 2 d plots 
df_ale_mu_02 <- sample_param_df_mu_02 %>% 
  mutate(q=map2(mu, sqrt(sigma2), ~tibble(qs=c(0.001, seq(0.01, 0.99, by=0.01), 0.999),
                                          vals=qnorm(qs, mean=.x, sd=.y),
                                          ds=dnorm(vals, mean=.x, sd=.y)))
  ) %>% unnest(q)

# plot 2d distribution for mu_01 and mu_02
p_cdf_mu_02 <- df_ale_mu_02%>% 
  ggplot(aes(group=grp, x=vals, y=qs)) +
  geom_line(size=0.5, alpha=0.1, color="blue")+
  geom_line(data = df_ale_mu_01, aes(group=grp, x=vals, y=qs),
            size=0.5, alpha=0.1, color="red") +
  coord_cartesian(expand = FALSE) +
  xlim(5, 41) +
  ylim(0,1.05) + 
  labs(
    title = "",
    x = "body weight",
    y = "cdf"
  ) + 
  theme_bw() +
  theme(title = element_text(size = 1), axis.title = element_text(size = 5), axis.text = element_text(size = 5))
p_cdf_mu_02 

## variable rba
ggsave('var_rba_1.png', width = 2.25, height = 1.82, units = 'in')