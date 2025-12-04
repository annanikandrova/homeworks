#запуск:

1. собрать докер образ
   docker build -t mass_spec:latest .

2. запустить пайплайн

   snakemake --cores 1


3. создать графы

   snakemake --rulegraph | dot -Tpng > rulegraph.png

   snakemake --filegraph | dot -Tpng > filegraph.png