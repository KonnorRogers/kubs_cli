FROM ruby:2.6.3-alpine

RUN apt update && apt upgrade -y

# copy the directory
RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp

# Create a user, and give them sudo privileges
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker

RUN gem install bundler
RUN bundle install
