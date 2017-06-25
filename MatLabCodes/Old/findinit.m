function initvalues = findinit(seed)
    global setts
    if nargin == 1 
        rng(seed)
    end
    pass = 0;
    ntries = 0;
    while pass == 0  
        initsens1 = setts.limits.sens1.lower + setts.limits.sens1.range * rand();
        initspec1 = setts.limits.spec1.lower + setts.limits.spec1.range * rand();
        initpi0 = setts.limits.pi0.lower + setts.limits.pi0.range * rand();
        test = [initpi0 initsens1 initspec1];
        c = findpenalty(test);
        pass = max(c) <= 0;
        ntries = ntries + 1;
        if ntries > setts.maxtryinit
            error('Cannot find valid initial values')
        end
    end
    initvalues = [];
    if setts.limits.pi0.constant == 0
        initvalues = [initvalues initpi0];
    end
    if setts.limits.sens1.constant == 0
        initvalues = [initvalues initsens1];
    end
    if setts.limits.spec1.constant == 0
        initvalues = [initvalues initspec1];
    end
            
end
