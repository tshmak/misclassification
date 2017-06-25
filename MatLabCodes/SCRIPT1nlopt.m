clear all
global setts
setts = settings;
setts.Ex = 83;
setts.NEx = 267;
% setts.Prior_mean_theta = 0; 

setts.limits.vartheta = limit(0.5);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.pi0 = limit(0.15, 0.3);

setts.Rseed = 1000;
setts.algorithm = 'nlopt';
setts.subalgorithm = NLOPT_LN_COBYLA;

optimize('med', 'max', 2)
return

% Contourplots for max theta_M

% max theta_M
setts.minimize = false;
setts.percentile = 0.5;
setts.limits.spec1 = limit(1);
[graph1, graph1pi0, graph1sens1] = contourplot([],[],1);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.sens1 = limit(0.25);
[graph2, graph2pi0, graph2spec1] = contourplot([],[],1);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.pi0 = limit(0.15);
[graph3, graph3sens1, graph3spec1] = contourplot([],[],1);
setts.limits.pi0 = limit(0.15, 0.3);

contourplotsscript
saveas(1, 'D:/Work2012/misclassification/contour1a.pdf');

% min theta_M
setts.minimize = true;
setts.percentile = 0.5;
setts.limits.spec1 = limit(0.8);
[graph1, graph1pi0, graph1sens1] = contourplot([],[],1);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.sens1 = limit(0.4);
[graph2, graph2pi0, graph2spec1] = contourplot([],[],1);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.pi0 = limit(0.3);
[graph3, graph3sens1, graph3spec1] = contourplot([],[],1);
setts.limits.pi0 = limit(0.15, 0.3);

contourplotsscript
saveas(1, 'D:/Work2012/misclassification/contour1b.pdf');

% max theta_U
setts.minimize = false;
setts.percentile = 0.975;
setts.limits.spec1 = limit(1);
[graph1, graph1pi0, graph1sens1] = contourplot([],[],1);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.sens1 = limit(0.25);
[graph2, graph2pi0, graph2spec1] = contourplot([],[],1);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.pi0 = limit(0.15);
[graph3, graph3sens1, graph3spec1] = contourplot([],[],1);
setts.limits.pi0 = limit(0.15, 0.3);

contourplotsscript
saveas(1, 'D:/Work2012/misclassification/contour1c.pdf');

% min theta_L
setts.minimize = true;
setts.percentile = 0.025;
setts.limits.spec1 = limit(0.8);
[graph1, graph1pi0, graph1sens1] = contourplot([],[],1);
setts.limits.spec1 = limit(0.8, 1);
setts.limits.sens1 = limit(0.4);
[graph2, graph2pi0, graph2spec1] = contourplot([],[],1);
setts.limits.sens1 = limit(0.25, 0.4);
setts.limits.pi0 = limit(0.3);
[graph3, graph3sens1, graph3spec1] = contourplot([],[],1);
setts.limits.pi0 = limit(0.15, 0.3);

contourplotsscript
saveas(1, 'D:/Work2012/misclassification/contour1d.pdf');
