FROM python:3.11-alpine

WORKDIR /app

RUN apk add --update --no-cache gcc musl-dev linux-headers libffi-dev openssl-dev python3-dev

COPY ./requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install uwsgi

COPY ./backend/ ./

EXPOSE 80

CMD ["uwsgi", "--http", ":80", "--wsgi-file", "app.py", "--callable", "app", "-b", "32768"]
