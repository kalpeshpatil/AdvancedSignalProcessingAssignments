%% Q6. 

% Trick used in the paper: 
% Instead of calculating eigenvectors of XX', they claculated eigenvectors
% for X'X. (X is zeroMeanSpace matrix). 

% Justification:
% X is 10304 by 200 matrix. I tried
% calculating actual eigenvectors of XX', which is a huge (10304*10304)
% matrix. My PC wasn't able to compute that matrix due to unsufficient RAM.
% This computation might be possible if we sufficient computing power. As
% the paper justifies correctly, it is not necessary to calculate
% eigenvectors of XX', we can manage with eigenvectors of X'X because rank
% of matrix X is maximum 200 and hence other singular values will be zero.
% Therefore there is not point in computing vectors corresponding to them,
% because it is anyway going to be nullified. 