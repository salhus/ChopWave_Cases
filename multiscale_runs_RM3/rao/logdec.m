function[zeta] = logdec(x1,x2,n)


del = (1/n)*log(x1./x2);
zeta = 1./sqrt(1 + (2*pi./del)^2);