function [x, z] = q2(sA, sT, k)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT UCL
% @Date 24/04/15
% Q2 simulates the system and the observation process for k=200 steps with
% the instructions given in the statement. It then plots the relative
% positions (at k=1, (x,y)=(0,0)) and the measured angles at each step
% INPUT :
%   sA variance of the noise linked to the process noise vector
%   sT variance of the noise linked to the measure of the bearing angle
%   k number ot time steps
% OUTPUT :
%   x 4*k matrix containing the predicted position and speed
%   z 1*k vector containing the predicted bearing angle

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

end