FROM python:3.7-alpine

RUN mkdir /code
WORKDIR /code

RUN apk update
RUN apk add --no-cache gcc musl-dev linux-headers postgresql-dev python3-dev git bash

RUN git clone https://github.com/vishnubob/wait-for-it.git 
RUN cp wait-for-it/*.sh . 

COPY requirements.txt /code/
RUN pip install -r requirements.txt
