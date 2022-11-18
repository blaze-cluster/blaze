# make tensorflow training as base
ARG SRC_IMAGE_TAG="cpu-py39"
FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/tensorflow-training:2.10.0-${SRC_IMAGE_TAG}-ubuntu20.04-ec2

RUN pip install --upgrade pip
RUN apt-get update

RUN pip install tensorflow-addons
RUN pip install tqdm
RUN pip install "overrides==7.3.1"

# INSTALL JAVA
RUN apt-get install -y openjdk-8-jdk; apt-get clean

RUN apt-get install ca-certificates-java; apt-get clean; update-ca-certificates -f

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# INSTALL RAY
RUN pip install "ray[all]==2.1.0"

# INSTALL RAYDP
RUN pip install raydp

# INSTALL AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    unzip awscliv2.zip; \
    rm -rf aws awscliv2.zip