require 'spec_helper'

describe Hipster::Frontend do
  it "should guess an IMDb parser" do
    url = "http://www.imdb.com/title/tt1853728/"
    parser = Hipster::Frontend.parser_for url
    parser.should be_an_instance_of(Hipster::Parser::IMDb::Movie)
  end
  
  it "should guess a Wikipedia parser" do
    url = "http://en.wikipedia.org/wiki/Django_Unchained"
    parser = Hipster::Frontend.parser_for url
    parser.should be_an_instance_of(Hipster::Parser::Wikipedia::Movie)
  end
end
