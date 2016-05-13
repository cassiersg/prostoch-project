% Script that computes  and plots the results for question 3.

k = 201; % As it is asked to go 200 steps ahead and k=1 is given.

s_a = 0.01;
s_t = 0.01;

[x, xt_estimated, xt_post_resampling] = q3(s_a, s_t, k);

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
    savefig(sprintf('q3_hist_%i', t-1));
    close(f);
end
t = [2, 51, 101, 201];
f = figure();
plot(x(1,:),x(2,:),'*',xt_estimated(1,:),xt_estimated(2,:),'*','MarkerSize',1);
hold on
plot(x(1,t),x(2,t),'b*',xt_estimated(1,t),xt_estimated(2,t),'r*');
legend({'real', 'estimated'}, 'Location', 'best');

xlabel('X');
ylabel('Y');
savefig(sprintf('q3_path'));
close(f);
