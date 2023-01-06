# make tensorflow training as base
ARG SRC_IMAGE_TAG="cpu-py39"
FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/tensorflow-training:2.10.0-${SRC_IMAGE_TAG}-ubuntu20.04-ec2

RUN pip install --upgrade pip
RUN apt-get update

RUN pip install tensorflow-addons
RUN pip install tensorflow-probability
RUN pip install crc32c
RUN pip install tensorboardX
RUN pip install tqdm
RUN pip install "overrides==7.3.1"
RUN pip install "xxhash==3.1.0"
RUN pip install "hydra-core~=1.3.0"
RUN pip install "wandb~=0.13.6"
RUN pip install "mlflow~=2.0.1"
RUN pip install "dacite~=1.6.0"
RUN pip install "pydantic~=1.10.2"
RUN pip install "retry~=0.9.2"

# INSTALL JAVA
RUN apt-get install -y openjdk-8-jdk; apt-get clean

RUN apt-get install ca-certificates-java; apt-get clean; update-ca-certificates -f

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# INSTALL RAY
RUN pip install "ray[all]==2.2.0"

# INSTALL RAYDP
RUN pip install raydp

# INSTALL AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"; \
    unzip awscliv2.zip; \
    rm -rf aws awscliv2.zip