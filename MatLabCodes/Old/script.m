clear all
global setts
setts = settings;
setts.Ex = 0.5;
setts.NEx = 100;
setts.sens1 = 0.9;
setts.spec1 = 0.99;
setts.pi0 = 0.01;
% setts.Prior_mean_theta = 0; 
% setts.Prior_var_theta = 1;
setts.inittheta = 0; 
return

setts.limits.sens1 = limit(0.15, 0.95);
setts.limits.spec1 = limit(0.95, 1);
setts.limits.sens0 = limit(0.15, 0.95);
setts.limits.spec0 = limit(0.95, 1);
setts.limits.pi0 = limit(0.01, 0.05);
setts.limits.sensspec1 = limit(1.2, 1.5);
setts.limits.p0 = limit(0.01, 0.05);
setts.limits.ppi_diff0 = limit(-0.01, 0.01);
setts.limits.sens_diff = limit(-0.01, 0.01);
setts.limits.spec_diff = limit(-0.01, 0.01);

initvalues = findinit(6);
options = optimset('Algorithm', 'active-set', 'AlwaysHonorConstraints', 'bounds');
setts.minimize = false;
lowerbound = [setts.limits.pi0.lower ; setts.limits.sens1.lower ; setts.limits.spec1.lower];
upperbound = [setts.limits.pi0.upper ; setts.limits.sens1.upper ; setts.limits.spec1.upper];
fmincon(@tobeoptimized,initvalues,[],[],[],[],lowerbound,upperbound, @findpenalty, options) 


