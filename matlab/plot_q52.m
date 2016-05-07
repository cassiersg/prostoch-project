
f = figure();
gen_plot5(5000/3, 'postRPF');
pos = get(f, 'position');
% resize figure;
set(f, 'position', [pos(1:2), 1.2*ceil(pos(3:4))]);
saveas(f, sprintf('../report/img/q52.eps'), 'epsc');
close(f);
