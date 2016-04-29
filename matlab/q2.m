function [x,z] = q2(sA,sT)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT UCL
% @Date 24/04/15
% Q2 simulates the system and the observation process for k=200 steps with
% the instructions given in the statement. It then plots the relative
% positions (at k=1, (x,y)=(0,0)) and the measured angles at each step
% INPUT :   sA      variance of the noise linked to the process noise vector
%           sT      variance of the noise linked to the measure of 
%                   the bearing angle
% OUTPUT :  x       4*200 matrix containing the predicted position and speed
%                   for the k steps
%           z       1*200 vector containing the predicted bearing angle for
%                   the k steps


if nargin==0
    sA = 0.55;
    sT = 0.1;
end


k = 200;
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
 
 x = zeros(4,k);
 x(:,1) = x0;
 for i=2:k
    x(:,i) = F*x(:,i-1) + Gamma*normrnd(0,sA,2,1);
 end
 z = atan2(x(1,:),x(2,:)) + normrnd(0, sT, 1, k);
 
 subplot(2,1,1)
 hold on all
 grid on
 plot(x(1,:),x(2,:), '.-','DisplayName',['alpha=',num2str(sA),' theta=',num2str(sT)]);
 title('position');
 xlabel('x [m]')
 ylabel('y [m]')
legend('-DynamicLegend');

 subplot(2,1,2)
 hold on all
 grid on
 plot(1:k, z/pi,'.-')
 title('bearing');
 xlabel('step')
 ylabel('angle [rad]')
end