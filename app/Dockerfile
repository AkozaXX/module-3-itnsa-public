FROM alpine:latest
WORKDIR /app
COPY app.py /app/app.py
COPY requirements.txt /app/requirements.txt
RUN apk add --update --no-cache python3 py3-pip
RUN pip3 install -r requirements.txt
CMD [ "python3","app.py" ]