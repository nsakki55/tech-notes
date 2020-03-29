data {
  int N;
  vector[N] animal_num;
}

parameters {
  real<lower=0> lambda;
}

model {
  animal_num ~ poisson(lambda);
}

generated quantities {
  int pred[N];
  for (i in 1:N) {
    pred[i] = poisson_rng(lambda);
  }
}