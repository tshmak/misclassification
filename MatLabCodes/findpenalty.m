function [c, ceq] = findpenalty(shortened_params)
    global setts;
    params = expand(setts, shortened_params);
    sens1 = params(1,2);
	spec1 = params(1,3);
	pi0 = params(1,1);
	
	% Preliminary checks
	fixedparams = [pi0 ; sens1 ; spec1 ; sens1 + spec1 ; sens1 - spec1];
    fixedparams_lower = [setts.limits.pi0.lower ; setts.limits.sens1.lower ; ...
        setts.limits.spec1.lower ; setts.limits.sensspec1.lower ; ...
        setts.limits.sensminusspec.lower ];
    fixedparams_upper = [setts.limits.pi0.upper ; setts.limits.sens1.upper ; ...
        setts.limits.spec1.upper ; setts.limits.sensspec1.upper ; ...
        setts.limits.sensminusspec.upper ];

    pvec1 = [fixedparams fixedparams_lower];
	pvec2 = [fixedparams_upper fixedparams];
	penscore_vec1 = pvec1(:,1) - pvec1(:,2); %Rows 1-5
	penscore_vec2 = pvec2(:,1) - pvec2(:,2); %Rows 6-10

	% S(sens_0)
	extremecase = (sens1 >= 1 | sens1 <= 0) & (setts.limits.sens_logOR.lower > -Inf); 
	upper1 = sens1 - setts.limits.sens_diff.lower;
    if extremecase == 0 
        upper2 = 1/(1+exp(-(log(sens1) - log(1-sens1) - ...
            setts.limits.sens_logOR.lower)));	
    else
        upper2 = 1;
    end
    upper3 = setts.limits.sens0.upper;

	extremecase = (sens1 >= 1 | sens1 <= 0) & (setts.limits.sens_logOR.upper < Inf);
	lower1 = sens1 - setts.limits.sens_diff.upper;
    if extremecase == 0
        lower2 = 1/(1+exp(-(log(sens1) - log(1-sens1) - setts.limits.sens_logOR.upper))) ;
    else
        lower2 = 0;
    end
	lower3 = setts.limits.sens0.lower;

	Ssens_upper = [upper1 ; upper2 ; upper3];
	Ssens_lower = [lower1 ; lower2 ; lower3];
	pvec3 = [kron(Ssens_upper , [1;1;1]) kron([1;1;1], Ssens_lower)]; 	% Ssens_upper(1;1;1;2;2;2;...) - Ssens_lower(1;2;3;1;2;3;...)
	penscore_vec3 = pvec3(:,1) - pvec3(:,2)	;% Rows 11-19

	% S(spec_0)
	extremecase = (spec1 >= 1 | spec1 <= 0) & (setts.limits.spec_logOR.lower > -Inf);
	upper1 = spec1 - setts.limits.spec_diff.lower;
    if extremecase == 0 
        upper2 = 1/(1+exp(-(log(spec1) - log(1-spec1) - setts.limits.spec_logOR.lower)));
    else
        upper2 =  1;
    end
	upper3 = setts.limits.spec0.upper;

	extremecase = (spec1 >= 1 | spec1 <= 0) & (setts.limits.spec_logOR.upper < Inf);
	lower1 = spec1 - setts.limits.spec_diff.upper;
    if extremecase == 0 
        lower2 = 1/(1+exp(-(log(spec1) - log(1-spec1) - setts.limits.spec_logOR.upper))) ;
    else
        lower2 =  0;
    end
    lower3 = setts.limits.spec0.lower;
       
	Sspec_upper = [upper1 ; upper2 ; upper3];
	Sspec_lower = [lower1 ; lower2 ; lower3];
	pvec4 = [kron(Sspec_upper, [1;1;1]) kron([1;1;1],Sspec_lower)]; 	% Sspec_upper(1;1;1;2;2;2;...) - Sspec_lower(1;2;3;1;2;3;...)
	penscore_vec4 = pvec4(:,1) - pvec4(:,2);	% Rows 20-28

	% S(p_0)
	extremecase = (pi0 >= 1 | pi0 <= 0) & (setts.limits.ppi_logOR0.upper < Inf);
	upper1 = pi0 + setts.limits.ppi_diff0.upper;
    if extremecase == 0 
        upper2 = 1/(1+exp(-(log(pi0) - log(1-pi0) + setts.limits.ppi_logOR0.upper))) ;
    else
        upper2 = 1;
    end
	upper3 = setts.limits.p0.upper;

	extremecase = (pi0 >= 1 | pi0 <= 0) & (setts.limits.ppi_logOR0.lower > -Inf);
	lower1 = pi0 + setts.limits.ppi_diff0.lower;
    if extremecase == 0 
        lower2 = 1/(1+exp(-(log(pi0) - log(1-pi0) + setts.limits.ppi_logOR0.lower)));
    else
        lower2 =  0;
    end
	lower3 = setts.limits.p0.lower;

	Sp_upper = [upper1 ; upper2 ; upper3];
	Sp_lower = [lower1 ; lower2 ; lower3];
	pvec5 = [kron(Sp_upper , [1;1;1]) kron([1;1;1], Sp_lower)]; 		% Sp_upper(1;1;1;2;2;2;...) - Sp_lower(1;2;3;1;2;3;...)
	penscore_vec5 = pvec5(:,1) - pvec5(:,2);	% Rows 29-37

	% The monster
	% monster1
	monster1_upper1 = setts.limits.sensspec1.upper - Sspec_lower;
	monster1_upper2 = Sp_upper + (1 - pi0) * (setts.limits.sensspec1.upper - 1);
	monster1_upper4 = Ssens_upper;
	monster1_upper = [monster1_upper1 ; monster1_upper2];

	monster1_lower1 = setts.limits.sensspec1.lower - Sspec_upper;
	monster1_lower2 = Sp_lower + (1 - pi0) * (setts.limits.sensspec1.lower - 1);
	monster1_lower4 = Ssens_lower;
	monster1_lower = [monster1_lower1 ; monster1_lower2];
	
	length_monster1 = size(monster1_upper,1);
	length_monster14 = size(monster1_upper4,1);
	pvec6 = [kron(monster1_upper, ones(length_monster14,1)) ... 
        kron(ones(length_monster1,1), monster1_lower4)];
		% (monster1_upper1:1;1;1;2;2;2;3;3;3;monster1_upper2:1;1;1;2;2;2;3;3;3) - monster1_lower4:1;2;3;1;2;3;1;2;3;...
	pvec7 = [kron(monster1_upper4, ones(length_monster1,1)) ...
        kron(ones(length_monster14,1), monster1_lower)];
		% (monster1_upper4:1;1;1;1;1;1;2;2;2;2;2;2;3;3;3;3;3;3) - (monster1_lower1:1;2;3;monster1_lower2:1;2;3;...)
	penscore_vec6 = pvec6(:,1) - pvec6(:,2);	% Rows 38-55
	penscore_vec7 = pvec7(:,1) - pvec7(:,2);	% Rows 56-73

	% monster2
	monster2_upper1 = pi0 .* monster1_upper1;
	monster2_upper4 = pi0 .* monster1_upper4;
	monster2_lower1 = pi0 .* monster1_lower1;
	monster2_lower4 = pi0 .* monster1_lower4;
	monster2_upper = [monster2_upper1 ; monster2_upper4];	% = 3 + 3 rows
	monster2_lower = [monster2_lower1 ; monster2_lower4];	% = 3 + 3 rows

	monster2_upper3 = kron(Sp_upper , [1;1;1]) - (1 - pi0) .* (1 - kron([1;1;1], Sspec_upper));	% = 9 rows
		% (Sp_upper:1;1;1;2;2;2;3;3;3) , (Sspec_upper:1;2;3;1;2;3;1;2;3)
	monster2_lower3 = kron(Sp_lower , [1;1;1]) - (1 - pi0) .* (1 - kron([1;1;1], Sspec_lower));	% = 9 rows
		% (Sp_lower:1;1;1;2;2;2;3;3;3) , (Sspec_lower:1;2;3;1;2;3;1;2;3)
	length_monster2 = size(monster2_upper,1); 	% = 6
	length_monster23 = size(monster2_upper3,1);	% = 9
	pvec8 = [kron(monster2_upper, ones(length_monster23,1)) ...
        kron(ones(length_monster2,1) , monster2_lower3)];
		% (monster2_upper1:1;1;1;1;1;1;1;1;1;2;2;2;...;3;3;monster2_upper4:1;1;1;1;1;1;1;1;1;2;2;...;3;3) - monster2_lower3:1;2;3;4;5;6;7;8;9;...;7;8;9)
	pvec9 = [kron(monster2_upper3 , ones(length_monster2,1)) ...
        kron(ones(length_monster23,1) , monster2_lower)];
		% (monster2_upper3:1;1;1;1;1;1;2;2;2;2;2;2;...;9;9) - (;monster2_lower1:1;2;3;monster2_lower4:1;2;3;monster2_lower1:1;2;...) 
	penscore_vec8 = pvec8(:,1) - pvec8(:,2);	% Rows 74-127
	penscore_vec9 = pvec9(:,1) - pvec9(:,2);	% Rows 128-181

