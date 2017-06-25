function objvector = listparams(obj, onezero)
    objvector = {};
    if obj.limits.pi0.constant == onezero
        objvector = [objvector {'pi0'}];
    end
    if obj.limits.sens1.constant == onezero
        objvector = [objvector {'sens1'}];
    end
    if obj.limits.spec1.constant == onezero
        objvector = [objvector {'spec1'}];
    end
    if obj.limits.vartheta.constant == onezero
        objvector = [objvector {'vartheta'}];
    end
end