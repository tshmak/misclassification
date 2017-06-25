classdef results
    properties
        params
        value
        exitflag
        params_optimized
        params_fixed
        minimize
        percentile
        objective
        pi0_fixed
        sens1_fixed
        spec1_fixed
        vartheta_fixed
        params_full
        initvalues
        time
        output
        lambda
    end
    properties (Dependent = true)
        active_constraints
    end
    methods
        function resmatrix = dispresults(obj, full)
            if nargin == 1 
                full = 0;
            end

            nrecords = size(obj,1);
            for i = 1:nrecords 
                if i == 1
                    resmatrix = dispresults2(obj, full, i);
                else 
                    resmatrix = [resmatrix ; dispresults2(obj, full, i)];
                end
            end
        end
        function A = dispresults2(obj, full, i)

            if obj(i).minimize == 1
                minmax = -1;
            else
                minmax = 1;
            end
            A = [minmax obj(i).percentile ];
            if full == 1
                A = [A obj(i).params_full];
            else
                j = 1;
                if obj(i).pi0_fixed == 1
                    A = [A NaN];
                else
                    A = [A obj(i).params(j)];
                    j = j+1;
                end
                if obj(i).sens1_fixed == 1
                    A = [A NaN];
                else
                    A = [A obj(i).params(j)];
                    j = j+1;
                end
                if obj(i).spec1_fixed == 1
                    A = [A NaN];
                else
                    A = [A obj(i).params(j)];
                    j = j+1;
                end        
                if obj(i).vartheta_fixed == 1
                    A = [A NaN];
                else
                    A = [A obj(i).params(j)];
                    j = j+1;
                end        
            end
            A = [A obj(i).value obj(i).exitflag obj(i).time];
        end
        function tab_results(obj, full)
            if nargin == 1 
                full = 0;
            end
            
            results_mat = dispresults(obj, full);
            fprintf('\nminmax  ptile    pi0  sens1  spec1 vartheta  value exitflag   time\n');
            fprintf('%6.0f  %5.3g %6.4g %6.4g %6.4g %8.4g %7.4g %8.0f %6.4g\n', results_mat');
        end
        function lambdas = get.active_constraints(obj)
            lambdas = obj.lambda;
            lambdas.lower = lambdas.lower > 0;
            lambdas.upper = lambdas.upper > 0;
            lambdas.eqlin = lambdas.eqlin > 0;
            lambdas.eqnonlin = lambdas.eqnonlin > 0;
            lambdas.ineqlin = lambdas.ineqlin > 0;
            lambdas.ineqnonlin = lambdas.ineqnonlin > 0;

            lambdas.lower = reshape(lambdas.lower,1,[]);
            lambdas.upper = reshape(lambdas.upper,1,[]);
            lambdas.eqlin = reshape(lambdas.eqlin,1,[]);
            lambdas.eqnonlin = reshape(lambdas.eqnonlin,1,[]);
            lambdas.ineqlin = reshape(lambdas.ineqlin,1,[]);
            lambdas.ineqnonlin = reshape(lambdas.ineqnonlin,1,[]);

            lower = [1:size(lambdas.lower,2)];
            upper = [1:size(lambdas.upper,2)];
            eqlin = [1:size(lambdas.eqlin,2)];
            eqnonlin = [1:size(lambdas.eqnonlin,2)];
            ineqlin = [1:size(lambdas.ineqlin,2)];
            ineqnonlin = [1:size(lambdas.ineqnonlin,2)];
            
            lambdas.lower = lower(lambdas.lower);
            lambdas.upper = upper(lambdas.upper);
            lambdas.eqlin = eqlin(lambdas.eqlin);
            lambdas.eqnonlin = eqnonlin(lambdas.eqnonlin);
            lambdas.ineqlin = ineqlin(lambdas.ineqlin);
            lambdas.ineqnonlin = ineqnonlin(lambdas.ineqnonlin);
            
        end
            
    end
end
