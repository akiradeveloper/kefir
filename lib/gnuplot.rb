require "matrix"
require "tempfile"

module Gnuplot
  class << self
    private
  end

  module_function
  def open(&proc)
    IO.popen("gnuplot", "w") do |io|
      gp = Gnuplot_Main.new(io)
      yield gp
      gp.terminate()
    end
  end

  class Gnuplot_Main
    def initialize(io)
      @io = io
      @plot = []
    end

    def plot(expr, &proc)
      @plotname = "plot"
      p = Plot.new make_plot_data(expr)
      yield p
      @plot << p 
      return self
    end

    def splot(expr, &proc)
      @plotname = "splot"
      p = Plot.new make_plot_data(expr)
      yield p
      @plot << p
      return self
    end

    def set(option, value)
      @io << "set #{option} #{value}\n"
      return self
    end

    def unset(option)
      if pre_version4?
        set "no#{option}"
        return self
      end
      @io << "unset #{option}\n"
      return self
    end

    def terminate
      s = "#{@plotname} "
      s += @plot.map { |p| p.plot_line }.join ", "
      s += "\n"
      @io << s
    end

    private 
    def pre_version4?
      version = `gnuplot --version`.split(" ")[1] 
      return version.to_f < 4.0
    end

    def make_plot_data(expr)
      if File.file?(expr)
        return "\"#{expr}\""
      end
      # mathimatic expression
      if expr.kind_of? String
        return expr
      end
      if expr.kind_of? Array
        return Gnuplot_Array2.new(expr).filename if Gnuplot_Array2.accept?(expr)
        return Gnuplot_Array3.new(expr).filename if Gnuplot_Array3.accept?(expr)
      end
      if expr.kind_of? Matrix
        return Gnuplot_Matrix.new(expr).filename if Gnuplot_Matrix.accept?(expr)
      end
      raise "Not supported data expression"
    end

    class Gnuplot_Array2
      def Gnuplot_Array2.accept?(expr)
        unless expr.kind_of? Array 
          return false
        end        
        unless expr.size() == 2
          return false
        end
        return true
      end

      def initialize(expr)
        @f = Tempfile.new("gnuplot")
        xs = expr[0]
        ys = expr[1]
        expr.each_index do |i|
          @f.write "#{xs[i]} #{ys[i]}\n" 
        end
        @f.close
      end

      def filename
        return "\"#{@f.path}\""
      end
    end

    class Gnuplot_Array3
      def Gnuplot_Array3.accept?(expr)
        unless expr.kind_of? Array 
          return false
        end        
        unless expr.size() == 3
          return false
        end
        return true
      end
      def initialize(expr)
        @f = Tempfile.new("gnuplot")
        xs = expr[0]
        ys = expr[1]
        zs = expr[2]
        expr.each_index do |i|
          @f.write "#{xs[i]} #{ys[i]} #{zs[i]}\n" 
        end
        @f.close
      end

      def filename
        return "\"#{@f.path}\""
      end
    end

    class Gnuplot_Matrix
      def Gnuplot_Matrix.accept?(expr)
        return expr.kind_of? Matrix
      end
        
      def initialize(expr)
        @f = Tempfile.open("gnuplot")
        (0...expr.row_size).each do |i|
          row = []
          (0...expr.column_size).each do |j|
            row << expr[i, j] 
            @f.write(row.join(" "))
            @f.write("\n")
          end
        end
        @f.close
      end

      def filename
        return "\"#{@f.path}\""
      end
    end
  end

  class Plot
    def initialize(data)
      @data = data
      @option = []
    end

    def option(option)
      @option << option
      return self
    end

    def plot_line
      s = "#{@data}"
      @option.each do |opt|
        s += " #{opt}"
      end
      return s
    end
  end
end
