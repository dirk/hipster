require 'spec_helper'

describe Hipster::Parser::IMDb do
  before :all do
    # Django Unchained :P
    @movie_url = 'http://www.imdb.com/title/tt1853728/'
    # Load in cached copy of URL (as of 8 Jan. 2013) instead of redownloading
    # ever test run.
    movie_data_file = File.expand_path(File.join(
      File.dirname(__FILE__), 'data', 'imdb_tt1853728.html'
    ))
    movie_data = File.read(movie_data_file)
    # @parser = Hipster::Parser::IMDb.new(@movie_url)
    @parser = Hipster::Parser::IMDb.new_from_data(
      @movie_url,
      movie_data
    )
    @dc = @parser.to_dublin_core
    @og = @parser.to_open_graph
  end
  
  it "should return the right resources" do
    @dc.should be_an_instance_of(Hipster::Object::DublinCore)
    @og.should be_an_instance_of(Hipster::Object::OpenGraph)
  end
  it "should have the right title" do
    @dc.title.should == 'Django Unchained'
    @og.title.should == 'Django Unchained'
  end
  it "should have a description" do
    @dc.description.should_not be_empty
    @og.description.should_not be_empty
  end
  it "should have the right date" do
    @dc.date.should == Date.new(2012, 12, 25)
  end
  it "should be the movie type" do
    @dc.type.should == 'movie'
    @og.type.should == 'video'
  end
  it "should have the right creator" do
    @dc.creator.should == 'Quentin Tarantino'
  end
  it "should have the right identifier" do
    @dc.identifier.should == @movie_url
    @og.url.should == @movie_url
  end
  it "should have the right meta parser" do
    @dc.meta[:parser].should == :imdb
    @og.site_name.should == 'IMDb'
  end

  it "should have the right contributor (dublin core only)" do
    @dc.contributor.should == :imdb
  end

  it "should have the length in minutes (format in dc, duration in og)" do
    @dc.format.should == 165
    @og.duration.should == 165
  end

  it "should have the proper location (language and territory)" do
    @dc.language.should == "en-US"
    @og.locale.should == "en_US"
  end

  it "should have the right publisher. Note that this is the first credited production company (DublinCore only)" do
    @dc.publisher.should == "Weinstein Company, The"
  end

  it "should have the right relation, which is the IMDb ID (DublinCore only)" do
    @dc.relation.should == "tt1853728"
  end

  it "should return the IMDb URL for the source (DublinCore Only)" do
    @dc.source.should == @movie_url
  end

  it "should return the top keywords and genres for subject (DublinCore Only)" do
    @dc.subject.should == ["Slave", "Plantation", "Bounty Hunter", "Dentist", "Rescue", "Action", "Drama", "Western"]
  end

end

