function [beamforming,capon,root_music,ESPRIT,n_sample] = q1(theta)
P_mat = [1,0;
    0,1];
n_sample=1028;
y = zeros(10, 100, 50);
beamforming = zeros(50, n_sample);
capon = zeros(50, n_sample);
root_music = zeros(50, 2);
ESPRIT = zeros(50, 2);
for i=1:50
    y(:,:,i) = uladata([0, theta] ,P_mat,100,1,10,0.5);
    beamforming(i,:) = beamform(y(:,:,i), n_sample, 0.5);
    capon(i,:) = capon_sp(y(:,:,i), n_sample, 0.5);
    root_music(i,:) = root_music_doa(y(:,:,i), 2, 0.5);
    ESPRIT(i,:) = esprit_doa(y(:,:,i), 2, 0.5);
end 
end