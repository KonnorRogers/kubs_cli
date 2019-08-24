FROM ruby:2.6.3

RUN apt update && apt upgrade -y

# libffi needed for libffi gem
RUN apt install -y libffi-dev apt-utils git

RUN git clone https://github.com/ParamagicDev/config-files.git $HOME/config-files

# copy the directory
RUN mkdir $HOME/myapp
WORKDIR $HOME/myapp
COPY . $HOME/myapp
RUN gem install bundler
RUN bundle install

ENTRYPOINT ["rake", "build", "&&", "/bin/bash"]


# Create a user, and give them sudo privileges if needed
# password is 'docker'
# RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
# USER docker

