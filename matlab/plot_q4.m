% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% % Script that computes  and plots the results for question 4.
n_min = +Inf;
filtering = 'SIR';
sA = 1e-6;
T = 1;
        
[xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    q4q5(filtering, sA, n_min);

load data.mat
target_velocities = diff([target, 2*target(:,end) - target(:,end-1)]')'/T;

for k = [1, 2, 3, 15, 26]
    f = figure('Name', ['k = ', num2str(k)]);
    subplot(2, 1, 1);
    title(sprintf('k = %i, positions', k));
    hold on;
    plot(...
        xt_pre_resampling(1,:,k), xt_pre_resampling(2,:,k), '.',...
        xt_post_resampling(1,:,k), xt_post_resampling(2,:,k), '.');
    plot(observer(1,:), observer(2,:), target(1,:), target(2,:));
	plot(xt_estimated(1,1:k), xt_estimated(2,1:k), 'd');
%    legend({'pre resampling', 'post resampling', 'observer', 'target', 'estimated target'}, 'Location', 'best');
    subplot(2, 1, 2);
    plot(...
        xt_pre_resampling(3,:,k), xt_pre_resampling(4,:,k), '.',...
        xt_post_resampling(3,:,k), xt_post_resampling(4,:,k), '.',...
        target_velocities(1,k), target_velocities(2,k), 'd');
    title(sprintf('k = %i, velocities', k));
%    legend({'pre resampling', 'post resampling', 'true (almost)'}, 'Location', 'best');
    tightfig();
    saveas(gcf, sprintf('Results6++/q4_%i.png', k), 'png');
    close(f);
end
