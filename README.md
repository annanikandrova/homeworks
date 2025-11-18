#инструкции по запуску Docker контейнера по выполнению джоинов (inner, left, right, outer) между данными метаданных образцов и масс-спектрометрии

состав репозитория hw9:
папка input для исходных данных
папка output для файлов, полученных при выполнении джоинов
Dockerfile - инструкция по созданию образа контейнера
requirements.txt 
join_script.py - скрипт для выполнения джоинов содержит следующий код:

import pandas as pd
import sys

# чтение данных из input
sample_metadata = pd.read_csv('/input/sample_metadata.csv')
mass_spec_results = pd.read_csv('/input/mass_spec_results.csv')

print("начало выполнения джоинов")

# inner join
print("выполнение inner join")
inner_join = pd.merge(sample_metadata, mass_spec_results, on='sample_id', how='inner')
inner_join.to_csv('/output/inner_join.csv', index=False)
print(f"inner join: {len(inner_join)} записей")

# left join:  
print("выполнение left join")
left_join = pd.merge(sample_metadata, mass_spec_results, on='sample_id', how='left')
left_join.to_csv('/output/left_join.csv', index=False)
print(f"left join: {len(left_join)} записей")

# right join
print("выполнение right join")
right_join = pd.merge(sample_metadata, mass_spec_results, on='sample_id', how='right')
right_join.to_csv('/output/right_join.csv', index=False)
print(f"right join: {len(right_join)} записей")

# outer join
print("выполнение outer join")
outer_join = pd.merge(sample_metadata, mass_spec_results, on='sample_id', how='outer')
outer_join.to_csv('/output/outer_join.csv', index=False)
print(f"OUTER JOIN: {len(outer_join)} записей")

print("джоины завершены!")


1. поместить csv файлы в папку `input` с именами:
- `sample_metadata.csv` - метаданные образцов
- `mass_spec_results.csv` - результаты масс-спектрометрии  
- `quality_metrics.csv` - данные о качестве
все входные файлы должны содержать колонку sample_id для выполнения джоинов.


2. сборка Docker-образа:
docker build -t mass-spec-joins .

3. запуск контейнера (с автоматическим созданием папки output с правами 777):

docker run -v "$(pwd)/input:/input" -v "$(pwd)/output:/output" mass-spec-joins
команда проводит монтирование папки input и output (которые находятся в текущей директории на хосте) в папки /input и /output внутри контейнера. 

4. при выполнении в папке output находятся 4 файла:
inner_join.csv - только записи, присутствующие во всех таблицах
left_join.csv - записи из метаданных + соответствующие данные
right_join.csv - записи из масс-спектрометрии + соответствующие данные
outer_join.csv - записи из всех таблиц
