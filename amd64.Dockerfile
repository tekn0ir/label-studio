FROM python:3.6-slim as base

ENV GCSFUSE_REPO gcsfuse-buster
RUN apt-get update && apt-get install --yes --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
  && echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" \
    | tee /etc/apt/sources.list.d/gcsfuse.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && apt-get update \
  && apt-get install --yes gcsfuse \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /cloudstorage

ENV PORT="8888"
ENV PROJECT_NAME=project

WORKDIR /label-studio

# Copy and install requirements.txt first for caching
COPY requirements.txt /label-studio
RUN pip install -r requirements.txt


FROM base

COPY label_studio /label-studio/label_studio
COPY README.md /label-studio
COPY setup.py /label-studio
COPY entrypoint.sh /label-studio
RUN ls -la
RUN python setup.py develop

EXPOSE ${PORT}
# User configuration directory volume
VOLUME ["/data"]

CMD ["/label-studio/entrypoint.sh"]
