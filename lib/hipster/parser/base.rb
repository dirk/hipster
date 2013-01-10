module Hipster
  module Parser
    class Base
      attr_reader :url
      def initialize(url)
        @url = url
      end
      def to_dc
        Hipster::DublinCore.new
      end
    end#Base
  end#Parser
end#Hipster