% 	pen_mat_miscl = [pvec1 ; pvec2 ; pvec3 ; pvec4 ; pvec5 ; pvec6 ; ...
%         pvec7 ; pvec8 ; pvec9];
	penalties_miscl = [penscore_vec1 ; penscore_vec2 ; penscore_vec3 ; ...
        penscore_vec4 ; penscore_vec5 ; penscore_vec6 ; ...
		penscore_vec7 ; penscore_vec8 ; penscore_vec9]';
	within_limits = min(penalties_miscl) >= 0;
    
   	if setts.debug == 1 
		fprintf('pi0, sens1, spec1, sens+spec1, sens-spec1\n')
		[pi0 sens1 spec1 (sens1 + spec1) (sens1 - spec1)]
		fprintf('pi0, sens1, spec1, sens+spec1, sens-spec1 minus their lower bounds\n')
		[pvec1 penscore_vec1]
		fprintf('Upper boundary of pi0, sens1, spec1, sens+spec1, sens-spec1 minus their actual values\n')
		[pvec2 penscore_vec2]
		fprintf('S(sens_0)+ - S(sens_0)-\n')
		[pvec3 penscore_vec3]
		fprintf('S(spec_0)+ - S(spec_0)-\n')
		[pvec4 penscore_vec4]
		fprintf('S(p_0)+ - S(p_0)-\n')
		[pvec5 penscore_vec5]
		fprintf('monster1,2 - monster 4\n')
		[pvec6 penscore_vec6]
		fprintf('monster4 - monster1,2\n')
		[pvec7 penscore_vec7]
		fprintf('monster1,4 - monster3\n')
		[pvec8 penscore_vec8]
		fprintf('monster3 - monster1,4\n')
		[pvec9 penscore_vec9]
		fprintf('within_limits is %4.0f\n', within_limits)
    end
    
    c = -penalties_miscl;
    ceq = [];
   
end
    
