FROM python:3.8
ENV PYTHONUMBUFFERED 1
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
COPY . /app

EXPOSE 8000

CMD python manage.py runserver 0.0.0.0:8000
