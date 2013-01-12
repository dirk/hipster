module Hipster
  module Parser
    class Base
      attr_reader :url
      def initialize(url)
        @url = url
      end
      def to_dublin_core
        Hipster::Object::DublinCore.new
      end
      # TODO: Make these aliases work correctly
      #alias :to_dc :to_dublin_core
      def to_open_graph
        Hipster::Object::OpenGraph.new
      end
      #alias :to_og :to_open_graph
    end#Base
  end#Parser
end#Hipster
