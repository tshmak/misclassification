function newparams = expand(obj, params)
    i = 1;
    newparams = [];
    if obj.limits.pi0.constant == 1
        newparams = [newparams obj.limits.pi0.lower];
    else
        newparams = [newparams params(i)];
        i = i+ 1;
    end
    if obj.limits.sens1.constant == 1
        newparams = [newparams obj.limits.sens1.lower];
    else
        newparams = [newparams params(i)];
        i = i+ 1;
    end
    if obj.limits.spec1.constant == 1
        newparams = [newparams obj.limits.spec1.lower];
    else
        newparams = [newparams params(i)];
        i = i+ 1;
    end
    if obj.limits.vartheta.constant == 1
        newparams = [newparams obj.limits.vartheta.lower];
    else
        newparams = [newparams params(i)];
        i = i+ 1;
    end
end