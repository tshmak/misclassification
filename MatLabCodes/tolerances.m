classdef tolerances
    properties
        findpercentile = tol('AbsTol', 0, 'RelTol', 1e-7);
        inversepercentile = tol('TolX', 1e-6);
    end
end
