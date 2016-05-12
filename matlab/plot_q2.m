% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% Script that plots the results for question 2.

k = 200; %number of steps
s_a = {[0, 0, 0], [0, 0.5, 1], [0, 0.5, 1], [0.5, 0.5, 0.5]};
s_t = {[0, 0.5, 1], [0, 0, 0], [0, 0.5, 1], [0.1, 0.1, 0.1]};
for i = 1:length(s_a)
    f = figure();
    gen_plot2(s_a{i}, s_t{i}, k);
    saveas(f, sprintf('Results/q2_%i.png', i))
    close(f)
end
