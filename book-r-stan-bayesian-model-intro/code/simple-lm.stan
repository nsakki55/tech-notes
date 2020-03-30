data {
  int N;
  vector[N] sales;
  vector[N] temperature;
}

parameters {
  real Intercept;
  real beta;
  real<lower=0> sigma;
}

model {
  for (i in 1:N) {
    sales[i] ~ normal(Intercept + beta * temperature[i], sigma);
  }
}

generated quantities {
  vector[N] pred;
  for (i in 1:N) {
    pred[i] = normal_rng(Intercept + beta * temperature[i], sigma);
  }
}
