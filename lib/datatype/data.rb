module Kefir
  module Data
    @options
    def <<(option)
      @options << option
    end  
    attr_reader :options 
  end
end
