FROM alpine:3.16

WORKDIR /tmp
COPY requirements.txt requirements.txt

RUN apk add --no-cache --virtual .build ca-certificates bash git rsync python3 py3-pip python3-dev py-configobj jpeg-dev zlib-dev g++ make gcc linux-headers musl-dev libffi-dev git-fast-import openssh \
    && rm -rf .build && mkdir /docs && pip3 install --no-cache-dir --no-input -r requirements.txt

WORKDIR /docs
COPY docs /docs/docs/
COPY mkdocs.yml /docs/

# Expose MkDocs development server port
EXPOSE 8000

# Start development server by default
ENTRYPOINT [""]
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
