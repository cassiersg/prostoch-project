function [x, xt_estimated, xt_post_resampling] = q3(sA, sT, k_max)

T = 0.5;
T2 = T^2/2;

Gamma = [T2 0;
         0 T2;
         T 0;
         0 T];
     
x0 = [1 1 1 1]';

F = [1 0 T 0;
     0 1 0 T;
     0 0 1 0;
     0 0 0 1];

[x, z] = q2(sA, sT, k_max);
 
n = 5000;
xt = repmat(x0, 1, n);
likelihood = @(t, p)normpdf(z(t) - atan2(p(1,:), p(2,:)), 0, sT);
gen_next = @(t, p)F*p+Gamma*normrnd(0, sA, 2, n);
[xt_estimated, ~, xt_post_resampling, ~] = particle_filter(...
    xt, likelihood, gen_next, k_max, n, 'SIR');

end