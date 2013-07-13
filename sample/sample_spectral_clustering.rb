require File.expand_path('../../lib/r_type', __FILE__)

R.run do
  library("kernlab") # install.package("kernlab")
  data("spirals")

  cluster = specc spirals, centers:2
  plot spirals, col: cluster, xlab:'', ylab:''

  gets
end
