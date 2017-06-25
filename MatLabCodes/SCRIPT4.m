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
setts.limits.pi0 = limit(0.15, 0.3);

sens = [0.25 0.4 ; 0.4 0.6 ; 0.6 0.8];
spec = [0.8 0.85 ; 0.85 0.9 ; 0.9 0.95 ; 0.95 1];
setts.Rseed = 1000;
for i=1:size(sens,1)
    setts.limits.sens0 = limit(sens(i,1), sens(i,2));
    setts.limits.sens1 = limit(sens(i,1), sens(i,2));
    for j=1:size(spec,1)
        setts.limits.spec0 = limit(spec(j,1), spec(j,2));
        setts.limits.spec1 = limit(spec(j,1), spec(j,2));
        optimize('full',4)
    end
end
A = dispresults(setts.results_history);
save 'SCRIPT4 results.txt' A -ASCII
end

B = A(:,[1 7 8]);

C = [];
C2 = [];
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
    C2 = [C2 ; max(selected(:,3)')];
    C = [C ; result];
end
D = reshape(C, 4, []);
D2 = reshape(C2, 4, []);
for i=1:size(sens,1) 
    baselinecol = (i-1)*4;
    startcol = baselinecol + 1;
    endcol = baselinecol + 4;
    E = D(:,startcol:endcol);
    E2 = D2(:,startcol:endcol);
    fprintf('\n\\multirow{2}{*}{$sens=???$} & ');
    for j=1:4
        if min(E2(1:2,j)') > 0 
            fprintf('[%5.2f, %5.2f] ', E(2,j), E(1,j));
        else
            fprintf('Not possible ');
        end
        if j < 4 
            fprintf('& ');
        else
            fprintf('\\\\ ');
        end
    end
    fprintf('\n                             & ');
    for j=1:4
        if min(E2(3:4,j)') > 0 
            fprintf('[%5.2f, %5.2f] ', E(4,j), E(3,j));
        else
            fprintf('Not possible ');
        end
        if j < 4 
            fprintf('& ');
        else
            fprintf('\\\\ ');
        end
    end
end
    
return
