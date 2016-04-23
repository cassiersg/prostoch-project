load data.mat
close all;
k_max = 26;

T = 1;
T2 = T^2/2;

Gamma = [T2 0;
         0 T2;
         T 0;
         0 T];

F = [1 0 T 0;
     0 1 0 T;
     0 0 1 0;
     0 0 0 1];

sA = sqrt(1e-6); 
s_r = sqrt(0.1);
s_theta = sqrt(1e-4);
s_speed = sqrt(0.1);
s_course = sqrt(0.1);

n = 5000;
r_init = normrnd(r, s_r, 1, n);
th_init = normrnd(theta, s_theta, 1, n);
speed_init = normrnd(s, s_speed, 1, n);
course_init = normrnd(c, s_course, 1, n);
xt = [...
    observer(1,1) + r_init .* sin(th_init);...
    observer(2, 1) + r_init .* cos(th_init);...
    speed_init .* cos(course_init);
    speed_init .* sin(course_init)];

[xt_estimated, xt_pre_resampling, xt_post_resampling] = particle_filter(...
    xt,...
    @(t, p)normpdf(measurements(t) - atan2(p(1,:)-observer(1,t), p(2,:)-observer(2,t)), 0, s_theta),...
    @(t, p)F*p+Gamma*normrnd(0, sA, 2, n),...
    length(measurements),...
    Inf,...
    'SIR');

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
