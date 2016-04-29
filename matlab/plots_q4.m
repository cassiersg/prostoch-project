close all;

target_velocities = diff([target, 2*target(:,end) - target(:,end-1)]')'/T;

for t = [1, 2, 3, 15, 26]
    figure('Name', ['k = ', num2str(t)]);
    subplot(2, 1, 1);
    title('positions');
    hold on;
    plot(...
        xt_pre_resampling(1,:,t), xt_pre_resampling(2,:,t), '.',...
        xt_post_resampling(1,:,t), xt_post_resampling(2,:,t), '.');
    plot(observer(1,:), observer(2,:), 'x', target(1,:), target(2,:), 'x');
	plot(xt_estimated(1,1:t), xt_estimated(2,1:t), 'd');
    legend('pre resampling', 'post resampling', 'observer', 'target', 'estimated target');
    subplot(2, 1, 2);
    plot(...
        xt_pre_resampling(3,:,t), xt_pre_resampling(4,:,t), '.',...
        xt_post_resampling(3,:,t), xt_post_resampling(4,:,t), '.',...
        target_velocities(1,t), target_velocities(2,t), 'd');
    title('velocities');
    legend('pre resampling', 'post resampling', 'true (almost)');
end