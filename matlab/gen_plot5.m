function gen_plot5(n_min, filtering)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% INPUT :
%   n_min   minimum effective number of particles needed. The algorithm
%           performs resampling if the effective number of particles is less
%           than n_min.
%   filtering mode of resampling
%               'SIR':  sampling / importance resampling (new particles are 
%               taken amongst old ones), for question 4
%               'postRPF':  post regularized particle filter (new particles
%               are taken from a continuous density derived from old 
%               particles)
% OUTPUT :
%           plots the results for question 2 of each arrow on a new figure
sA = 0;

[xt_estimated, ~, ~, n_diff] =...
    q4q5(filtering, sA, n_min);

load('data.mat');

k = 1:length(n_diff);
%figure('Name', ['k = ', num2str(t(end))]);

subplot(2, 1, 1);
title('positions');
%hold on;
semilogy(k,n_diff, '.', 'MarkerSize', 15);
xlabel('step')
ylabel('number of points')

subplot(2, 1, 2);
title('positions');
hold on;
plot(observer(1,:), observer(2,:), '.', target(1,:), target(2,:), '.');
plot(xt_estimated(1,1:k(end)), xt_estimated(2,1:k(end)), 'd');
xlabel('x')
ylabel('y')
legend({'observer', 'target', 'estimated target'}, 'Location', 'best');

end
