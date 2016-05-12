function [x, xt_estimated, xt_post_resampling] = q3(sA, sT, k)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% Q3 simulates the system and the observation process starting at
% x0=[1,1,1,1]' for k steps, depending on the variances : sA of the 
% acceleration ; sT of the angle theta, using the Monte Carlo Method.
% To plot the relative positions and the measured angles at each step, 
% use the file PLOTS_Q3.M
% INPUT :
%   sA variance of the noise linked to the process noise vector
%   sT variance of the noise linked to the measure of the bearing angle
%   k number ot time steps
% OUTPUT :
%   x                   4*k   matrix containing the real      position and speed
%   xt_estimated        4*k   matrix containing the estimated position and speed
%   xt_post_resampling  4*n*k matrix containing the particles after correction
%                       and resampling for signal x

% Information given from the statement and previous questions
T = 0.5;
[F, Gamma, ~] = gen_parameters(T);
x0 = [1 1 1 1]';

% 0/ Compute the true position and bearing
[x, z] = q2(sA, sT, k);

% 1/ Apply Monte Carlo Method
n = 5000; % Number of samples.
xt = repmat(x0, 1, n); % generating the initial set of particles
likelihood = @(t, p)normpdf(z(t) - atan2(p(1,:), p(2,:)), 0, sT);
gen_next = @(t, p)F*p+Gamma*normrnd(0, sA, 2, n);
[xt_estimated, ~, xt_post_resampling, ~] = particle_filter(...
    xt, likelihood, gen_next, k, n, 'SIR');%prediction & update

end
