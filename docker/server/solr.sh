### In logtime.sh (make sure this file is chmod +x):
#!/bin/sh
bundle exec rake sunspot:solr:start RAILS_ENV=production
