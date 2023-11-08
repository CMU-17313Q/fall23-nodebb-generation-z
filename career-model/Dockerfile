FROM python:3.11

WORKDIR /python-microservice

COPY requirements.txt .

RUN pip install flask
RUN pip install --no-cache-dir -r requirements.txt

COPY . .



EXPOSE 80

ENV PORT 80

ENV HOSTNAME "0.0.0.0"

CMD ["flask", "run", "--host", "0.0.0.0", "--port", "80"]