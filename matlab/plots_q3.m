
k_max = 201;

sA = 0.01;
sT = 0.01;

[x, xt_estimated, xt_post_resampling] = q3(sA, sT, k_max);

for t = [2, 51, 101, 201]
    f = figure();
    subplot(2, 1, 1);
    histogram(xt_post_resampling(1,:,t), 50);
    title(sprintf('k = %i', t-1));
    xlabel('X');
    ylim([0 400]);
    subplot(2, 1, 2);
    histogram(xt_post_resampling(2,:,t), 50);
    xlabel('Y');
    ylim([0 400]);
    saveas(gcf, sprintf('../report/img/q3_hist_%i.eps', t-1), 'epsc');
    close(f);
end
f = figure();
plot(x(1,:),x(2,:),xt_estimated(1,:),xt_estimated(2,:));
legend({'real', 'estimated'}, 'Location', 'best');
saveas(gcf, sprintf('../report/img/q3_path.eps'), 'epsc');
close(f);
