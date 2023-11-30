clear all

M = 6;
mu = 50;

[XVerdadera,SVerdadera,VVerdadera, ... 
    EstimacionV,W] = EstimacionDelFiltro(M,mu);

EstimacionS = XVerdadera-EstimacionV;

figure()
hold on
for i = 1:M
    plot(W(i,:))
end

figure()
hold on
plot(SVerdadera)
plot(EstimacionS)
