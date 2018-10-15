FROM perl:5.28-slim
MAINTAINER Justin Zhang<schnell18@gmail.com>

# change time zone to Asia/Shanghai
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# change mirror
RUN sed -i.orig 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# install 7zip utility
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    unzip \
    p7zip \
    bzip2

# install Archive::Probe
RUN cpanm Archive::Probe

# add check-dup.pl
COPY * /usr/local/bin/
RUN chmod +x /usr/local/bin/*.pl
