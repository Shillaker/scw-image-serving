FROM python:3-alpine
WORKDIR /usr/src/app

COPY requirements.txt .
RUN pip install -qr requirements.txt
COPY server.py .

WORKDIR image
COPY hello.png .
COPY dummy.png .

CMD ["python3", "./server.py"]
