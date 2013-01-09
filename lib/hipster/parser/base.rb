module Hipster
  module Parser
    class Base
      attr_reader :url
      def initialize(url)
        @url = url
      end
    end
  end
end
