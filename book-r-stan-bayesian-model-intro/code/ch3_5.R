library(rstan)
library(bayesplot)
library(brms)
# 計算の高速化
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

file_beer_sales_2 <- read.csv('data/3-2-1-beer-sales-2.csv')

simple_lm_brms <- brm(
  formula = sales ~ temperature,
  family = gaussian(link = 'identity'),
  data = file_beer_sales_2,
  seed = 1
)

fix_Mac <- function(sm) {
  stopifnot(is(sm, "stanmodel"))
  dso_last_path <- sm@dso@.CXXDSOMISC$dso_last_path
  CLANG_DIR <- tail(n = 1, grep("clang[456789]", 
                                x = list.dirs("/usr/local", recursive = FALSE), 
                                value = TRUE))
  if (length(CLANG_DIR) == 0L) stop("no clang from CRAN found")
  LIBCPP <- file.path(CLANG_DIR, "lib", "libc++.1.dylib")
  if (!file.exists(LIBCPP)) stop("no unique libc++.1?.dylib found")
  Rv <- R.version
  GOOD <- file.path("/Library", "Frameworks", "R.framework", "Versions", 
                    paste(Rv$major, substr(Rv$minor, 1, 1), sep = "."), 
                    "Resources", "lib", "libc++.1.dylib")
  if (!file.exists(GOOD)) stop(paste(GOOD, "not found"))
  cmd <- paste(
    "install_name_tool",
    "-change",
    LIBCPP,
    GOOD,
    dso_last_path
  )
  system(cmd)
  dyn.unload(dso_last_path)
  dyn.load(dso_last_path)
  return(invisible(NULL))
}

fix_Mac

simple_lm_brms

source('fix_mac.R')

as.mcmc(simple_lm_brms, combine_chains = TRUE)

plot(simple_lm_brms)

gaussian()
binomial()
poisson()

simple_lm_formula <- bf(sales ~ temperature)
simple_lm_brms_2 <- brm(
  formula = simple_lm_formula,
  family = gaussian(),
  data = file_beer_sales_2,
  seed = 1,
  chains = 4,
  iter = 2000,
  warmup = 1000,
  thin = 1
)

prior_summary(simple_lm_brms)

simple_lm_brms_3 <- brm(
  formula = simple_lm_formula,
  family = gaussian(),
  data = file_beer_sales_2,
  seed = 1,
  prior = c(set_prior('', class = 'Intercept'),
            set_prior('', class = 'sigma')),
  chains = 4,
  iter = 2000,
  warmup = 1000,
  thin = 1
)

get_prior(
  formula = sales ~ temperature,
  family = gaussian(),
  data = file_beer_sales_2
)

stancode(simple_lm_brms_3)

standata_brms <- make_standata(
  formula = sales ~ temperature,
  family = gaussian(),
  data = file_beer_sales_2
)
standata_brms
