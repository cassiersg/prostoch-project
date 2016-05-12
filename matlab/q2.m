function [x, z] = q2(sA, sT, k)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% Q2 simulates the system and the observation process starting at
% x0=[1,1,1,1]' for k steps, depending on the variances : sA of the 
% acceleration ; sT of the angle theta. 
% To plot the relative positions and the measured angles at each step, 
% use the file PLOT_Q2.M
% INPUT :
%   sA variance of the noise linked to the process noise vector
%   sT variance of the noise linked to the measure of the bearing angle
%   k number ot time steps
% OUTPUT :
%   x 4*k matrix containing the predicted position and speed
%   z 1*k vector containing the predicted bearing angle

load data2.mat;

x0 = [1 1 1 1]';
x = zeros(4,k);
x(:,1) = x0;
for i=2:k
    x(:,i) = F*x(:,i-1) + Gamma*normrnd(0,sA,2,1);
end
z = atan2(x(1,:),x(2,:)) + normrnd(0, sT, 1, k);

end
