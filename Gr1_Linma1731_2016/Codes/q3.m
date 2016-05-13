function [x, xt_estimated, xt_post_resampling] = q3(s_a, s_t, k)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% Q3 simulates the system using Q2.m, and then tracks the target using
% a SIR particle filter with 5000 particles
% For a graphical visualization of the results, see PLOT_Q3.m
% INPUT :
%   s_a variance of the noise generating the process noise vector
%   s_t variance of the noise generating the measure of the bearing angle
%   k number ot time steps
% OUTPUT :
%   x                   4*k   matrix containing the real position and speed
%   xt_estimated        4*k   matrix containing the estimated position and speed
%   xt_post_resampling  4*n*k matrix containing the particles after correction
%                       and resampling for signal x

% Information given from the statement and previous questions
T = 0.5;
[F, Gamma, n] = gen_parameters(T);
x0 = [1 1 1 1]';

%% 0/ Simulate the system
[x, z] = q2(s_a, s_t, k);

%% 1/ Apply Monte Carlo Method
% Generate the initial set of particles
xt = repmat(x0, 1, n);
% Likelihood function
likelihood = @(t, p)normpdf(z(t) - atan2(p(1,:), p(2,:)), 0, sqrt(s_t));
% Prediction function
gen_next = @(t, p)F*p+Gamma*normrnd(0, sqrt(s_a), 2, n);
% Run filter
[xt_estimated, ~, xt_post_resampling, ~] = particle_filter(...
    xt, likelihood, gen_next, k, n, 'SIR');

end
