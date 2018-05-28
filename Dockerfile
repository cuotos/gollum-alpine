FROM ruby:alpine3.7
MAINTAINER Adhityaa Chandrasekar <c.adhityaa@gmail.com>

# dl-cdn.alpinelinux.org has issues sometimes for me
RUN echo "https://mirror.csclub.uwaterloo.ca/alpine/v3.7/main" >/etc/apk/repositories && \
    echo "https://mirror.csclub.uwaterloo.ca/alpine/v3.7/community" >>/etc/apk/repositories
RUN apk update
RUN apk add --no-cache --virtual build-deps build-base
RUN apk add --no-cache icu-dev icu-libs
RUN apk add --no-cache cmake
RUN apk add --no-cache git

RUN gem install github-linguist
RUN gem install gollum 

RUN apk del cmake build-base build-deps

# create a volume and
WORKDIR /wiki

ENTRYPOINT ["/bin/sh", "-c", "git init && gollum --port 8080 --live-preview"]
EXPOSE 8080