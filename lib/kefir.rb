require "matrix"

["datatype"].each do |f|
  thisdir = File.expand_path File.dirname __FILE__
  require [thisdir, f].join "/"
end

module Kefir
  
  class << self
    public
    def open(&proc)
      IO.popen("gnuplot", "w") do |io|
        main = Main.new(io)
        yield gp
        main.terminate()
      end
    end
  end

  class Main
    def initialize(io)
      @io = io
      @plot = nil
    end

    def plot(expr, &proc)
      @plot = Plot.new("plot")
      yield @plot
      self
    end

    def splot(expr, &proc)
      @plot = Plot.new("splot")
      yield @plot
      self
    end

    def <<(line)
      @io << line
      self
    end

    def set(option, value)
      @io << "set #{option} #{value}\n"
      self
    end

    def unset(option)
      if pre_version4?
        set "no#{option}\n"
        self
      end
      @io << "unset #{option}\n"
      self
    end

    def terminate
      if @plot == nil
        raise "do plot"
      end
      @io << @plot.eval
    end

    private 
    def pre_version4?
      version = `gnuplot --version`.split(" ")[1] 
      return version.to_f < 4.0
    end
  end

  class Plot
    def initialize(name)
      @plotname = name
      @data = []
    end
    
    def <<(data)
      @data << data
    end

    def eval
      s = @plotname + " "
      plotline = @data.map { |d| d.data_expr + " " + d.options }.join ", "
      s << plotline << "\n"

      @data.each do |d|
        if d.inline_data == ""
          next
        end
        s << d.inline_data
        s << "e\n"
      end
      p s
      return s
    end
  end
end
