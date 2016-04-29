close all;
k_max = 201;

sA = 0.01;
sT = 0.01;
T = 0.5;
T2 = T^2/2;

Gamma = [T2 0;
         0 T2;
         T 0;
         0 T];
     
x0 = [1 1 1 1]';

F = [1 0 T 0;
     0 1 0 T;
     0 0 1 0;
     0 0 0 1];
 
 x = zeros(4,k_max);
 x(:,1) = x0;
 for i=2:k_max
    x(:,i) = F*x(:,i-1) + Gamma*normrnd(0,sA,2,1);
 end
 % this is shit
 z = atan2(x(1,:),x(2,:)) + normrnd(0, sT, 1, k_max);
 
n = 5000;
xt = repmat(x0, 1, n);
x_estimated = ones(4, k_max);
x_estimated(:,1) = x0;
for t = 2:k_max
    xt1 = F*xt + Gamma*normrnd(0, sA, 2, n);
    w = normpdf(z(t) - atan2(xt1(1,:),xt1(2,:)), 0, sT);
    w = w/sum(w);
    x_estimated(:,t) = xt1*w';
    sample = randsample(1:n, n, true, w);
    xt = xt1(:,sample);
    if t == 2 || t == 51 || t == 101 || t == 201
        figure;
        subplot(2, 1, 1);
        histogram(xt(1,:), 50);
        title(sprintf('X, k = %i', t-1));
        subplot(2, 1, 2);
        histogram(xt(2,:), 50);
        title(sprintf('Y, k = %i', t-1));
    end
end
figure;
plot(x(1,:),x(2,:),x_estimated(1,:),x_estimated(2,:),'.-');
legend('real', 'estimated');
