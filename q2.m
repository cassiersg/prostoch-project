%Q1

% U_k,k+1: acceleration observer
% = -1 * Gamma*[x_acc_obs, y_acc_obs]

% Question 2 terminee

n = 200;

sA = 0.55;
sT = 0.1;
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
 
 x = zeros(4,n);
 x(:,1) = x0;
 for i=2:n
    x(:,i) = F*x(:,i-1) + Gamma*normrnd(0,sA,2,1);
 end
 z = atan2(x(1,:),x(2,:)) + normrnd(0, sT, 1, n);
 
 subplot(3,1,1)
 plot(x(1,:),x(2,:), '.-');
 title('position');
 subplot(3,1,2)
 plot(x(3,:),x(4,:));
 title('velocity');
 subplot(3,1,3)
 plot(1:n, z/pi,'.-')
 title('bearing');