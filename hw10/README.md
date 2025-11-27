Docker-контейнер для генерации спектральных данных и выполнения трех типов анти-джоинов с помощью библиотеки dplyr.

контейнер с монтированием папки data:
docker run -v $(pwd)/data:/data spectra-anti-joins

генерируются данные:
1. spectra_raw.csv - сырые спектральные данные (5 образцов, длины волн 200-800 нм)
2. spectra_stats.csv - статистика по исходным образцам
3. all_samples_stats.csv - расширенная статистика (8 образцов)

результаты анти-джоинов:
1. anti_left_join.csv - результат anti left join (обычно пустой)
2. anti_right_join.csv - результат anti right join (образцы 6-8)
3. anti_outer_join.csv - результат anti outer join (симметричная разность)

в папке data находятся:
df_raw.csv - исходные данные
detailed_stats.csv - исходные данные
spectra_raw_extended.csv - измененные исходные данные для возможности anti_right_join
anti_left_join.csv
anti_right_join.csv
anti_outer_join.csv