function [x_est, x_pre, x_post,n_diff] = particle_filter(x_init, likelihood, gen_next, t_max, n_min, resampling)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
%
% Computes an estimate of a signal x using a particle filter
% INPUT
%   x_init: an initial set of particles (estimate for t = 1). Each column
%       of the matrix correspond to one particle.
%   likelihood(t, particles): a function returning the probability for each
%       particle at time t
%   gen_next(t, particles): given the set of particles at time t, generate
%       the next set (for t+1) (one-to-one mapping from old to new
%       particles using the known/stochastic Markov process)
%   t_max: last time for which the signal x is estimated
%   n_min: minimum effective number of particles needed. The algorithm
%       performs resampling if the effective number of particles is less
%       than n_min.
%       Tips: To never resample (SIS), set n_min to 0. To always resample,
%       set n_min to +Inf
%   resampling: mode of resampling
%       'SIR': sampling / importance resampling (new particles are taken
%       amongst old ones)
%       'postRPF':  post regularized particle filter (new particles are
%       taken from a continuous density derived from old particles).
% OUTPUT
%   x_est: estimate of the x signal for t = 1 to t = t_max
%   x_pre: prevision particles for signal x for t = 1 to t_max
%   x_post: particles after correction and resampling for signal x, for t =
%   1 to t_max
%   n_diff: number of particles used at each step

n = size(x_init, 2);
dim = size(x_init, 1);

n_diff = zeros(t_max, 1);
x_est = zeros(dim, t_max);
x_pre = zeros(dim, n, t_max+1);
x_post = zeros(dim, n, t_max);
x_pre(:,:,1) = x_init;
weights = zeros(n, t_max);
weights(:, 1) = ones(n, 1)/n;

for t = 1:t_max
    % weights
    w = weights(:, t) .* likelihood(t, x_pre(:,:,t))';
    w = w / sum(w);
    % estimation
    x_est(:,t) = x_pre(:,:,t)*w;

    % correction & resampling
    n_eff = 1/sum(w.^2);
    if n_eff < n_min
        switch resampling
            case 'SIR'
                sample = randsample(1:n, n, true, w);
                x_post(:,:,t) = x_pre(:,sample,t);
            case 'postRPF'
                %fprintf('resample t= %i, n_eff/n = %f\n', t, n_eff/n);
                m = mean(x_pre(:,:,t), 2);
                xt_c = x_pre(:,:,t) - repmat(m, 1, n);
                S = (repmat(w', dim, 1) .* xt_c) * xt_c';
                A = chol(S, 'lower');
                h_opt = (4/(dim+2))^(1/(dim+4)) * n^(-1/(dim+4));
                sample = randsample(1:n, n, true, w);
                x_post(:,:,t) = x_pre(:,sample,t) + h_opt * A * normrnd(0, 1, dim, n);
            otherwise
                error('Unknown resampling method ''%s''', resampling);
        end
        weights(:,t+1) = ones(1, n)/n;
    else
        x_post(:,:,t) = x_pre(:,:,t);
        weights(:,t+1) = w;
    end
    % prediction
    x_pre(:,:,t+1) = gen_next(t, x_post(:,:,t));

    % count the number of different particles
    n_diff(t) = 1 + sum(sum(abs(diff(sortrows(x_post(:,:,t)'))), 2) ~= 0);    
end

end
