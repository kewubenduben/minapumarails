FROM alpine:3.3
MAINTAINER Andre Cantero <thecantero@gmail.com>

ENV BUILD_PACKAGES \
    bash \
    build-base \
    curl-dev \
    libc-dev \
    libstdc++ \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    openssl-dev \
    postgresql-dev\
    ruby-dev \
    sqlite-dev \
    tzdata \
    zlib-dev

ENV RUBY_PACKAGES \
    nodejs \
    postgresql-client \
    ruby \
    ruby-bigdecimal \
    ruby-bundler \
    ruby-io-console \
    ruby-irb \
    ruby-json \
    ruby-rake 

RUN echo 'gem: --no-rdoc --no-ri' > /etc/gemrc

# Use libxml2 and libxslt packages from alpine for building nokogiri
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=true

RUN mkdir /usr/app
WORKDIR /usr/app

ADD Gemfile /usr/app/
ADD Gemfile.lock /usr/app/


# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $RUBY_PACKAGES && \
    apk add --virtual build-dependencies $BUILD_PACKAGES && \
    cp /usr/share/zoneinfo/UTC /etc/localtime && \
    echo 'UTC' > /etc/timezone && \
    bundle config --global frozen 1 && \
    bundle install --without development test && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

ADD . /usr/app
