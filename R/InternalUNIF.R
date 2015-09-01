.dunif = function(x, mu, sigma, var.adj, log) {
  if(var.adj) sigma = sqrt(3) * sigma
  return(dunif(x, mu-sigma, mu+sigma, log))
}

.punif = function(quant, mu, sigma, var.adj, lower.tail, log.p) {
  if(var.adj) sigma = sqrt(3) * sigma
  return(punif(quant, mu-sigma, mu+sigma, lower.tail, log.p))
}

.qunif = function(prob, mu, sigma, var.adj, lower.tail, log.p) {
  if(var.adj) sigma = sqrt(3) * sigma
  return(qunif(prob, mu-sigma, mu+sigma, lower.tail, log.p))
}
