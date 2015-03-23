#!/usr/bin/env ruby



SOLR_ENV =  "rake sunspot:solr:run RAILS_ENV=test"
pid = Process.spawn(SOLR_ENV)
Process.detach pid

puts "Loading test environment"
30.times do |n| 
  progress = (n/30.0) * 100
  puts "#{progress} %"
  sleep 1
end

system "guard"

system "kill -SIGTERM #{pid}"
