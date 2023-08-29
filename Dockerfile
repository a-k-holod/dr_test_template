# Use an official Python runtime as a parent image
FROM python:latest

# Create and activate a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install curl, node, & yarn (if needed)
# RUN apt-get -y install curl \
#   && curl -sL https://deb.nodesource.com/setup_16.x | bash \
#   && apt-get install nodejs \
#   && curl -o- -L https://yarnpkg.com/install.sh | bash

# Install yarn globally within the virtual environment
RUN #/opt/venv/bin/pip install --no-cache-dir yarn

WORKDIR /app/backend

# Install Python dependencies
COPY ./backend/requirements /app/backend/requirements
RUN pip install --no-cache-dir -r requirements/production.txt

# Install JS dependencies
WORKDIR /app/frontend

COPY ./frontend/package.json /app/frontend/
RUN #/opt/venv/bin/yarn install

# Add the rest of the code
COPY . /app

# Build static files
RUN #/opt/venv/bin/yarn build

# Have to move all static files other than index.html to root/
# for whitenoise middleware
WORKDIR /app/frontend/build

RUN mkdir root && mv *.ico *.js *.json root

# Collect static files
RUN mkdir /app/backend/staticfiles

WORKDIR /app

# SECRET_KEY is only included here to avoid raising an error when generating static files
RUN DJANGO_SETTINGS_MODULE=backend.settings.production \
  SECRET_KEY=somethingsupersecret \
  python backend/manage.py collectstatic --noinput

EXPOSE $PORT

CMD python3 backend/manage.py runserver 0.0.0.0:$PORT
