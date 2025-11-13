FROM rocker/r-base:latest

RUN apt-get update && apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev

RUN R -e "install.packages('readxl', repos='https://cloud.r-project.org')"

WORKDIR /app

RUN mkdir /app/result

COPY run_analysis.R /app/run_analysis.R
COPY Пациенты.xlsx /app/Пациенты.xlsx

CMD ["Rscript", "/app/run_analysis.R"]
