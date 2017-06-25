function newparams = shorten(obj, params)
    newparams = [];
    if obj.limits.pi0.constant == 0
        newparams = [newparams params(1)];
    end
    if obj.limits.sens1.constant == 0
        newparams = [newparams params(2)];
    end
    if obj.limits.spec1.constant == 0
        newparams = [newparams params(3)];
    end
    if obj.limits.vartheta.constant == 0
        newparams = [newparams params(4)];
    end
end