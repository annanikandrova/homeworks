

#!/usr/bin/env python3
import pandas as pd
import sys

def main():
    if len(sys.argv) != 6:
        print("использование: python anti_join.py mass_spec.csv metadata.csv output1.csv output2.csv output3.csv")
        sys.exit(1)
    
    mass_spec = pd.read_csv(sys.argv[1])
    metadata = pd.read_csv(sys.argv[2])
    
    print(f"Прочитано {len(mass_spec)} строк из mass_spec_results.csv")
    print(f"Прочитано {len(metadata)} строк из sample_metadata.csv")
    
    print(f"колонки mass_spec: {list(mass_spec.columns)}")
    print(f"колонки metadata: {list(metadata.columns)}")
    
    merged1 = metadata.merge(mass_spec, how='left', indicator=True)
    anti1 = merged1[merged1['_merge'] == 'left_only'].drop('_merge', axis=1)
    anti1.to_csv(sys.argv[3], index=False)
    
    merged2 = mass_spec.merge(metadata, how='left', indicator=True)
    anti2 = merged2[merged2['_merge'] == 'left_only'].drop('_merge', axis=1)
    anti2.to_csv(sys.argv[4], index=False)

    if len(mass_spec.columns) > 0 and len(metadata.columns) > 0:
        key_col = mass_spec.columns[0]
        if key_col in metadata.columns:
            inner_merged = mass_spec.merge(metadata, on=key_col, how='inner', suffixes=('_ms', '_md'))

            anti3 = pd.DataFrame()
            print(f"Колонки после объединения: {list(inner_merged.columns)}")
        else:
            anti3 = pd.DataFrame()
            print(f"Ключевая колонка {key_col} не найдена в metadata")
    else:
        anti3 = pd.DataFrame()
    
    anti3.to_csv(sys.argv[5], index=False)
    
    print(f"  anti1 (в метаданных, но не в результатах): {len(anti1)} строк")
    print(f"  anti2 (в результатах, но не в метаданных): {len(anti2)} строк")
    print(f"  anti3 (общие записи с различиями): {len(anti3)} строк")

if __name__ == "__main__":
    main()
