require "kefir"

if __FILE__ == $0
  Kefir.open() do |gp|
    gp << "set terminal jpeg"
    gp << 'set output "hoge.jpeg"'
    gp.splot() do |plot|
      plot << Kefir.eval([[0,1,2,3], [1,2,3,4], [3,4,101,7]]) do |d|
        d << "title \"unko\""
        d << "with lines"
      end
    end 
  end  
end
