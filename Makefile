### dockerfile 単体時の設定

name = takuya/ubuntu-systemd
tag = latest
.PHONY: all build run

all: build

build: src/Dockerfile.ubuntu1804-systemd-modphp
 docker build -f src/Dockerfile.ubuntu1804-systemd -t $(name)-1804-modphp:$(tag) ./src

run:
	docker run -d--rm  --privileged \
       -v ${data_dir}/mysql:/var/lib/mysql \
       -v ${data_dir}/affilice:/var/www/html \
       -p ${PORT_PUBLISH}:80 \
      ${name}-1804-modphp
