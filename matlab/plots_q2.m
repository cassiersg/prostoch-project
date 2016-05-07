
k = 200;
sA = {[0, 0, 0], [0, 0.5, 1], [0, 0.5, 1], [0.5, 0.5, 0.5]};
sT = {[0, 0.5, 1], [0, 0, 0], [0, 0.5, 1], [0.1, 0.1, 0.1]};
for i = 1:length(sA)
    f = figure();
    gen_plot2(sA{i}, sT{i}, k);
    saveas(f, sprintf('../report/img/q2_%i.eps', i), 'epsc')
    close(f)
end