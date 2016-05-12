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
[F, Gamma, n] = gen_parameters(T);
s_r = 0.1;
s_theta = 1e-4;
s_speed = 0.1;
s_course = 0.1;
k_max = length(target(1,:));
dist = target(1,:).^2 + target(2,:).^2;
H = [target(2,:)./dist; -target(1,:)./dist; zeros(1,k_max); zeros(1,k_max)];

% computation of the CRLB for each position
Pxx = r^2*s_theta*cos(theta)^2 + s_r*sin(theta)^2;
Pyy = r^2*s_theta*sin(theta)^2 + s_r*cos(theta)^2;
Pxy = (s_r - r^2*s_theta)*sin(theta)*cos(theta);
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
    J(:,:,i) = Finv'*J(:,:,i-1)*Finv + 1/s_theta*H(:,i)*H(:,i)';
    Jinv(:,:,i) = inv(J(:,:,i));
end
CRLBrms = squeeze(sqrt(Jinv(1,1,:)+Jinv(2,2,:)))';

% computation of the eaxact and estimated relative position USING Q5
xt_exact = target-observer;
sA = 0;
r_init = normrnd(r, sqrt(s_r), 1, n);
th_init = normrnd(theta, sqrt(s_theta), 1, n);
speed_init = normrnd(s, sqrt(s_speed), 1, n);
course_init = normrnd(c, sqrt(s_course), 1, n);
xt = [...
    observer(1,1) + r_init .* sin(th_init);...
    observer(2,1) + r_init .* cos(th_init);...
    speed_init .* cos(course_init);
    speed_init .* sin(course_init)];
likelihood = @(t,p)normpdf(measurements(t) - atan2(p(1,:)-observer(1,t),...
                    p(2,:)-observer(2,t)), 0, sqrt(s_theta));
gen_next = @(t, p)F*p+Gamma*normrnd(0, sqrt(sA), 2, n);
[~,~,xt_relative,~] = particle_filter(...
                       xt, likelihood, gen_next, length(measurements),...
                       5000/3, 'postRPF');

% computation of the RMS error for each position
RMS = zeros(1,k_max);
for i = 1:k_max
    RMS(i) = sqrt(...
                1/n*(sum(...
                        (xt_relative(1,:,i)-xt_exact(1,i)).^2 ...
                      + (xt_relative(2,:,i)-xt_exact(2,i)).^2 ...
                 )));
end

end