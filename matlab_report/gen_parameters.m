function [F, Gamma, n] = gen_parameters(T)
% GEN_PARAMETERS generate constants parameters
% INPUT :
%   T discretization time step
% OUTPUT :
%   F transformation matrix of the process
%   G perturbation coefficients
%   n number of particles

T2 = T^2/2;
F = [1 0 T 0;
     0 1 0 T;
     0 0 1 0;
     0 0 0 1];
Gamma = [T2, 0; 0, T2; T, 0; 0, T];
n = 5000;

end
