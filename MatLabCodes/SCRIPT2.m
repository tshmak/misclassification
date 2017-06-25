clear all
global setts
setts = settings;
setts.Ex = 83;
setts.NEx = 267;
% setts.Prior_mean_theta = 0; 

setts.limits.vartheta = limit(0.3, 0.7);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.p0 = limit(0.2, 0.25);
setts.limits.ppi_diff0 = limit(-0.05, 0.05);
setts.limits.sens0 = limit(0.25, 0.4);
setts.limits.spec0 = limit(0.8, 1);
setts.limits.sens_diff = limit(-0.05, 0.05);
setts.limits.spec_diff = limit(-0.05, 0.05);

setts.Rseed = 1000;
optimize('full', 10)
return

% Contourplots for max theta_M
npoints = 50
% max theta_M
setts.limits.pi0 = limit(0.15, 0.3);
setts.minimize = false;
setts.percentile = 0.5;
setts.limits.spec1 = limit(0.8693);
[graph1, graph1pi0, graph1sens1] = contourplot(npoints,npoints,1);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.sens1 = limit(0.2591);
[graph2, graph2pi0, graph2spec1] = contourplot(npoints,npoints,1);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.pi0 = limit(0.15);
[graph3, graph3sens1, graph3spec1] = contourplot(npoints,npoints,1);
setts.limits.pi0 = limit(0.15, 0.3);

contourplotsscript
saveas(1, 'P:/misclassification/contour2a.pdf');

% min theta_M
setts.limits.pi0 = limit(0.15, 0.3);
setts.minimize = true;
setts.percentile = 0.5;
setts.limits.spec1 = limit(0.8);
[graph1, graph1pi0, graph1sens1] = contourplot(npoints,npoints,1);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.sens1 = limit(0.4);
[graph2, graph2pi0, graph2spec1] = contourplot(npoints,npoints,1);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.pi0 = limit(0.3);
[graph3, graph3sens1, graph3spec1] = contourplot(npoints,npoints,1);
setts.limits.pi0 = limit(0.15, 0.3);

contourplotsscript
saveas(1, 'P:/misclassification/contour2b.pdf');

% max theta_U
setts.limits.pi0 = limit(0.15, 0.3);
setts.minimize = false;
setts.percentile = 0.975;
setts.limits.spec1 = limit(0.8676);
[graph1, graph1pi0, graph1sens1] = contourplot(npoints,npoints,1);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.sens1 = limit(0.25);
[graph2, graph2pi0, graph2spec1] = contourplot(npoints,npoints,1);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.pi0 = limit(0.15);
[graph3, graph3sens1, graph3spec1] = contourplot(npoints,npoints,1);
setts.limits.pi0 = limit(0.15, 0.3);

contourplotsscript
saveas(1, 'P:/misclassification/contour2c.pdf');

% min theta_L
setts.limits.pi0 = limit(0.15, 0.3);
setts.minimize = true;
setts.percentile = 0.025;
setts.limits.spec1 = limit(0.8);
[graph1, graph1pi0, graph1sens1] = contourplot(npoints,npoints,1);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.sens1 = limit(0.4);
[graph2, graph2pi0, graph2spec1] = contourplot(npoints,npoints,1);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.pi0 = limit(0.3);
[graph3, graph3sens1, graph3spec1] = contourplot(npoints,npoints,1);
setts.limits.pi0 = limit(0.15, 0.3);

contourplotsscript
saveas(1, 'P:/misclassification/contour2d.pdf');
