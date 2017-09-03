FROM tensorflow/tensorflow

RUN apt-get update && apt-get install -qy python3-pip
WORKDIR /root/
COPY requirements.txt ./
RUN pip3 install -r requirements.txt

ADD https://github.com/alexellis/faas/releases/download/0.6.2/fwatchdog /usr/bin
RUN chmod +x /usr/bin/fwatchdog

ENV TF_CPP_MIN_LOG_LEVEL=3
COPY *.py ./
RUN python3 ./pre_download.py
COPY *.txt ./

ENV fprocess="python3 index.py"
CMD ["fwatchdog"]
#CMD ["python3", "./index.py"]
