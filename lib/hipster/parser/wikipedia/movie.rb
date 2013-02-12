
module Hipster
  module Parser
    module Wikipedia
      
      class Movie < ::Hipster::Parser::Base
        # TODO: Remove :hint
        DEFAULT_OPTIONS = {
          :hint => nil
        }
        attr_accessor :html, :opts
        # TODO: Remove :hint
        def initialize(url, _opts = {:hint => :movie})
          super(url)
          @response = nil
          @html = nil
          @opts = DEFAULT_OPTIONS.merge(_opts)
        end
        def self.new_from_data(url, data, opts = {})
          obj = self.new(url, opts)
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
            :date => date,
            :creator => creator,
            :type => dc_type,
            :identifier => @url,
            :source => @url,
            :rights => 'http://wikimediafoundation.org/wiki/Terms_of_Use',
            :publisher => publisher,
            :relation => wikipedia_id,
            :subject => categories,
            :format => duration,
            :contributor => :wikipedia,
            :meta => {
              :parser => :wikipedia
            }
          )
        end
        def to_open_graph
          Hipster::Object::OpenGraph.new(
            # Mandatory
            :title => title,
            :type => og_type,
            :image => image,
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
      
        def dc_type
          # TODO: Remove :hint
          if opts[:hint] == :movie
            'movie'
          else
            nil
          end
        end
        def og_type
          # TODO: Remove :hint
          if opts[:hint] == :movie
            'video'
          else
            'website'
          end
        end
      
        def creator
          # TODO: Remove :hint
          if opts[:hint] == :movie
            directed_by = @html.css('#mw-content-text table.infobox tr th').select {|th| th.text.strip == 'Directed by' }.first
            if directed_by
              directed_by.next_element.text
            else
              nil
            end
          else
            nil
          end
        end
      
        def date
          Date.parse(@html.css('#mw-content-text table.infobox span.published').first.text)
        end
      
        def image
          img = @html.css('#mw-content-text img').first
          if img
            ensure_protocol(img.attribute('src'))
          else
            nil
          end
        end
      
        # http://stackoverflow.com/questions/7908598/add-https-to-url-if-its-not-there
        def ensure_protocol(url)
          unless url[/^http:/] || url[/^https:/]
            return 'http:' + url
          end
          return url
        end
      
        def publisher
          if opts[:hint] == :movie
            distributed_by = @html.css('#mw-content-text table.infobox tr th').select {|th| th.text.strip == 'Distributed by' }.first
            if distributed_by
              next_el = distributed_by.next_element
              if next_el
                a = next_el.css('a').first
                if a
                  return a.text
                end
              end
            end
            return nil
          else
            nil
          end
        end
      
        def duration
          running_time = @html.css('#mw-content-text table.infobox tr th').select {|th| th.text.strip == 'Running time' }.first
          if running_time
            next_el = running_time.next_element
            if next_el && !next_el.children.empty?
              return next_el.children.first.text.scan(/[1-9][0-9]+/).first.to_i
            end
          end
          nil
        end
      
        def wikipedia_id
          @url.scan(/\/wiki\/([^?]+)/).to_s
        end
      
        def categories
          @html.css('#mw-normal-catlinks:not(.mw-hidden-cats-hidden) ul li a').map {|a| a.text }
        end
      
      end#class
      
    end#module(Wikipedia)
  end#module(Parser)
end#module(Hipster)
