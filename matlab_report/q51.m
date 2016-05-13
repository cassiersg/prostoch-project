function [xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    q51()
% Q51 simulates the system and the observation process for the artificial 
% submarine tracking problem initialised with 'data.m', with SIR filtering
% and zero process noise.
% For a graphical visualization of the results, see PLOT_Q5.m
% OUTPUT : see Q4Q5.m

[xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    q4q5('SIR', 0, +Inf);

end
