% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% % Script that computes and plots the results for question 5.

% 1. Results with the SIR filter 
[xt_estimated, ~, ~, n_diff] = q51();
f = figure();
title('SIR filter');
gen_plot5(xt_estimated, n_diff);
pos = get(f, 'position');
% resize figure
set(f, 'position', [pos(1:2), 1.2*ceil(pos(3:4))]);

savefig(sprintf('q51'));
close(f);

% 2. Results with the post RPF filter
[xt_estimated, ~, ~, n_diff] = q52();
f = figure();
title('post-RPF filter');
gen_plot5(xt_estimated, n_diff);
pos = get(f, 'position');
% resize figure;
set(f, 'position', [pos(1:2), 1.2*ceil(pos(3:4))]);
savefig(sprintf('q52'));
close(f);
