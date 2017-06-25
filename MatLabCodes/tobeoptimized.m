function [value] = tobeoptimized(shortened_params)
global setts;
params = expand(setts, shortened_params);
setts.pi0 = params(1,1); 
setts.sens1 = params(1,2); 
setts.spec1 = params(1,3);
setts.vartheta = params(1,4);

if strcmp(setts.object,'mode')
    [theta, ll, exitflag] = Postmaxest();
elseif strcmp(setts.object,'median')
    theta = inversepercentile(0.5);
elseif strcmp(setts.object,'percentile')
    theta = inversepercentile(setts.percentile);
else
    error('Unknown setts.object');
end

value = setts.negate * theta; 
if setts.Trace.optimization >= 1
    fprintf('pi0, sens1, spec1\n')
    params
    setts.negate * value
end
end

