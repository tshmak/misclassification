function theta = inversepercentile(p, init)
if nargin == 1
    init = 0;
end
global setts
options = optimset('TolX', setts.tol.inversepercentile.TolX, ...
    'Display', setts.Display.fzero);
[theta, value, exitflag] = fzero(@(x) findpercentile(x) - p, init, options);
if exitflag ~= 1
    error('Something wrong with fsolve')
end
end
