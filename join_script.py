#скрипт для выполнения джоинов

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

