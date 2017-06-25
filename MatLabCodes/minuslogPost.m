function [lPost, gradient, Hessian] = minuslogPost(theta) 
if nargout <= 1 
    [lP] = logPost(theta);
elseif nargout == 2
    [lP g] = logPost(theta);
elseif nargout == 3
    [lP g H] = logPost(theta);
end
    
lPost = -lP;

% Evaluate gradient 
if nargout > 1 
    gradient = -g;
end

% Evaluate Hessian
if nargout > 2
    Hessian = -H;
end
end
