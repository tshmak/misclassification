function [lPost, gradient, Hessian] = logPost(theta) 
global setts
if nargout <= 1 
    ll = loglik(theta);
elseif nargout == 2
    [ll, g] = loglik(theta);
elseif nargout == 3
    [ll, g, H] = loglik(theta);
end
    
% Evaluate loglik
logPrior = -0.5 .* (theta - setts.Prior_mean_theta) .^2 ...
    ./ setts.vartheta;
lPost = ll + logPrior;

% Evaluate gradient 
if nargout > 1 
    gradient = g - theta ./ setts.vartheta;
end

% Evaluate Hessian
if nargout > 2
    Hessian = H - 1 ./ setts.vartheta; 
end

end
