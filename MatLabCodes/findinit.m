function initvalues = findinit(seed)
    global setts
    if nargin == 1 
        rng(seed)
    end

    initsens1 = setts.limits.sens1.lower + setts.limits.sens1.range * rand();
    initspec1 = setts.limits.spec1.lower + setts.limits.spec1.range * rand();
    initpi0 = setts.limits.pi0.lower + setts.limits.pi0.range * rand();
    initvartheta = setts.limits.vartheta.lower + setts.limits.vartheta.range * rand();
        
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
    if setts.limits.vartheta.constant == 0
        initvalues = [initvalues initvartheta];
    end
            
end
