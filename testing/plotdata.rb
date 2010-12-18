require "gnuplot"

if __FILE__ == $0
  Gnuplot.open() do |gp|
    thisdir = File.dirname __FILE__
    gp
    .plot("#{thisdir}/test.dat") do |plot|
      plot
      .option("with lines")
      .option("title \"unko\"")
    end 
  end  
end
