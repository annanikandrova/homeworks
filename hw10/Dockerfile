FROM r-base:4.3.0

WORKDIR /app

# Установка системных зависимостей для dplyr
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

COPY script.R .

# Установка dplyr с зависимостями
RUN R -e "install.packages('dplyr', repos='https://cloud.r-project.org/', dependencies=TRUE)"

CMD ["Rscript", "script.R"]