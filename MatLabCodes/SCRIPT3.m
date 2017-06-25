cd('/home1/tshmak/misclassification/MatLabCodes');
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
setts.limits.ppi_diff0 = limit(-0.07, 0.07);
setts.limits.sens0 = limit(0.25, 0.4);
setts.limits.spec0 = limit(0.8, 1);
setts.limits.sens_diff = limit(-0.07, 0.07);
setts.limits.spec_diff = limit(-0.07, 0.07);
setts.limits.pi0 = limit(0.15, 0.3);

ppi_diff0 = [-0.07 ; -0.02 ; 0.02 ; 0.07];
sens_diff = [-0.07 ; -0.02 ; 0.02 ; 0.07];
spec_diff = [-0.07 ; -0.02 ; 0.02 ; 0.07];
setts.Rseed = 1000;
for i=1:size(ppi_diff0,1)
    setts.limits.ppi_diff0 = limit(ppi_diff0(i), ppi_diff0(i));
    for j=1:size(sens_diff,1)
        setts.limits.sens_diff = limit(sens_diff(j), sens_diff(j));
        for k=1:size(spec_diff,1)
            setts.limits.spec_diff = limit(spec_diff(k), spec_diff(k));
            optimize('full',10)
        end
    end
end
A = dispresults(setts.results_history);
save 'SCRIPT3 results.txt' A -ASCII
exit

B = A(:,[1 7]);
C = [];
for i=1:(size(A,1)/4)
    baselinerow = (i-1)*4;
    startrow = baselinerow + 1;
    endrow = baselinerow + 4;
    selected = B(startrow:endrow, :);
    if B(1,1) == -1 
        result = min(selected(:,2)');
    else
        result = max(selected(:,2)');
    end
    C = [C ; result]
end
D = reshape(C, 4, []);
for i=1:16 
    baselinecol = (i-1)*4;
    startcol = baselinecol + 1;
    endcol = baselinecol + 4;
    E = D(:,startcol:endcol);
    fprintf('\n\\multirow{2}{*}{$sens=???$} & ');
    for j=1:4
        fprintf('[%5.2f, %5.2f] ', E(2,j), E(1,j));
        if j < 4 
            fprintf('& ');
        else
            fprintf('\\\\ ');
        end
    end
    fprintf('\n                             & ');
    for j=1:4
        fprintf('[%5.2f, %5.2f] ', E(4,j), E(3,j));
        if j < 4 
            fprintf('& ');
        else
            fprintf('\\\\ ');
        end
    end
end
    
return

setts.limits.ppi_diff0 = limit(0.05);
setts.limits.sens_diff = limit(-0.065);
setts.limits.spec_diff = limit(0.065);
optimize('full',1)
