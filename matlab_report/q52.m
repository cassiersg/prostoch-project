function [xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    q52()
% Q52 simulates the system and the observation process for the artificial 
% submarine tracking problem initialised with 'data.m', with postRPF
% and zero process noise.
% For a graphical visualization of the results, see PLOT_Q5.m
% OUTPUT : see Q4Q5.m


[xt_estimated, xt_pre_resampling, xt_post_resampling, n_diff] =...
    q4q5('postRPF', 0, 5000/3);

end
