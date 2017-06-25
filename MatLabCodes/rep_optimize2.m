function rep_optimize2(rep)
    global setts
    if setts.Trace.repeats >= 1
        fprintf('\n###### %s percentile %5.3g ######\n', ...
            setts.minimize_text, setts.percentile);
    end
    for i=1:rep
        if setts.Trace.repeats == 1
            fprintf('*');
            if rem(i,80) == 0
                fprintf('\n')
            end

        end
        optimize2();
        if setts.Trace.repeats == 2
            fprintf('\nInitial values\n');
            fprintf('%7.4g ', setts.results.initvalues);
            fprintf('\n');
        end
    end
end
