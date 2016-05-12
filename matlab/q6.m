function [CRLBrms, RMS] = q6()
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% Q6 computes Cramer-Rao lower bound for the trajectory estimation and the
% empirical variance of the particle filter estimator.
% OUTPUT :
%   CRLBrms Cramer-Rao lower bound on the variance on the variance of the
%          estimated position (norm of variance in X and variance in Y)
%   RMS empirical variance of the particle set (norm of variance in X and
%           variance in Y)

load data.mat;
T = .5;
[F, ~, n] = gen_parameters(T);
s_r = 0.1;
s_t = 1e-4;
s_speed = 0.1;
s_course = 0.1;
k_max = length(target(1,:));
rel_pos = target - observer;
dist = rel_pos(1,:).^2 + rel_pos(2,:).^2;
H = [rel_pos(2,:)./dist; -rel_pos(1,:)./dist; zeros(2,k_max)];

% computation of the CRLB for each position
Pxx = r^2*s_t*cos(theta)^2 + s_r*sin(theta)^2;
Pyy = r^2*s_t*sin(theta)^2 + s_r*cos(theta)^2;
Pxy = (s_r - r^2*s_t)*sin(theta)*cos(theta);
Pyx = Pxy;
Pdxdx = s^2*s_course*cos(c)^2 + s_speed*sin(c)^2;
Pdydy = s^2*s_course*sin(c)^2 + s_speed*cos(c)^2;
Pdxdy = (s_speed - s^2*s_course)*sin(c)*cos(c);
Pdydx = Pdxdy;
P1 = [Pxx,   Pxy,   0,     0;
      Pyx,   Pyy,   0,     0;
      0,     0,     Pdxdx, Pdxdy;
      0,     0,     Pdydx, Pdydy];
J1 = inv(P1);
J = zeros(4, 4, k_max);
Jinv = J;
J(:,:,1) = J1;
Jinv(:,:,1) = P1;
Finv = inv(F);
for i = 2:k_max
    J(:,:,i) = Finv'*J(:,:,i-1)*Finv + 1/s_t*H(:,i)*H(:,i)';
    Jinv(:,:,i) = inv(J(:,:,i));
end
CRLBrms = squeeze(sqrt(Jinv(1,1,:)+Jinv(2,2,:)))';

% computation of the estimated (absolute) target position using Q52.m
[~, ~, xt_post_resampling, ~] = q4();

% computation of the RMS error for each position
RMS = zeros(1,k_max);
for i = 1:k_max
    RMS(i) = sqrt(...
                1/n*(sum(...
                        (xt_post_resampling(1,:,i)-target(1,i)).^2 ...
                      + (xt_post_resampling(2,:,i)-target(2,i)).^2 ...
                 )));
end

end