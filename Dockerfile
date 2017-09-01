FROM tensorflow/tensorflow

RUN apt-get update && apt-get install -qy python3-pip
WORKDIR /root/
COPY requirements.txt ./
RUN pip3 install -r requirements.txt
ENV TF_CPP_MIN_LOG_LEVEL=3
COPY *.py ./
CMD ["python3", "./inception.py"]
