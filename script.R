set.seed(123)
data <- data.frame(
  x = 1:100,
  y = rnorm(100),
  category = sample(c("A", "B", "C"), 100, replace = TRUE)
)

dir.create("/home/results", showWarnings = FALSE, recursive = TRUE)

write.csv(data, "/home/results/анализ_гемоглобина.csv", row.names = FALSE)

cat("Файл успешно создан: /home/results/анализ_гемоглобина.csv\n")
