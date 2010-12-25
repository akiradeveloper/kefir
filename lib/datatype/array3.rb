module Kefir

  class << self
    class Array3
      def self.accept?(expr)
        unless expr.kind_of? Array 
          return false
        end        
        unless expr.size() == 3
          return false
        end
        return true
      end

      def initialize(expr)
        @expr = expr
      end

      def data_expr
        return "-"
      end

      def inline_data
        s = ""
        xs = expr[0]
        ys = expr[1]
        zs = expr[2]
        @expr.each_index do |i|
          s << "#{xs[i]} #{ys[i]} #{zs[i]}\n" 
        end
        s
      end
    end
  end
end
