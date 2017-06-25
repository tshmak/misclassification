function [value, withinlimits, c] = evaluate(params)

    global setts

    if size(params, 2) ~= setts.nparams
        error('Dimension of params does not match setts.nparams')
    end
    
    c = findpenalty(params);
    withinlimits = max(c) <= 0;
    if withinlimits == 0
        value = NaN;
        return
    else
        value = setts.negate * tobeoptimized(params);
    end
end