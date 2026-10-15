FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
	bash \
	coreutils \
	gawk \
	procps \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY system_check.sh .

RUN chmod +x system_check.sh

ENTRYPOINT ["./system_check.sh"]
