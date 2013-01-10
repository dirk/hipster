require 'spec_helper'

describe Hipster::Parser::IMDb do
  before :all do
    # Django Unchained :P
    # movie_url = 'http://www.imdb.com/title/tt1853728/'
    # Load in cached copy of URL (as of 8 Jan. 2013) instead of redownloading
    # ever test run.
    movie_data_file = File.expand_path(File.join(
      File.dirname(__FILE__), 'data', 'imdb_tt1853728.html'
    ))
    movie_data = File.read(movie_data_file)
    # @parser = Hipster::Parser::IMDb.new(@movie_url)
    @parser = Hipster::Parser::IMDb.new_from_data(
      'http://www.imdb.com/title/tt1853728/',
      movie_data
    )
    @parser_fetch_result = @parser.fetch!
    @dc = @parser.to_dc
  end
  
  it "should fetch the page" do
    @parser_fetch_result.should_not be_nil
  end
  it "should return a DublinCore resource" do
    @dc.should be_an_instance_of(Hipster::Object::DublinCore)
  end
  it "should have the right title" do
    @dc.title.should == 'Django Unchained'
  end
  it "should have a description" do
    @dc.description.should_not be_empty
  end
  it "should have the right date" do
    @dc.date.should == Date.new(2012, 12, 25)
  end
  it "should be the movie type" do
    @dc.type.should == 'movie'
  end
  it "should have the right creator" do
    @dc.creator.should == 'Quentin Tarantino'
  end
  it "should have the right identifier" do
    @dc.identifier.should == 'http://www.imdb.com/title/tt1853728/'
  end
  it "should have the right meta parser" do
    @dc.meta[:parser].should == :imdb
  end
end

