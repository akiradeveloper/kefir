require "kefir"

if __FILE__ == $0
  Kefir.open() do |gp|
    gp.set('xrange', '[0:5]')
    gp.plot do |plot|
      plot << Kefir.eval([[0,1], [1,2]]) do |d|
        d << 'with lines'
        d << 'title "unko"'
      end
    end 
  end  
end
