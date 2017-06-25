function [valuemat, xx, yy] = contourplot(nx, ny, nodraw)
    global setts
    if setts.nparams ~= 2
        error('Number of variables to be optimized must be 2')
    end
    if nargin < 3
        nodraw = 0;
        if nargin < 2
            ny = 10;
            if nargin < 1
                nx = 10;
            end
        end
    end
    
    if isequal(nx, [])
        nx = 10;
    end
    if isequal(ny, [])
        ny = 10;
    end
    
    valuemat = ones(ny,nx) .* NaN;
    for x=1:nx 
        i = setts.shortened_limits(1,1) + (x-1)/(nx-1) * ...
            (setts.shortened_limits(1,2) - setts.shortened_limits(1,1));
        for y=1:ny
            j = setts.shortened_limits(2,1) + (y-1)/(ny-1) * ...
                (setts.shortened_limits(2,2) - setts.shortened_limits(2,1));
            valuemat(y,x) = evaluate([i j]);
        end
    end
    xx = setts.shortened_limits(1,1) + ((1:nx)-1)./(nx-1) .* ...
        (setts.shortened_limits(1,2) - setts.shortened_limits(1,1));
    yy = setts.shortened_limits(2,1) + ((1:ny)-1)./(ny-1) .* ...
        (setts.shortened_limits(2,2) - setts.shortened_limits(2,1));
    
    if isequal(nodraw,1) 
        return 
    end
        
    contourf(xx, yy, valuemat, 20)
    xlabel(setts.params_optimized(1))
    ylabel(setts.params_optimized(2))
    colorbar
    
end