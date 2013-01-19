require 'spec_helper'

describe Hipster::Object::DublinCore do
  before :all do
    # @terms = [
    #   'contributor', 'coverage', 'creator', 'date', 'description', 'format',
    #   'identifier', 'language', 'publisher', 'relation', 'rights', 'source',
    #   'subject', 'title', 'type'
    # ]
    @terms = Hipster::Object::DublinCore::TERMS
  end
  
  it "should default terms to nil" do
    dc = Hipster::Object::DublinCore.new
    @terms.each do |term|
      dc.send(term.to_sym).should be_nil
    end
  end
  it "should have empty meta" do
    dc = Hipster::Object::DublinCore.new
    dc.meta.should == {}
  end
end
