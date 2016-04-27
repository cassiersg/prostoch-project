close all;
load('data.mat')
target_velocities = diff([target, 2*target(:,end) - target(:,end-1)]')'/T;

t = 1:length(n_diff);
figure('Name', ['k = ', num2str(t(end))]);

subplot(2, 1, 1);
title('positions');
%hold on;
semilogy(t,n_diff, '.');
xlabel('step')
ylabel('number of points')
legend('number of points (log) according to step');

subplot(2, 1, 2);
title('positions');
hold on;
plot(observer(1,:), observer(2,:), 'x', target(1,:), target(2,:), 'x');
plot(xt_estimated(1,1:t(end)), xt_estimated(2,1:t(end)), 'd');
xlabel('x')
ylabel('y')
legend('observer', 'target', 'estimated target');
