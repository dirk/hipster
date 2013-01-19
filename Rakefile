require "bundler/gem_tasks"
require 'hipster'
require 'fileutils'

namespace :test do
  desc "Set up test data"
  task :setup do
    parser_data_directory = File.join(File.dirname(__FILE__), 'spec', 'parser', 'data')

    #create the parser's data directory in the FS if it's needed
    FileUtils.mkdir parser_data_directory unless File.directory? parser_data_directory

    print "Fetching http://www.imdb.com/title/tt1853728/ ... "
    $stdout.flush
    response = HTTParty.get('http://www.imdb.com/title/tt1853728/')
    data = Nokogiri::HTML(response.body)
    file = File.expand_path(File.join(
      parser_data_directory, 'imdb_tt1853728.html'
    ))
    File.open(file, 'w') {|f| f.write(data) }
    puts 'Done'
    
    print "Fetching http://en.wikipedia.org/wiki/Django_Unchained ..."
    $stdout.flush
    response = HTTParty.get('http://en.wikipedia.org/wiki/Django_Unchained')
    data = Nokogiri::HTML(response.body)
    file = File.expand_path(File.join(
      parser_data_directory, 'wikipedia_django_unchained.html'
    ))
    File.open(file, 'w') {|f| f.write(data) }
    puts 'Done'
  end
end
