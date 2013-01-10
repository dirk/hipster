module Hipster
  module Object
    class OpenGraph < Base
      MANDATORY_PROPERTIES = ['title', 'type', 'image', 'url']
      OPTIONAL_PROPERTIES = ['site_name', 'description']
      attr_accessor *MANDATORY_PROPERTIES.map(&:to_sym)
      attr_accessor *OPTIONAL_PROPERTIES.map(&:to_sym)
    
      def initialize(attrs = {})
        attr_defaulter = Proc.new {|term|
          if attrs.has_key? term
            var = attrs[term]
          elsif attrs.has_key? term.to_sym
            var = attrs[term.to_sym]
          else
            var = nil
          end
          self.instance_variable_set(('@'+term).to_sym, var)
        }
        MANDATORY_PROPERTIES.each &attr_defaulter
        OPTIONAL_PROPERTIES.each &attr_defaulter
      end
    
    end#OpenGraph
  end#Object
end#Hipster
