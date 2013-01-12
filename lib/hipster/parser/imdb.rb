require 'date'

module Hipster
  module Parser
    class IMDb < Base
      attr_accessor :html
      
      def initialize(url)
        super(url)
        @response = nil
        @html = nil
      end
      def self.new_from_data(url, data)
        imdb = self.new(url)
        imdb.html = Nokogiri::HTML(data)
        imdb
      end
      def fetch!
        return self if url.nil?
        response = HTTParty.get(url)
        @html = Nokogiri::HTML(response.body)
        self
      end
      def to_dublin_core
        Hipster::Object::DublinCore.new(
          :title => title,
          :description => description,
          :date => date,
          :creator => creator,
          :type => 'movie',
          :identifier => @url,
          :source => @url,
          :rights => 'http://www.imdb.com/help/show_article?conditions',
          :meta => {
            :parser => :imdb
          }
        )
      end
      def to_open_graph
        Hipster::Object::OpenGraph.new(
        # Mandatory
        :title => title,
        :type => 'video',
        :image => nil,
        :url => @url,
        # Optional
        :site_name => 'IMDb',
        :description => description
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
      
      def description
        @html.css('p[itemprop="description"]').first.text.strip
      end
      
      def date
        text = @html.css('time[datetime][itemprop="datePublished"]').first['datetime']
        Date.strptime(text, '%Y-%m-%d')
      end
      
      def creator
        @html.css('a[itemprop="director"]').first.text.strip
      end
      
    end
  end
end
