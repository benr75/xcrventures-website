#!/usr/bin/env ruby
if ARGV[0] == nil
  puts "Valid arguments 'start' 'deploy'"
else
  if ARGV[0] == "start"
    `jekyll serve --host 0.0.0.0`
  end

  if ARGV[0] == "deploy"
    `aws s3 sync _site s3://xcrventures.com`
  end
end
