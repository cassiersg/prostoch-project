function [F, Gamma, n] = gen_parameters(T)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
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
