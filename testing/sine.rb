require "kefir"

#    .set("output", "\"sine_and_constant.jpeg\"")
#    .set("terminal", "jpeg")
if __FILE__ == $0
  Kefir.open() do |gp|
    gp << "unko(x) = sin(x)"

    gp.set('title', '"unko"')
    gp.set('xrange', '[0:10]')
    gp.set('yrange', '[-2.0:2.0]')
    gp.plot do |plot|
      plot << Kefir.eval("unko(x)") do |d| 
        d << 'with lines'
      end
      plot << Kefir.eval("0.1*x") do |d|
        d << 'with points'
      end
      plot << Kefir.eval([[0,1], [1,2]]) do |d|
        d << 'with lines'
        d << 'title "unko"'
      end
    end
  end  
end
