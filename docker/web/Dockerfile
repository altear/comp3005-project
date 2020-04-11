FROM python:3.7-alpine

RUN mkdir /code
WORKDIR /code
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/