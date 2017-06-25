classdef tol < handle
    properties
        AbsTol
        RelTol
        TolX
        TolFun
    end
    methods
        function Obj = tol(param1, value1, param2, value2, ...
                param3, value3, param4, value4)
            if nargin >= 2
                determine(Obj, param1, value1)
                if nargin >= 4
                    determine(Obj, param2, value2)
                    if nargin >=6
                        determine(Obj, param3, value3)
                        if nargin >= 8
                            determine(Obj, param4, value4)
                        end
                    end
                end
            end
        end
        function determine(obj, param, value)
            switch param
                case 'AbsTol'
                    obj.AbsTol = value;
                case 'RelTol'
                    obj.RelTol = value;
                case 'TolX'
                    obj.TolX = value;
                case 'TolFun'
                    obj.TolFun = value;
            end
        end
    end
end

        