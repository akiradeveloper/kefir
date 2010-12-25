module Kefir
  class << self
    class MathExpr
      def initialize(expr)
        @expr = expr
      end
      def data_expr
        return @expr
      end
      def inline_data
        return ""
      end
    end
  end
end
