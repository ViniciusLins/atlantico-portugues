### In logtime.sh (make sure this file is chmod +x):
#!/bin/sh
cd /home/app/atlantico-portugues && bundle exec rake sunspot:solr:start RAILS_ENV=production
