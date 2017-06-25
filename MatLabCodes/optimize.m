function optimize(which, arg1, arg2)

    % If which == 'ci' or 'med', then 
    % arg1 can be either 'min' or 'max'
    % and arg2 is the number of repeats
    % If which == 'full', then
    % arg1 is the number of repeats and 
    % arg2 is ignored.

    global setts
    if isequal(setts.Rseed, []) 
        rng('shuffle');
        a = rng;
        setts.Rseed = a.Seed;
        fprintf('Random number seed %4.0f\n', setts.Rseed)
    else
        rng(setts.Rseed);
    end

    if nargin > 0 
        setts.recent_results = [];

        if nargin > 1 % Set default for minmax
            if strcmpi(arg1, 'min') == 1
                setts.minimize = true;
            elseif strcmpi(arg1, 'max') == 1
                setts.minimize = false;
            end
        else
            setts.minimize = false;
        end
        
        if strncmpi(which, 'med', 3) == 1
            setts.percentile = 0.5;
            if nargin < 3
                arg2 = 1;
            end
            rep_optimize2(arg2);

        elseif strcmpi(which, 'ci') == 1
            if setts.minimize == true
                    setts.percentile = 0.025;
            elseif setts.minimize == false
                setts.percentile = 0.975;
            end
            if nargin < 3
                arg2 = 1;
            end
            rep_optimize2(arg2);

        elseif strcmpi(which, 'full') == 1
            if nargin < 2
                arg1 = 1;
            end            
            setts.minimize = false;
            setts.percentile = 0.5;
            rep_optimize2(arg1);

            setts.minimize = true;
            rep_optimize2(arg1);

            setts.minimize = false;
            setts.percentile = 0.975;
            rep_optimize2(arg1);

            setts.minimize = true;
            setts.percentile = 0.025; 
            rep_optimize2(arg1);

        end
        tab_results(setts.recent_results)
        setts.results_history = [setts.results_history ; setts.recent_results];
        
    end
end
        


