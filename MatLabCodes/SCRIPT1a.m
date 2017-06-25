clear all
global setts
setts = settings;
setts.Ex = 83;
setts.NEx = 267;
% setts.Prior_mean_theta = 0; 

setts.limits.vartheta = limit(0.3, 0.7);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.pi0 = limit(0.15, 0.3);

setts.Rseed = 1000;
optimize('full', 4)
return
