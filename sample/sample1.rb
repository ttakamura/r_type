require File.expand_path('../../lib/r_type', __FILE__)

R.run do
  print (cos(0) - sqrt(2)) / exp(4)

  x = (1..5).to_a
  print sqrt(x)
  print log(x)

  self.x2 = [1, 2, 3, 4, 5, 3]
  self.y2 = [1, 3, 2, 4, 5, 3]
  print summary(x2)
  print cor(x2, y2)
  print diff(y2)
  print cumsum(x2)

  print x2 + y2
  print x2 - y2
  print x2 + 10
  print x2 * y2
end
# >> [1] -0.007586586
# >> [1] 1.000000 1.414214 1.732051 2.000000 2.236068
# >> [1] 0.0000000 0.6931472 1.0986123 1.3862944 1.6094379
# >>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# >>    1.00    2.25    3.00    3.00    3.75    5.00
# >> [1] 0.9
# >> [1]  2 -1  2  1 -2
# >> [1]  1  3  6 10 15 18
# >> [1]  2  5  5  8 10  6
# >> [1]  0 -1  1  0  0  0
# >> [1] 11 12 13 14 15 13
# >>      [,1]
# >> [1,]   63
