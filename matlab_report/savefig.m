function savefig(figname)
% Save a figure to a file (wrapper to allow easy switch of file format)
saveas(gcf, sprintf('Results/%s.eps', figname), 'epsc');
end
