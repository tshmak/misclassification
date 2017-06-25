function addto_matrix4debug(obj, X)
    nrowsX = size(X,1);
    ncolsX = size(X,2);
    nrowsM4D = size(obj.matrix4debug,1);
    ncolsM4D = size(obj.matrix4debug,2);

    if isequal(obj.matrix4debug,[])
        obj.matrix4debug = X;
    elseif ncolsM4D < ncolsX
        colstoadd = ncolsX - ncolsM4D;
        obj.matrix4debug = [obj.matrix4debug ones(nrowsM4D, colstoadd)*NaN];
        obj.matrix4debug = [obj.matrix4debug ; X];
    elseif ncolsM4D > ncolsX
        colstoadd = ncolsM4D - ncolsX;
        X = [X ones(nrowsX, colstoadd)*NaN];
        obj.matrix4debug = [obj.matrix4debug ; X];
    else
        obj.matrix4debug = [obj.matrix4debug ; X];
    end
end