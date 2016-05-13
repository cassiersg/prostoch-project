% % Script that computes  and plots the results for question 4.

T = 1;
        
[xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] = q4();

load data.mat
target_velocities = diff([target, 2*target(:,end) - target(:,end-1)]')'/T;

for k = [1, 2, 3, 15, 26]
    f = figure('Name', ['k = ', num2str(k)]);
    subplot(2, 1, 1);
    title(sprintf('k = %i, positions', k));
    hold on;
	plot(xt_pre_resampling(1,:,k), xt_pre_resampling(2,:,k), '.', 'MarkerEdgeColor', [.9 .9 0]);
	plot(xt_post_resampling(1,:,k), xt_post_resampling(2,:,k), '.', 'MarkerEdgeColor', [1 .5 0]);
    plot(observer(1,:), observer(2,:), 'r', 'LineWidth', 1.5);
    plot(observer(1,k), observer(2,k), '.r', 'MarkerSize', 15);
    plot(target(1,:), target(2,:), 'Color', [.3 .3 .3], 'LineWidth', 1.5);
	plot(xt_estimated(1,1:k), xt_estimated(2,1:k), '*', 'MarkerEdgeColor', [0 0 .8]);
%    legend({'pre resampling', 'post resampling', 'observer', 'target', 'estimated target'}, 'Location', 'best');
    subplot(2, 1, 2);
    hold on;
	plot(xt_pre_resampling(3,:,k), xt_pre_resampling(4,:,k), '.', 'MarkerEdgeColor', [.9 .9 0]);
	plot(xt_post_resampling(3,:,k), xt_post_resampling(4,:,k), '.', 'MarkerEdgeColor', [1 .5 0]);
	plot(target_velocities(1,k), target_velocities(2,k), '*', 'MarkerEdgeColor', [0 0 .8]);
    title(sprintf('k = %i, velocities', k));
%    legend({'pre resampling', 'post resampling', 'true (almost)'}, 'Location', 'best');
    tightfig();
    saveas(gcf, sprintf('Results/q4_%i.png', k), 'png');
    close(f);
end
