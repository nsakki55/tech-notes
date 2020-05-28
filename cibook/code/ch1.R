library(tidyverse)
email_data <- read_csv("http://www.minethatdata.com/Kevin_Hillstrom_MineThatData_E-MailAnalytics_DataMiningChallenge_2008.03.20.csv")
email_data

male_df <- email_data %>%
  filter(segment != 'Womens E-Mail') %>%
  mutate(treatment = if_else(segment == 'Mens E-Mail', 1, 0))

male_df

summary_by_segment <- male_df %>%
  group_by(treatment) %>%
  summarise(conversion_rate = mean(conversion),
            spend_mean = mean(spend),
            count = n())

summary_by_segment

mens_mail <- male_df %>%
  filter(treatment == 1) %>%
  pull(spend)

mens_mail

no_meil <- male_df %>%
  filter(treatment == 0) %>%
  pull(spend)

no_meil

rct_test <- t.test(mens_mail, no_meil, var.equal = TRUE)
rct_test


set.seed(1)

obs_rate_c <- 0.5
obs_rate_t <- 0.5

biased_data <- male_df %>%
  mutate(obs_rate_c = 
           ifelse((history > 300) | (recency < 6) | (channel == 'Multichannnel'), obs_rate_c, 1),
        obs_rate_t = 
            ifelse((history > 300) | (recency < 6) | (channel == 'Multichannnel'), 1, obs_rate_t),
        random_number = runif(n = NROW(male_df))) %>%
  filter((treatment == 0 & random_number < obs_rate_c) | (treatment == 1 & random_number < obs_rate_t))

biased_data

summary_by_segment_biased <- biased_data %>%
  group_by(treatment) %>%
  summarise(conversion_rate = mean(conversion),
            spend_mean = mean(spend),
            count = n())

summary_by_segment_biased


mens_mail_biased <- biased_data %>%
  filter(treatment == 1) %>%
  pull(spend)

no_mail_biased <- biased_data %>%
  filter(treatment == 0) %>%
  pull(spend)

no_mail_biased

rct_test_biased <- t.test(mens_mail_biased, no_mail_biased, var.equal = TRUE)
rct_test_biased

biased_reg <- lm(data = biased_data, formula = spend ~ treatment + history)
summary(biased_reg)


library(broom)
biased_reg_coef <- tidy(biased_reg)
biased_reg_coef

rct_reg <- lm(data = male_df, formula = spend ~ treatment)
rct_reg_coef <- summary(rct_reg) %>% tidy()
rct_reg_coef

nonrct_reg <- lm(data = biased_data, formula = spend ~ treatment)
nonrct_reg_coef <- summary(nonrct_reg) %>% tidy()
nonrct_reg_coef

nonrct_mreg <- lm(data = biased_data, formula = spend ~ treatment + recency + channel + history)
nonrct_mreg_coef <- tidy(nonrct_mreg)
nonrct_mreg_coef

formula_vec <- c(spend ~ treatment + recency + channel,
                 spend ~ treatment + recency + channel +history,
                 history ~ treatment + channel + recency)
names(formula_vec) <- paste("reg", LETTERS[1:3], sep="_")
formula_vec

models <- formula_vec %>%
  enframe(name='model_index', value='formula')

models

df_models <- models %>%
  mutate(model=map(.x = formula, .f = lm, data=biased_data)) %>%
  mutate(lm_result = map(.x = model, .f = tidy))
df_models

df_results <- df_models %>%
  mutate(formula = as.character(formula)) %>%
  select(formula, model_index, lm_result) %>%
  unnest(cols = c(lm_result))
df_results

treatment_coef <- df_results %>%
  filter(term == 'treatment') %>%
  pull(estimate)
treatment_coef

history_coef <- df_results %>%
  filter(model_index == 'reg_B') %>%
  filter(term == 'history') %>%
  pull(estimate)
history_coef

OVB <- history_coef * treatment_coef[3]
coef_gap <- treatment_coef[1] - treatment_coef[2]
OVB
coef_gap

