FROM python:3.8

#set the working directory insidethe container
WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

#expose the port the flask application will be listening
EXPOSE 5000

#run the flask application
CMD ["python", "app.py"]