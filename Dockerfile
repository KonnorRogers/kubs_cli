FROM ruby:2.6.3


RUN apt update && apt upgrade -y

# libffi needed for libffi gem
RUN apt install -y libffi-dev apt-utils git



# copy the directory
RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp
RUN gem install bundler
RUN bundle install

RUN rake build && gem install pkg/*

# Create a user, and give them sudo privileges if needed
# password is 'docker'
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker
RUN git clone https://github.com/ParamagicDev/config-files.git /home/docker/config-files

