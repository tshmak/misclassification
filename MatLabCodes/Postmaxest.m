function [besttheta, value, exitflag] = Postmaxest()

global setts
options = optimset();
options = optimset(options,'GradObj', 'on', 'Hessian', 'off'); 
options = optimset(options,'Display', setts.Display.maximization); 

[besttheta, value, exitflag] = fminunc(@minuslogPost, setts.inittheta, options);
end



