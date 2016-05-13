function [xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    q4()
% Q4 estimates the position of the target for the artificial 
% submarine tracking problem initialised with 'data.m', with SIR filtering.
% For a graphical visualization of the results, see PLOT_Q4.m
% OUTPUT : see Q4Q5.m

[xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    q4q5('SIR', 1e-6, +Inf);

end
