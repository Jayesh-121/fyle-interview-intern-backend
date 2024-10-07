# base image
FROM python:3.8-slim

# working directory
WORKDIR /app
COPY . /app

#Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

#application port
EXPOSE 7755

ENV FLASK_APP=core/server.py
# Clear the database and apply migrations to get fresh database on each new run
RUN rm -f core/store.sqlite3  # Remove the old database
RUN flask db upgrade -d core/migrations/  # Apply migrations

# run flask app with gunicorn
CMD ["gunicorn", "-c", "gunicorn_config.py", "core.server:app"]
