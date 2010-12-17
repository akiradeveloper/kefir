require "gnuplot"

if __FILE__ == $0
  Gnuplot.open() do |gp|
    gp
    .set("xrange", "[0:5]")
    .plot([[0,1], [1,2]]) do |plot|
      plot
      .option("with lines")
      .option("title \"unko\"")
    end 
  end  
end
