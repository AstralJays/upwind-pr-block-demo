# Intentionally weak Dockerfile for IaC/Dockerfile rules demo — round 2
FROM python:2.7
USER root
ENV AWS_SECRET_ACCESS_KEY=FAKESECRET_g1h2i3j4k5l6m7n8o9p0
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 22 3389
CMD ["python", "app.py"]
