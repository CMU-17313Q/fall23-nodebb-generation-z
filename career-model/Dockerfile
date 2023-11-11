FROM python:3.11

WORKDIR /career-microservice

COPY . /career-microservice

RUN pip install flask

RUN pip install -r requirements.txt

EXPOSE 80

CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]