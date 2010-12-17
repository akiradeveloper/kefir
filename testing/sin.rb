require "gnuplot"

if __FILE__ == $0
  Gnuplot.open() do |gp|
    gp
    .set("xrange", "[0:10]")
    .set("yrange", "[-0.5:0.5]")
    .plot("sin(x)") do |plot|
      plot
      .option("with lines")
    end 
  end  
end
