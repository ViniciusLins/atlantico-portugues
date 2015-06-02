FROM niltonvasques/atlantico-gems:latest

WORKDIR /usr/src/app

COPY . /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace 

EXPOSE 3000
#CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]
CMD bundle exec rake sunspot:solr:start RAILS_ENV=production && rails server -b 0.0.0.0 -e production
#RUN RAILS_ENV=production bundle exec rake db:migrate 
#RUN RAILS_ENV=production bundle exec rake db:reset 
#RUN RAILS_ENV=production bundle exec rake db:seed 

