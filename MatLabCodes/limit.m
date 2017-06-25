classdef limit
    properties
        lower
        upper
    end
    properties (Dependent = true, SetAccess = private)
        range
        constant
    end
    methods
        function Limit = limit(l,u)
            if nargin == 2
                if l > u 
                    error('Lower limit must not be greater than upper')
                end
                Limit.lower = l;
                Limit.upper = u;
            elseif nargin == 1
                Limit.lower = l;
                Limit.upper = l;
            end
        end
        function range = get.range(obj)
            range = obj.upper - obj.lower;
        end
        function constant = get.constant(obj)
            constant = obj.upper == obj.lower;
        end
    end
end