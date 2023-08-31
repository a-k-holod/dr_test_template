#!/bin/bash

# Build the React app
cd frontend
npm install
npm run build
cd ..

# Start the Django server
python backend/manage.py migrate
python backend/manage.py collectstatic --noinput
gunicorn backend.your_django_app.wsgi
