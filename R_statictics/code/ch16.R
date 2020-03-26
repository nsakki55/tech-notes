set.seed(9999)

n <- 200

load_m <- matrix(c(0.09884, 0.17545, 0.52720, 0.73462,
                   0.45620, 0.72141, 0.47258, 0.17901, 0.07984, 0.37204), nrow=5)

uniq <- diag(sqrt(c(0.530201, 0.254119, 0.309986,
                    0.546036, 0.346539)))

factor_m <- matrix(rnorm(2*n), nrow=2)

uniq_m <- matrix(rnorm(5*n), nrow=5)

subjects <- round(t(load_m%*%factor_m + uniq%*%uniq_m)*10+50)

colnames(subjects) <- c("J", "S", "math", "sci", "E")

cor_mat <- cor(subjects)
cor_mat

fact_result <- factanal(subjects, factors=2)
fact_result

commons <- 1 - fact_result$uniquenesses
commons

print(fact_result, cutoff=0)

print(fact_result, cutoff=0, sort=TRUE)

fact_promax <- factanal(subjects, factors=2, rotation='promax')
print(fact_promax, cutoff=0)

fact_non_rotation <- factanal(subjects, factors=2, rotation='none')
print(fact_non_rotation, cutoff=0)

result_promax <- promax(loadings(fact_non_rotation), m=4)
result_promax

fact_cor <- solve(t(result_promax$rotmat) %*% result_promax$rotmat)
fact_cor

