FROM node:slim

WORKDIR /app

COPY . .

EXPOSE 8080

RUN apt-get update && \
    apt-get install -y curl gawk sed unzip wget net-tools && \
    chmod +x entry_point.sh && \
    chmod +x index.js && \
    npm install

ENTRYPOINT ["./entry_point.sh"]
