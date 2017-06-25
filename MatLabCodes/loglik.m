function [ll, g, H] = loglik(theta) 
global setts

% Evaluate ll
logit_pi1 = logit(setts.pi0) + theta;
pi1 = invlogit(logit_pi1);
oneminuspi1 = 1 - pi1;
pp = pi1 .* setts.sens1 + (1-pi1) .* (1-setts.spec1);
oneminuspp = 1 - pp;
ll = setts.Ex .* reallog(pp) + setts.NEx .* reallog(oneminuspp);

if nargout > 1 
    dllbydp = setts.Ex ./ pp - setts.NEx ./ (oneminuspp);
    dpbydpi = setts.sens1 + setts.spec1 - 1;
    dpibydlogitpi = pi1 .* oneminuspi1 ;
    g = dpbydpi .* dllbydp .* dpibydlogitpi;
end

if nargout > 2
    dllbydp_sq = dllbydp .^2;
    d2pibydlogitpi2 = 1./(1./oneminuspi1.^2 - 1./pi1.^2);
    dpibydlogitpi_sq = dpibydlogitpi .^2;
    d2llbydp2 = -(setts.Ex ./ pp.^2 + setts.NEx ./ oneminuspp.^2);
    H = dpbydpi.^2 .* (dllbydp .* d2pibydlogitpi2 + ...
        dpibydlogitpi.^2 .* d2llbydp2);
end

end
