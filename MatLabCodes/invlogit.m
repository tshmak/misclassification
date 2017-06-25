function p = invlogit(x)

    p = 1 ./ (1 + exp(-x)); 
    nanvector = isnan(p);
    n_nan = sum(reshape(nanvector,1,[]));
    if n_nan > 0 
        y=exp(x(nanvector));
        p2=y ./ (1+y);
        p(nanvector) = p2;
    end
end
