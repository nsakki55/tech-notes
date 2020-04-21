data {
  int N;
  int fish_num[N];
  vector[N] temperature;
  vector[N] sunny;
}

parameters {
  real Intercept;
  real b_temp;
  real b_sunny;
}

model {
  vector[N] lambda = exp(Intercept + b_temp*temperature + b_sunny*sunny);
  fish_num ~ poisson(lambda);
}
