module Hipster
  class Frontend
    def self.parser_for(url)
      # IMDb
      guess url, /imdb\.com\/title\/tt([0-9]+)/ do |match|
        return Hipster::Parser::IMDb::Movie.new('http://www.'+match[0])
      end
    end
    
    private
    def self.guess(url, pattern, &block)
      match = url.match(pattern)
      unless match.nil?
        block.call(match)
      end
    end
  end
end
