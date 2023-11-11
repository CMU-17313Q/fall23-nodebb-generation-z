FROM python:3.11
WORKDIR /career-microservice
COPY . /career-microservice
RUN pip install flask
RUN pip install -r requirements.txt
EXPOSE 90
CMD ["flask", "run", "--host=0.0.0.0", "--port=90"]
