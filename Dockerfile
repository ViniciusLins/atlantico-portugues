FROM niltonvasques/rails:latest

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN export RAILS_ENV=production

RUN bundle install 

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace 
RUN RAILS_ENV=production bundle exec rake sunspot:solr:start
RUN RAILS_ENV=production bundle exec rake sunspot:solr:reindex

EXPOSE 3000
CMD ["RAILS_ENV=production", "rails", "server", "-b", "0.0.0.0"]
#RUN RAILS_ENV=production bundle exec rake db:migrate 
#RUN RAILS_ENV=production bundle exec rake db:reset 
#RUN RAILS_ENV=production bundle exec rake db:seed 

