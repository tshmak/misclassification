function [params, value, exitflag] = optimize2()
    global setts

    if isequal(setts.initvalues, [])
        setts.initvalues = findinit();
    end
    tic
     
    if strcmp(setts.algorithm, 'fmincon')
        options = optimset('Algorithm', setts.subalgorithm, ...
            'AlwaysHonorConstraints', 'bounds', ...
            'Display', setts.Display.optimization);
        [params, value, exitflag, output, lambda] = fmincon(@tobeoptimized,setts.initvalues, ...
            [],[],[],[], setts.lowerbound, setts.upperbound, @findpenalty, options);
        
        Results.output = output;
        Results.lambda = lambda;
        
    elseif strcmp(setts.algorithm, 'nlopt')
        options.algorithm = setts.subalgorithm;
        options.min_objective = @tobeoptimized;
        options.lower_bounds = setts.lowerbound';
        options.upper_bounds = setts.upperbound';
        %options.fc = {(@findpenalty)};
        options.xtol_rel = 1e-4;
        %options.fc_tol = 0 ; 
        [params, value, exitflag] = nlopt_optimize(options, setts.initvalues);
    end
    time = toc;
     
    
    Results = results;
    Results.params = params;
    Results.time = time;
    Results.value = setts.negate * value;
    Results.exitflag = exitflag;
    Results.params_optimized = setts.params_optimized;
    Results.params_fixed = setts.params_fixed;
    Results.minimize = setts.minimize;
    Results.percentile = setts.percentile;
    Results.objective = setts.object;
    Results.pi0_fixed = setts.limits.pi0.constant == 1;
    Results.sens1_fixed = setts.limits.sens1.constant == 1;
    Results.spec1_fixed = setts.limits.spec1.constant == 1;
    Results.vartheta_fixed = setts.limits.vartheta.constant == 1;
    Results.params_full = [setts.pi0 setts.sens1 setts.spec1 setts.vartheta];
    Results.initvalues = setts.initvalues;
    
    setts.results = Results;
    setts.initvalues = [];
    
    if isequal(setts.recent_results,[])
        setts.recent_results = Results;
    else
        setts.recent_results = [setts.recent_results ; Results];
    end
end
