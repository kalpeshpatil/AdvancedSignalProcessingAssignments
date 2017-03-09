function [beamforming,capon,root_music,ESPRIT,n_sample] = q2()
% load input data
load('../data/submarine.mat');
n_sample = 1028;
dl = d/lambda;
beamforming = beamform(X, n_sample, dl);
capon = capon_sp(X, n_sample, dl);
root_music = root_music_doa(X, 2, dl);
ESPRIT = esprit_doa(X, 2, dl);
end

