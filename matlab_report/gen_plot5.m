function gen_plot5(xt_estimated, n_diff)
% INPUT :
%   xt_estimated estimated position of target (for each time step)
%   n_diff effective number of particles (for each time step)
%   Inputs can be generated with Q51.m or Q52.m
% OUTPUT :
%   plots the results for question 5

load('data.mat');

k = 1:length(n_diff);

subplot(2, 1, 1);
semilogy(k,n_diff, '.', 'MarkerSize', 15);
xlabel('step')
ylabel('N_{eff}')

subplot(2, 1, 2);
%title('positions');
hold on;
plot(observer(1,:), observer(2,:), '.', target(1,:), target(2,:), '.');
plot(xt_estimated(1,1:k(end)), xt_estimated(2,1:k(end)), 'd');
xlabel('x')
ylabel('y')
legend({'observer', 'target', 'estimated target'}, 'Location', 'southwest');

end
