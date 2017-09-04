FROM tensorflow/tensorflow

RUN apt-get update && apt-get install -qy python3-pip
WORKDIR /root/
COPY requirements.txt ./
RUN pip3 install -r requirements.txt
RUN apt-get install -qy vim nano
#ADD https://github.com/alexellis/faas/releases/download/0.6.2/fwatchdog /usr/bin
COPY ./fwatchdog /usr/bin/
RUN chmod +x /usr/bin/fwatchdog

ENV TF_CPP_MIN_LOG_LEVEL=3
COPY *.py ./
RUN python3 ./pre_download.py
COPY *.txt ./
COPY ./test.raw .
ENV fprocess="python3 index.py"
ENV fast_fork=1
CMD ["fwatchdog"]
#CMD ["python3", "./index.py"]
