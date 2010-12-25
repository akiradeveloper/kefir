["array2", "array3", "datapath", "mathexpr", "matrix"].each do |f|
  require ["datatype", f].join "/"
end
  
module Kefir
  class << self
    def eval(expr)
      # String is either expression or file path
      if expr.kind_of? ::String
        if ::File.file?(expr)
          return DataPath.new(expr)
        end
        # arithmatic expression
        return MathExpr.new(expr)
      end
      if expr.kind_of? ::Array
        return Array2.new(expr) if Array2.accept?(expr)
        return Array3.new(expr) if Array3.accept?(expr)
      end
      if expr.kind_of? ::Matrix
        return Kefir::Matrix.new(expr) if Kefir::Matrix.accept?(expr)
      end
      raise "#{expr} is not a supported data expression"
    end
  end
end
