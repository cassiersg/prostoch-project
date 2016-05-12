% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% % Script that computes  and plots the results for question 5.

% 1. Results with the SIR filter 
f = figure();
title('SIR filter');
gen_plot5(+Inf, 'SIR');
pos = get(f, 'position');
% resize figure;
set(f, 'position', [pos(1:2), 1.2*ceil(pos(3:4))]);

saveas(f, sprintf('Results/q51.png'));
close(f);

% 2. Results with the post RPF filter
f = figure();
title('post-RPF filter');
gen_plot5(5000/3, 'postRPF');
pos = get(f, 'position');
% resize figure;
set(f, 'position', [pos(1:2), 1.2*ceil(pos(3:4))]);
saveas(f, sprintf('Results/q52.png'));
close(f);
