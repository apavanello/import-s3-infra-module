FROM hashicorp/terraform:1.9

RUN apk add --no-cache python3 py3-pip jq dos2unix \
    && pip3 install --upgrade pip --break-system-packages \
    && pip3 install awscli --break-system-packages

WORKDIR /workspace

ENTRYPOINT ["/bin/sh"]
