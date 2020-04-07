# ./Dockerfile
# ENV matching production target host
# We'll be using a Debian linux EC2 instance to run this app
# Sell all official elixir docker images here: https://hub.docker.com/_/elixir
FROM elixir:1.10

# By default, if we're cutting a release it'll likely be prod
ARG ENV=prod

# We'll pass in ENV as a build arg to docker
ENV MIX_ENV=$ENV

# Our working directory within the container
WORKDIR /opt/build

# Add our release script to the container, named `release` and
# placed into the ./bin/ directory in our project root
ADD ./bin/release ./bin/release

# This is our entry point, make sure to run
# `chmod +x bin/release` to make this script executable
CMD ["bin/bash", $ENV]
