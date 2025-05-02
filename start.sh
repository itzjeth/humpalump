#!/usr/bin/env bash
set -o errexit

echo "📦 Collecting static files..."
python manage.py collectstatic --noinput

echo "🧱 Running migrations..."
python manage.py migrate

echo "🖼️  Ensuring default profile image folder exists..."
mkdir -p media/profile_images
cp media/profile_images/default.png media/profile_images/default.png

echo "🚀 Starting Gunicorn..."
gunicorn sting.wsgi:application --bind 0.0.0.0:$PORT
