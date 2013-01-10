module Hipster
  module Object
    class DublinCore < Base
      TERMS = [
        'contributor', 'coverage', 'creator', 'date', 'description', 'format',
        'identifier', 'language', 'publisher', 'relation', 'rights', 'source',
        'subject', 'title', 'type'
      ]
      attr_accessor *TERMS.map(&:to_sym)
      attr_accessor :meta
    
      def initialize(attrs = {})
        TERMS.each do |term|
          if attrs.has_key? term
            var = attrs[term]
          elsif attrs.has_key? term.to_sym
            var = attrs[term.to_sym]
          else
            var = nil
          end
          self.instance_variable_set(('@'+term).to_sym, var)
        end
        @meta = (attrs[:meta] || {})
      end
    
    end#DublinCore
    DC = DublinCore
    
  end#Object
end#Hipster
