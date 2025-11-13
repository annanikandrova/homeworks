set.seed(123)
data <- data.frame(
  x = 1:100,
  y = rnorm(100),
  category = sample(c("A", "B", "C"), 100, replace = TRUE)
)

# Создаем директорию для результатов
dir.create("/home/results", showWarnings = FALSE, recursive = TRUE)

# Сохраняем в CSV
write.csv(data, "/home/results/sample_data.csv", row.names = FALSE)

cat("Файл успешно создан: /home/results/sample_data.csv\n")
