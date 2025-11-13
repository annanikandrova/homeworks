install.packages("readxl")
getwd()
library(readxl)
patients <- read_excel("./common/Пациенты.xlsx")
head(patients)
str(patients$Возраст)
str(patients$глюкоза)

patients$Пол <- toupper(patients$Пол) 
patients$Пол <- factor(patients$Пол, levels = c("М", "Ж"))
str(patients$Пол)

patients_new<-patients
patients_new$возраст_группа_2 <- cut(patients_new$Возраст, breaks = c(-Inf, 59, Inf), 
                                     labels = c("Молодые", "Старшие"))
  
print(patients_new)

patients[patients$Возраст > 75, ]

head(patients$лейкоциты)
summary(patients$лейкоциты)
head(patients$глюкоза)
summary(patients$глюкоза)

aggregate(глюкоза~Пол, data=patients, FUN=mean)

aggregate(лейкоциты~Пол + возраст_группа_2, data=patients_new, FUN=mean)


stats <- function(x) {
 c(mean=mean(x), sd=sd(x), n=length(x))
}

result<-aggregate(глюкоза~Пол, data=patients, FUN=stats)
print(result)

boxplot(глюкоза~Пол, data=patients, main = 'распределение уровня глюкозы в зависимости от пола')

t.test(лейкоциты~Пол, data=patients)

#Н0 - мужчины и женщины имеют одинаковый уровень лейкоцитов, и наблюдаемые различия случайны.
#Н1 - существует статистически значимое различие в уровне лейкоцитов между двумя М и Ж.
#p-value = 0.09424 - результат статистически значим, Н0 отвергается

patients_task <- patients
patients_task$глюкоза[c(3, 15, 45)] <- NA

sum(is.na(patients_task))

which(is.na(patients_task$глюкоза))

patients_no_na <- na.omit(patients_task)
print(patients_no_na)

dim(patients_task) 
dim(patients_no_na)

patients_task$глюкоза[is.na(patients_task$глюкоза)] <- median(patients_task$глюкоза, na.rm=TRUE)

aggregate(лейкоциты~Пол, data=patients_task, FUN=mean, na.rm=TRUE)
aggregate(лейкоциты~Пол, data=patients_no_na, FUN=mean, na.rm=TRUE)
#среднее значение лейкоцитов по полу отличается для Ж, тк, судя по всему, мы внесли NA только в строки для Ж




sd_result <- aggregate(гемоглобин ~ возраст_группа_2, data = patients_new, FUN = sd)
mean_result <- aggregate(гемоглобин ~ возраст_группа_2, data = patients_new, FUN = mean)


final_result <- data.frame(возрастная_группа = sd_result$возраст_группа_2,
  стандартное_отклонение = sd_result$гемоглобин,
  среднее_значение = mean_result$гемоглобин)
View(final_result)
                          
write.csv(final_result, "анализ_гемоглобина.csv")