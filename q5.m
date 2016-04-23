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
xt_estimated = zeros(4, k_max);
xt_pre_resampling = zeros(4, n, k_max+1);
xt_post_resampling = zeros(4, n, k_max);
xt_pre_resampling(:,:,1) = xt;
w = ones(1, n)/n;
for t = 1:k_max
    % weights
    xt = xt_pre_resampling(:,:,t);
    est_mes = atan2(xt(1,:) - observer(1,t), xt(2,:) - observer(2,t));
    w = w .* normpdf(measurements(t) - est_mes, 0, s_theta);
    w = w / sum(w);
    % prediction
    xt_estimated(:,t) = xt * w';
    % correction & resampling
    n_eff = 1/sum(w.^2);
    if n_eff < n/3
        fprintf('resample t= %i, n_eff/n = %f\n', t, n_eff/n);
        m = mean(xt, 2);
        xt_c = xt - repmat(m, 1, n);
        S = (repmat(w, 4, 1) .* xt_c) * xt_c';
        A = chol(S, 'lower');
        % h_opt = A(K)N^(-1/(nx+4) whith A(K) = (4/(nx+2))^(1/(nx+4)) and
        % nx = 2
        % Thus A(K) = 1 and h_opt = n^(-1/6)
        h = n^(-1/6);
        sample = randsample(1:n, n, true, w);
        xt_post_resampling(:,:,t) = xt(:,sample) + h * A * normrnd(0, 1, 4, n);
        w = ones(1, n)/n;
    else
        xt_post_resampling(:,:,t) = xt;
    end
    % prediction
    xt_pre_resampling(:,:,t+1) = F*xt_post_resampling(:,:,t) + Gamma*normrnd(0, sA, 2, n);
end

target_velocities = diff([target, 2*target(:,end) - target(:,end-1)]')'/T;

for t = [1, 2, 3, 15, 26]
%if false
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
    title('velocities');
    plot(...
        xt_pre_resampling(3,:,t), xt_pre_resampling(4,:,t), '.',...
        xt_post_resampling(3,:,t), xt_post_resampling(4,:,t), '.',...
        target_velocities(1,t), target_velocities(2,t), 'd');
    legend('pre resampling', 'post resampling', 'true (almost)');
end
