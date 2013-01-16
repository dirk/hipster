
module Hipster
  module Parser
    class Wikipedia < Base
      attr_accessor :html
      
      def initialize(url)
        super(url)
        @response = nil
        @html = nil
      end
      def self.new_from_data(url, data)
        obj = self.new(url)
        obj.html = Nokogiri::XML(data)
        obj
      end
      def fetch!
        return self if url.nil?
        response = HTTParty.get(url, :headers => {"User-Agent" => "Hipster #{Hipster::VERSION}"})
        @html = Nokogiri::HTML(response.body)
        self
      end
      def to_dublin_core
        Hipster::Object::DublinCore.new(
          :title => title,
          :description => description,
          #:date => date,
          #:creator => creator,
          #:type => 'movie',
          :identifier => @url,
          :source => @url,
          :rights => 'http://wikimediafoundation.org/wiki/Terms_of_Use',
          :meta => {
            :parser => :wikipedia
          }
        )
      end
      def to_open_graph
        Hipster::Object::OpenGraph.new(
        # Mandatory
        :title => title,
        #:type => 'video',
        #:image => nil,
        :url => @url,
        # Optional
        :site_name => 'Wikipedia',
        :description => description
        )
      end
      
      private
      def title
        @html.css('h1').first.text.strip
      end
      
      def description
        @html.css('#mw-content-text p').first.text
      end
      
      # def date
      #   text = @html.css('time[datetime][itemprop="datePublished"]').first['datetime']
      #   Date.strptime(text, '%Y-%m-%d')
      # end
      # 
      # def creator
      #   @html.css('a[itemprop="director"]').first.text.strip
      # end
      
    end
  end
end
