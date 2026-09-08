# Intentionally weak Dockerfile for IaC/Dockerfile rules demo
FROM node:12
USER root
COPY . /app
WORKDIR /app
RUN npm install
EXPOSE 22
CMD ["node", "index.js"]
