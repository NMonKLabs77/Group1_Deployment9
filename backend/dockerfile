# Use an official Python 3.9 image as a parent image
FROM python:3.9

# Clone your Git repository into the current directory
RUN git clone https://github.com/NMonKLabs77/Group1_Deployment9.git

# Change to the "backend" directory inside your app directory
WORKDIR Group1_Deploymet9/backend/

# Install the Python dependencies from requirements.txt
RUN pip install -r requirements.txt

# Install Gunicorn for serving the Django application
RUN pip install gunicorn

# Perform Django database migrations
RUN python manage.py migrate

# Expose the port that your application listens on
EXPOSE 8000

# Start the Django application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "my_project.wsgi:application"]