# Stage 1: Build the frontend assets
FROM node:lts as build-deps
WORKDIR /frontend
COPY ./frontend/package.json ./frontend/yarn.lock ./
RUN yarn
COPY ./frontend /frontend
RUN yarn build

# Stage 2: Final Docker image with Python and frontend assets
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
RUN pip install --no-cache-dir yarn

# Copy frontend build from build-deps stage
COPY --from=build-deps /frontend/build /app/frontend/build

# Set working directory for backend installation
WORKDIR /app/backend

# Install Python dependencies
COPY ./backend/requirements /app/backend/requirements
RUN pip install --no-cache-dir -r requirements/production.txt

# Add the rest of the code
COPY . /app

# Build static files
WORKDIR /app/frontend/build
RUN mkdir root && mv *.ico *.js *.json root

# Collect static files
RUN mkdir /app/backend/staticfiles

# Set working directory for Django collectstatic
WORKDIR /app

# SECRET_KEY is only included here to avoid raising an error when generating static files
RUN DJANGO_SETTINGS_MODULE=backend.settings.production \
  SECRET_KEY=kwt)gl+o6wpum*h-z=+nw58piab6rj94n9jt#ceenz+&hzw00m \
  python backend/manage.py collectstatic --noinput

EXPOSE $PORT

CMD python3 backend/manage.py runserver 0.0.0.0:$PORT
