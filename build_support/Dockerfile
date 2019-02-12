FROM ruby:2.5.3-stretch
RUN gem install inspec

RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates
RUN curl -sSL https://get.docker.com/ | sh

# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
#     add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
#     apt-get update && \
#     apt-get install docker-ce

