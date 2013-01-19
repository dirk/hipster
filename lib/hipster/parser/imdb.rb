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
          :contributor => :imdb,
          :format => duration,
          :relation => imdb_id,
          :publisher => publisher,
          :subject => keywords + genres,
          :language => 'en-US', # TODO: Language detection
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
          :description => description,
          :locale => 'en_US' # TODO: Locale detection
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
      
      def duration
        @html.css('time[datetime][itemprop="duration"]').first.text.split(/s+/).first.to_i
      end
      
      def imdb_id
        @url[/tt[0-9]+/]
      end
      
      def publisher
        h4 = @html.css('h4').select {|h4| h4.text.strip.downcase == 'production co:' }.first
        if h4
          # h4.next_element.text
          h4.parent.children.css('a').first.text
        else
          ''
        end
      end
      
      def keywords
        h4 = @html.css('h4').select {|h4| h4.text.strip.downcase == 'plot keywords:' }.first
        if h4
          h4.parent.children.css('a').select {|a| a['href'] =~ /\/keyword\/.+/ }.map {|a| a.text.strip }
        else
          []
        end
      end
      def genres
        h4 = @html.css('h4').select {|h4| h4.text.strip.downcase == 'genres:' }.first
        if h4
          h4.parent.children.css('a').select {|a| a['href'] =~ /\/genre\/.+/ }.map {|a| a.text.strip }
        else
          []
        end
      end
      
    end
  end
end
