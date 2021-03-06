% Script that computes and plots the results for question 6.

[CRLBrms, RMS] = q6();
k_max = length(RMS);
f = figure('Name','q6 : CRLB and RMS error considering relative position');
plot(1:k_max,CRLBrms,'x-.',1:k_max,RMS,'x-.');
xlabel('step'); ylabel('RMS');
legend({'CRLB','RMS error'}, 'Location', 'southwest');
savefig(sprintf('q6'));
close(f);
