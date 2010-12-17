require "gnuplot"

if __FILE__ == $0
  Gnuplot.open() do |gp|
    m = Matrix[
    [0,1,4,9],
    [1,2,5,10],
    [4,5,8,13],
    [9,10,13,18],
    [16,17,20,25],
    [25,26,29,34]]

    gp.splot(m) do |plot|
      plot
      .option("matrix")
      .option("with lines")
      p plot
    end 
  end  
end
