FROM ruby:2.1.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client imagemagick zlib1g-dev openjdk-7-jdk libpq-dev vim --no-install-recommends && rm -rf /var/lib/apt/lists/*

