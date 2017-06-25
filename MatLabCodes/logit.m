function x=logit(p)
    x = reallog(p) - reallog(1-p);
end