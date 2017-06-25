classdef limits
    properties
        pi0 = limit(0,1);
        p0 = limit(0,1);
        sensminusspec = limit(-1,1);
        sens0 = limit(0,1);
        sens1 = limit(0,1);
        spec0 = limit(0,1);
        spec1 = limit(0,1);
        sens_diff = limit(-1,1);
        spec_diff = limit(-1,1);
        sens_logOR = limit(-Inf,Inf);
        spec_logOR = limit(-Inf,Inf);
        sensspec1 = limit(0,2);
        sensspec0 = limit(0,2);
        ppi_logOR0 = limit(-Inf,Inf);
        ppi_diff0 = limit(-1,1);
        vartheta = limit(0,10000);
    end
end

