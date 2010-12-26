require "kefir"

if __FILE__ == $0
  Kefir.open() do |gp|
    m = Matrix[
    [0,1,4,9],
    [1,2,5,10],
    [4,5,8,13],
    [9,10,13,18],
    [16,17,20,25],
    [25,26,29,34]]

    gp.splot do |plot|
      plot << Kefir.eval(m) do |d|
        d << 'matrix'
        d << 'with lines'
      end
    end 
  end  
end
