require "gnuplot"

if __FILE__ == $0
  Gnuplot.open() do |gp|
    gp.splot([[0,1], [1,2], [3,4]]) do |plot|
      plot
      .option("title \"unko\"")
      .option("with lines")
    end 
  end  
end
