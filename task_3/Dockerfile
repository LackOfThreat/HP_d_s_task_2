FROM python:3.8

ADD ./app /app
WORKDIR /app
RUN pip install -r requirements.txt

CMD ["python", "clients_drivers_routes_gen.py"]