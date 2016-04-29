
% the question we answer
question = 'q51';
disp(['Results for question : ', question])
% global variables
load data.mat
T = 1;
T2 = T^2/2;

Gamma = [T2 0;
         0 T2;
         T 0;
         0 T];
F = [1 0 T 0;
     0 1 0 T;
     0 0 1 0;
     0 0 0 1];
 
n = 5000;

s_r = 0.1;
s_theta = 1e-4;
s_speed = 0.1;
s_course = 0.1;

switch question
    case 'q4'
        n_min = +Inf;
        filtering = 'SIR';
        sA = 1e-6;
    case 'q51'
        n_min = +Inf;
        filtering = 'SIR';
        sA = 0;
    case 'q52'
        n_min = n/3;
        filtering = 'postRPF';
        sA = 0;
end

% particle flitering
r_init = normrnd(r, sqrt(s_r), 1, n);
th_init = normrnd(theta, sqrt(s_theta), 1, n);
speed_init = normrnd(s, sqrt(s_speed), 1, n);
course_init = normrnd(c, sqrt(s_course), 1, n);
xt = [...
    observer(1,1) + r_init .* sin(th_init);...
    observer(2, 1) + r_init .* cos(th_init);...
    speed_init .* cos(course_init);
    speed_init .* sin(course_init)];
likelihood = @(t, p)normpdf(measurements(t) - atan2(p(1,:)-observer(1,t), p(2,:)-observer(2,t)), 0, sqrt(s_theta));
gen_next = @(t, p)F*p+Gamma*normrnd(0, sqrt(sA), 2, n);
[xt_estimated, xt_pre_resampling, xt_post_resampling,n_diff] = particle_filter(...
    xt, likelihood, gen_next, length(measurements), n_min, filtering);
% display results
switch question
    case 'q4'
        plots_q4;
    case 'q51'
        plots_q5;
    case 'q52'
        plots_q5;
end