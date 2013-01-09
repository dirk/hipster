module Hipster
  module Parser
    class IMDb < Base
      attr_accessor :html
      
      def initialize(url)
        super(url)
        @response = nil
        @html = nil
      end
      def self.new_from_data(data)
        imdb = self.new(nil)
        imdb.html = Nokogiri::HTML(data)
        imdb
      end
      def fetch!
        return self if url.nil?
        response = HTTParty.get(url)
        @html = Nokogiri::HTML(response.body)
        self
      end
      def to_dc
        Hipster::DublinCore.new(
          :title => title
        )
      end
      
      private
      def title
        header = @html.css('.article h1').first
        if header.children.empty?
          header.text.strip
        else
          header.children.select(&:text?).first.text.strip
        end
      end
      
    end
  end
end
