function gen_plot2(s_a, s_t, k)
% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% INPUT :
% s_a, s_t    array of variances, the parameters of the problem
% /!\ s_a and s_t must be of same length and contain same number of element 
%     in each arrow
% k         number of steps
% OUTPUT :
%           plots the results for question 2 of each arrow on a new figure

n = length(s_a);
x = zeros(4, k, n);
z = zeros(n, k);
for i = 1:n
    [x(:,:,i), z(i,:)] = q2(s_a(i), s_t(i), k);
end
subplot(2,1,1)
hold on all
grid on
plot(reshape(x(1,:,:), k, n), reshape(x(2,:,:), k, n), '.-');
title('position');
xlabel('x [m]')
ylabel('y [m]')
legends = cellfun(...
    @(x, y)sprintf('\\sigma_\\alpha^2 = %g, \\sigma_\\theta^2 = %g', x, y),...
    num2cell(s_a),...
    num2cell(s_t),...
    'UniformOutput', false);
legend(legends, 'Location', 'best');

subplot(2,1,2)
hold on all
grid on
plot(1:k, z/pi,'.-')
title('bearing');
xlabel('step')
ylabel('angle (z/\pi)')

end
