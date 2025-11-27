
# Проверка и установка dplyr
if (!require("dplyr", character.only = TRUE)) {
    install.packages("dplyr", repos = "https://cloud.r-project.org/", dependencies = TRUE)
    library(dplyr)
}

cat("версия dplyr:", as.character(packageVersion("dplyr")), "\n")

set.seed(42)
wavelengths <- seq(200, 800, by = 10)
samples <- paste0("Sample_", 1:5)

generate_spectra <- function(sample) {
  data.frame(
    sample_id = sample,
    wavelength = wavelengths,
    absorbance = rnorm(length(wavelengths), 0.8, 0.2) + 
      runif(length(wavelengths), 0, 0.5),
    temp = rnorm(length(wavelengths), 25, 1),
    measurement_error = rnorm(length(wavelengths), 0, 0.05)
  )
}

df_raw <- bind_rows(lapply(samples, generate_spectra))

detailed_stats <- df_raw %>%
  group_by(sample_id) %>%
  summarize(
    across(
      c(absorbance, temp, measurement_error),
      list(mean = mean, sd = sd, min = min, max = max),
      .names = "{.col}_{.fn}"
    ),
    .groups = 'drop'
  )

# сохранение исходных данных
write.csv(df_raw, "/data/df_raw.csv", row.names = FALSE)
write.csv(detailed_stats, "/data/detailed_stats.csv", row.names = FALSE)

# ИСПРАВЛЕНИЕ: создаем дополнительные образцы тем же способом
extra_samples <- paste0("Sample_", 6:8)
df_extra <- bind_rows(lapply(extra_samples, generate_spectra))

# объединяем с исходными данными
df_raw_extended <- bind_rows(df_raw, df_extra)

# сохранение расширенных исходных данных
write.csv(df_raw_extended, "/data/spectra_raw_extended.csv", row.names = FALSE)

# anti left: записи из df_raw_extended, которых нет в detailed_stats
anti_left <- anti_join(df_raw_extended, detailed_stats, by = "sample_id")

# anti right: записи из detailed_stats, которых нет в df_raw_extended  
anti_right <- anti_join(detailed_stats, df_raw_extended, by = "sample_id")

# anti outer: симметричная разность - объединение anti_left и anti_right
anti_outer <- bind_rows(anti_left, anti_right)

write.csv(anti_left, "/data/anti_left_join.csv", row.names = FALSE)
write.csv(anti_right, "/data/anti_right_join.csv", row.names = FALSE)
write.csv(anti_outer, "/data/anti_outer_join.csv", row.names = FALSE)

cat("Обработка завершена. Файлы сохранены в /data\n")
cat("Созданные файлы:\n")
print(list.files("/data"))