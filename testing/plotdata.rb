require "kefir"

if __FILE__ == $0
  Kefir.open() do |gp|
    thisdir = File.dirname __FILE__
    gp.plot do |plot|
      plot << Kefir.eval("\"#{thisdir}/test.dat.testing\"") do |d|
        d << 'with lines'
        d << 'title "unko"'
      end
    end 
  end  
end
