# Atlântico Portugues 

This project intend to be a database for index history documents.


## Setup

    bundle install
    rake db:migrate
    rake db:populate
    rake db:test:prepare

## Running

    rake sunspot:solr:start
    rails s

## Testing  

    ruby bin/test.rb
