FROM ruby:2.6.3

RUN apt update && apt upgrade -y

# libffi needed for libffi gem
RUN apt install -y libffi-dev apt-utils

# copy the directory
RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp

# Create a user, and give them sudo privileges if needed
# password is 'docker'
# RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
# USER docker

RUN gem install bundler
RUN bundle install
