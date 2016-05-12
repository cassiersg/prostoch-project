% @Authors Gaetan Cassiers & Bruno Losseau
% @Course LINMA1731 - PROJECT - UCL
% @Date 12/05/16
% Script that computes and plots the results for question 6.

[CRLBrms, RMS] = q6();
k_max = length(RMS);
f = figure('Name','q6 : CRLB and RMS error considering relative position');
plot(1:k_max,CRLBrms,'.',1:k_max,RMS,'.');
legend({'CRLB','RMS error'}, 'Location', 'northwest');
saveas(f, sprintf('Results/q6.png'));
close(f);
