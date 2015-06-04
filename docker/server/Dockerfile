FROM phusion/passenger-ruby21
MAINTAINER Nilton Vasques "nilton.vasques@gmail.com" 

ENV HOME /root
ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y postgresql-client imagemagick zlib1g-dev openjdk-7-jdk libpq-dev vim --no-install-recommends && rm -rf /var/lib/apt/lists/* 

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD docker/webapp.conf /etc/nginx/sites-enabled/atlantico-portugues.conf

# APP SETTINGS
RUN sudo bundle config --global frozen 1
# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
#RUN bundle install --deployment --verbose --retry 4
RUN bundle pack --verbose
RUN bundle install --path vendor/cache --deployment --verbose --retry 4
RUN ls -la
RUN ls -la vendor/
RUN pwd

ENV RAILS_ENV production

RUN mkdir /home/app/atlantico-portugues
ADD . /home/app/atlantico-portugues
RUN ln -s /tmp/vendor/bundle /home/app/atlantico-portugues/vendor/
RUN ln -s /tmp/vendor/cache /home/app/atlantico-portugues/vendor/
WORKDIR /home/app/atlantico-portugues
RUN chown -R app:app /home/app/atlantico-portugues
#ADD ./Gemfile Gemfile
#ADD ./Gemfile.lock Gemfile.lock
#RUN sudo -u app bundle install --deployment --verbose --retry 4
RUN ls -la vendor
#RUN ls -la vendor/bundle/
RUN pwd
RUN bundle exec rake assets:precompile
RUN bundle exec rake sunspot:solr:start

## STARTING SOLR
#RUN mkdir -p /etc/my_init.d
#ADD docker/server/solr.sh /etc/my_init.d/solr.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#----------------------------------------------------------------------



#COPY . /home/app/webapp
#COPY Gemfile /home/app/webapp
#COPY Gemfile.lock /home/app/webapp
#
#ENV RAILS_ENV production
#
#RUN bundle install 
#
#RUN bundle exec rake assets:precompile --trace 
#
#RUN rm -f /etc/service/nginx/down
#
