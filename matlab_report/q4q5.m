function [xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    q4q5(filtering, s_a, n_min)
% Q4Q5 estimates the position of the target for the artificial 
% submarine tracking problem initialised with 'data.m'. 
% To plot the relative positions and the measured angles at each step, 
% depending on the question, use the files PLOT_Q4.M and PLOT_Q5.M.
% INPUT :
%   filtering   mode of resampling
%               'SIR':  sampling / importance resampling (new particles are 
%               taken amongst old ones), for question 4
%               'postRPF':  post regularized particle filter (new particles
%               are taken from a continuous density derived from old 
%               particles)
%   s_a      variance of the noise linked to the process noise vector
%   n_min   minimum effective number of particles needed. The algorithm
%           performs resampling if the effective number of particles is less
%           than n_min.
% OUTPUT :
%   xt_estimated        4*k matrix containing the estimated position and 
%                       speed
%   xt_pre_resampling   4*n*k matrix containing the particles after 
%                       correction and before resampling for signal x
%   xt_post_resampling  4*n*k matrix containing the particles after 
%                       correction and resampling for signal x
%   n_diff              Number of different particles in the sampling

% Parameters defining the submarine-tracking problem
load data.mat;
T = 1;
[F, Gamma, n] = gen_parameters(T);
s_r = 0.1;
s_theta = 1e-4;
s_speed = 0.1;
s_course = 0.1;

% particle filtering
r_init = normrnd(r, sqrt(s_r), 1, n);
th_init = normrnd(theta, sqrt(s_theta), 1, n);
speed_init = normrnd(s, sqrt(s_speed), 1, n);
course_init = normrnd(c, sqrt(s_course), 1, n);
xk = [...
    observer(1,1) + r_init .* sin(th_init);...
    observer(2, 1) + r_init .* cos(th_init);...
    speed_init .* cos(course_init);
    speed_init .* sin(course_init)];
likelihood = @(t, p)normpdf(measurements(t) - atan2(p(1,:)-observer(1,t), p(2,:)-observer(2,t)), 0, sqrt(s_theta));
gen_next = @(t, p)F*p+Gamma*normrnd(0, sqrt(s_a), 2, n);
[xt_estimated, xt_pre_resampling, xt_post_resampling,n_diff] = particle_filter(...
    xk, likelihood, gen_next, length(measurements), n_min, filtering);
end
