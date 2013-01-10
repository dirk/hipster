require "bundler/gem_tasks"
require 'hipster'

namespace :test do
  desc "Set up test data"
  task :setup do
    print "Fetching http://www.imdb.com/title/tt1853728/ ... "
    response = HTTParty.get('http://www.imdb.com/title/tt1853728/')
    data = Nokogiri::HTML(response.body)
    file = File.expand_path(File.join(
      File.dirname(__FILE__), 'spec', 'parser', 'data', 'imdb_tt1853728.html'
    ))
    File.open(file, 'w') {|f| f.write(data) }
    puts 'Done'
  end
end
