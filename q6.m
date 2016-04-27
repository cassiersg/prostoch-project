% q6
load data.mat;

F = [1 0 T 0;
     0 1 0 T;
     0 0 1 0;
     0 0 0 1];
s_r = 0.1;
s_theta = 1e-4;
s_speed = 0.1;
s_course = 0.1;

dist = target(1,:)^2 + target(2,:)^2;
H = [target(2,:)./dist; -target(1,:)/dist; 0; 0];
% x = [xt, yt, vxt, vyt]
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
    Jinv(:,:,i) = inv(J(:,:,i);
end
