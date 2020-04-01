# ./Dockerfile
# ENV matching production target host
# We'll be using an ubuntu 18.04 EC2 instance to run this app
FROM ubuntu:18.04

# Mostly locale related env config
# Elixir expects to be built on a system with UTF-8
ENV REFRESHED_AT=2018-08-16 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    HOME=/opt/build \
    TERM=xterm\
    DEBIAN_FRONTEND=noninteractive

WORKDIR /opt/build

# Installing erlang, elixir and a few build deps
RUN \
  apt-get update -y && \
  apt-get install -y git wget locales gnupg && \
  locale-gen en_US.UTF-8 && \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  rm erlang-solutions_1.0_all.deb && \
  apt-get update -y && \
  apt-get install -y erlang elixir

CMD ["/bin/bash"]
