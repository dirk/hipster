require 'spec_helper'

describe Hipster::Parser::Wikipedia::Movie do
  before :all do
    # Django Unchained :P
    @movie_url = 'http://en.wikipedia.org/wiki/Django_Unchained'
    # Load in cached copy of URL (as of 16 Jan. 2013) instead of redownloading
    # ever test run.
    movie_data_file = File.expand_path(File.join(
      File.dirname(__FILE__), 'data', 'wikipedia_django_unchained.html'
    ))
    movie_data = File.read(movie_data_file)
    # @parser = Hipster::Parser::Wikipedia.new(@movie_url)
    @parser = Hipster::Parser::Wikipedia::Movie.new_from_data(
      @movie_url,
      movie_data,
      :hint => :movie
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
    @dc.meta[:parser].should == :wikipedia
    @og.site_name.should == 'Wikipedia'
  end
  it "should have an image" do
    @og.image.should_not be_nil
  end
  it "should have the right publisher. Note that this is the first credited production company (DC only)" do
    @dc.publisher.should == "The Weinstein Company"
  end
  it "should have the right relation, which is the Wikipedia page slug (DC only)" do
    @dc.relation.should == "Django_Unchained"
  end
  it "should have categories as the subject (DC only)" do
    @dc.subject.should_not be_empty
  end
  it "should have the length in minutes (format in DC, duration in OG)" do
    @dc.format.should == 165
  end
  it "should have the right contributor (DC only)" do
    @dc.contributor.should == :wikipedia
  end
  
end#describe

