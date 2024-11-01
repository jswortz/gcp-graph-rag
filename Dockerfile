FROM python:3.12-slim

EXPOSE 9669

# # install nebula on a single machine
RUN apt-get update \
&& apt-get install -y wget \
&& apt-get install -y git \
&& apt-get install -y golang \
&& apt-get install -y make
RUN wget https://oss-cdn.nebula-graph.io/package/3.8.0/nebula-graph-3.8.0.ubuntu1804.amd64.deb
RUN dpkg -i nebula-graph-3.8.0.ubuntu1804.amd64.deb 
RUN /usr/local/nebula/scripts/nebula.service start all


# install go
# COPY --from=golang:1.17.1-alpine /usr/local/go/ /usr/local/go/
 
# ENV PATH="/usr/local/go/bin:${PATH}"
# ENV GOLANG_VERSION=1.17.1
# ENV GOPATH=/usr/local/go

# install nebula console 
RUN git clone https://github.com/vesoft-inc/nebula-console
RUN cd nebula-console/ && make
RUN chmod 777 nebula-console
RUN ./nebula-console -addr localhost -port 9669 -u root -p password -e 'ADD HOSTS "storaged0":9779,"storaged1":9779,"storaged2":9779;';
#start the nebula service

RUN pip install poetry==1.8.4
 
ENV PYTHONUNBUFFERED=True\
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache \
    APP_HOME=/app

WORKDIR $APP_HOME

COPY pyproject.toml poetry.lock ./
RUN touch README.md

RUN poetry install --without dev --no-root && rm -rf $POETRY_CACHE_DIR

ENV APP_HOME=/app
WORKDIR $APP_HOME
COPY . ./


