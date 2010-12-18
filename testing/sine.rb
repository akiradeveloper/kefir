require "gnuplot"

#    .set("output", "\"sine_and_constant.jpeg\"")
#    .set("terminal", "jpeg")
if __FILE__ == $0
  Gnuplot.open() do |gp|
    gp
    .set("title", "\"unko\"")
    .set("xrange", "[0:10]")
    .set("yrange", "[-2.0:2.0]")
    .plot("sin(x)") do |plot|
      plot
      .option("with lines")
    end
    .plot("0.1 * x") do |plot|
      plot
      .option("with points")
    end 
  end  
end
