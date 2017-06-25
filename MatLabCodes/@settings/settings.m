classdef settings < handle
    properties 
        % Unchangeable data
        Ex 
        NEx

        Prior_mean_theta = 0;
        
        % Initial values
        maxtryinit = 500;
        initvalues
        Rseed
 
        % settings
        minimize = false;
        object = 'percentile';
        percentile = 0.5;
        
        % Debug
        debug = 0; % for findpenalty
        Trace = Trace;
        Display = Display;

        % structures/classes
        limits = limits;
        tol = tolerances;
        recent_results
        results_history 
        results
 
        % Algorithms
        algorithm = 'fmincon';
        subalgorithm = 'active-set';
        quadraturemethod = 'quadgk';
               
    end
    properties (Access = public)
        % updatable data
        sens1 = 1; 
        spec1 = 1;
        pi0 = 0.5; 
        vartheta = 1;
    end
    properties (SetAccess = private)
        % debug
         matrix4debug
         % Random number seed
    end
    properties (Dependent = true)
        sensspec1
        lowerbound
        upperbound
        nparams
        params_optimized
        params_fixed
        minimize_text
        negate
        shortened_limits
    end
    
    methods
        function sensspec1 = get.sensspec1(obj)
            sensspec1 = obj.sens1 + obj.spec1;
        end
        function lower = get.lowerbound(obj)
            lower = [];
            if obj.limits.pi0.constant == 0
                lower = [lower ; obj.limits.pi0.lower];
            end
            if obj.limits.sens1.constant == 0
                lower = [lower ; obj.limits.sens1.lower];
            end
            if obj.limits.spec1.constant == 0
                lower = [lower ; obj.limits.spec1.lower];
            end
            if obj.limits.vartheta.constant == 0
                lower = [lower ; obj.limits.vartheta.lower];
            end
        end
        function upper = get.upperbound(obj)
            upper = [];
            if obj.limits.pi0.constant == 0
                upper = [upper ; obj.limits.pi0.upper];
            end
            if obj.limits.sens1.constant == 0
                upper = [upper ; obj.limits.sens1.upper];
            end
            if obj.limits.spec1.constant == 0
                upper = [upper ; obj.limits.spec1.upper];
            end
            if obj.limits.vartheta.constant == 0
                upper = [upper ; obj.limits.vartheta.upper];
            end
        end
        function nparams = get.nparams(obj)
            nparams = (obj.limits.pi0.constant == 0) + ...
                (obj.limits.sens1.constant == 0) + ...
                (obj.limits.spec1.constant == 0) + ...
                (obj.limits.vartheta.constant == 0);
        end
        function objvector = get.params_optimized(obj)
            objvector = listparams(obj, 0);
        end
        function objvector = get.params_fixed(obj)
            objvector = listparams(obj, 1);
        end
        function text = get.minimize_text(obj)
            if obj.minimize == 1
                text = 'min';
            else 
                text = 'max';
            end
        end
        function negate = get.negate(obj)
            if obj.minimize == 1
                negate = 1;
            else 
                negate = -1;
            end
        end
        function matrix = get.shortened_limits(obj)
            matrix = [];
            if obj.limits.pi0.constant == 0
                matrix = [matrix ; [obj.limits.pi0.lower obj.limits.pi0.upper]];
            end
            if obj.limits.sens1.constant == 0
                matrix = [matrix ; [obj.limits.sens1.lower obj.limits.sens1.upper]];
            end
            if obj.limits.spec1.constant == 0
                matrix = [matrix ; [obj.limits.spec1.lower obj.limits.spec1.upper]];
            end            
            if obj.limits.vartheta.constant == 0
                matrix = [matrix ; [obj.limits.vartheta.lower obj.limits.vartheta.upper]];
            end            
        end

    end
end
            
