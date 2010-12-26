require "kefir"

if __FILE__ == $0
  Kefir.open() do |gp|
    gp.splot() do |plot|
      plot << Kefir.eval([[0,1], [1,2], [3,4]]) do |d|
        d << "title \"unko\""
        d << "with lines"
      end
    end 
  end  
end
