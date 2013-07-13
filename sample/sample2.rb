require File.expand_path('../../lib/r_type', __FILE__)

R.run do
  x = (0..4).to_a

  double = eval_R <<-RSRC
    function (x) x * 2
  RSRC

  print double(10)
  print sapply(x, double)
  pow = `function(x) x ^ 2`
  print sapply(x, pow)

  f = `function(x) exp(x) - 2`
  print uniroot(f, [0, 1])

  print polyroot([2, 3, 1])
  print integrate(pow, 0, 1)
end
# >>  [1] 0 0 0 0 0 0 0 0 0 0
# >> [1] 0 2 4 6 8
# >> [1]  0  1  4  9 16
# >> $root
# >> [1] 0.6931457
# >>
# >> $f.root
# >> [1] -2.943424e-06
# >>
# >> $iter
# >> [1] 5
# >>
# >> $estim.prec
# >> [1] 6.103516e-05
# >>
# >> [1] -1+0i -2-0i
# >> 0.3333333 with absolute error < 3.7e-15
# >> 0.9772499 with absolute error < 1.6e-06
