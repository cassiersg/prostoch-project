function gen_plot5(n_min, filtering)

sA = 0;

[xt_estimated, ~, ~, n_diff] =...
    track_data(filtering, sA, n_min);

load('data.mat')

t = 1:length(n_diff);
%figure('Name', ['k = ', num2str(t(end))]);

subplot(2, 1, 1);
title('positions');
%hold on;
semilogy(t,n_diff, '.', 'MarkerSize', 15);
xlabel('step')
ylabel('number of points')

subplot(2, 1, 2);
title('positions');
hold on;
plot(observer(1,:), observer(2,:), '.', target(1,:), target(2,:), '.');
plot(xt_estimated(1,1:t(end)), xt_estimated(2,1:t(end)), 'd');
xlabel('x')
ylabel('y')
legend({'observer', 'target', 'estimated target'}, 'Location', 'best');

end