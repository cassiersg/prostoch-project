
n_min = +Inf;
filtering = 'SIR';
sA = 1e-6;
T = 1;
        
[xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    track_data(filtering, sA, n_min);

load data.mat
target_velocities = diff([target, 2*target(:,end) - target(:,end-1)]')'/T;

for t = [1, 2, 3, 15, 26]
    f = figure('Name', ['k = ', num2str(t)]);
    subplot(2, 1, 1);
    title(sprintf('k = %i, positions', t));
    hold on;
    plot(...
        xt_pre_resampling(1,:,t), xt_pre_resampling(2,:,t), '.',...
        xt_post_resampling(1,:,t), xt_post_resampling(2,:,t), '.');
    plot(observer(1,:), observer(2,:), target(1,:), target(2,:));
	plot(xt_estimated(1,1:t), xt_estimated(2,1:t), 'd');
%    legend({'pre resampling', 'post resampling', 'observer', 'target', 'estimated target'}, 'Location', 'best');
    subplot(2, 1, 2);
    plot(...
        xt_pre_resampling(3,:,t), xt_pre_resampling(4,:,t), '.',...
        xt_post_resampling(3,:,t), xt_post_resampling(4,:,t), '.',...
        target_velocities(1,t), target_velocities(2,t), 'd');
    title(sprintf('k = %i, velocities', t));
%    legend({'pre resampling', 'post resampling', 'true (almost)'}, 'Location', 'best');
    tightfig();
    saveas(gcf, sprintf('../report/img/q4_%i.png', t), 'png');
    close(f);
end