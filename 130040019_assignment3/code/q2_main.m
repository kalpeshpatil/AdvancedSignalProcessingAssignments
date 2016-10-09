%% EE 779: Assignment 1: Q.2
%%% Kalpesh Patil
%%% 130040019


close all 
clear all

% read input data
I01 = getdata('../assgn3_data/I01.dat')';
I10 = getdata('../assgn3_data/I10.dat')';
I40 = getdata('../assgn3_data/I40.dat')';
R01 = getdata('../assgn3_data/R01.dat')';
R10 = getdata('../assgn3_data/R10.dat')';
R40 = getdata('../assgn3_data/R40.dat')';

x01 = R01 + I01*1i;
x10 = R10 + I10*1i;
x40 = R40 + I40*1i;

x_list = [x01,x10,x40];
k_list = [0.01,0.10,0.40];

%% Q2 (a): periodogra for K = 0.01
% Note that complex exponentials are used in input signal hence plots are
% shown for -pi to pi instead of just 0 to pi
fft_len = 1024;
N = length(x01);
% zero padding signal
x_padded = zeros(fft_len,1);
x_padded(1:N) = x01(1:N);
fft_xN = fftshift(fft(x_padded, fft_len));
freq = linspace(-pi,pi,fft_len);
prdgrm_psd_x01 = (abs(fft_xN).^2)/N;
fig = figure; 
plot(freq,10*log10(prdgrm_psd_x01)); 
title('PSD estimate of x01 periodogram method');
xlabel('w');
ylabel('PSD(dB)')
set(gcf, 'Position', get(0, 'Screensize'));
set(gca,'xtick',[-pi,0,3*pi/8,pi/2,5*pi/8,pi]);
set(gca,'xgrid','on');
saveas(fig,'../results/Q2/PSD estimate of x01 periodogram method','jpg');

%% Q2 (b) Spectral Estimates for following methods

%% (i)  : AR model autocorrelation ( p = 7 )
% <include>AR_autocorrelation_spectrum.m</include>

for k = 1:length(k_list)
    x = x_list(:,k);
    [AR_autocorr_psd,freq] = AR_autocorrelation_spectrum(x,7,k_list(k));
    fig = figure;
    plot(freq,10*log10(AR_autocorr_psd));
    title(['PSD estimate Autocorrelation method x',num2str(k_list(k))]);
    xlabel('w');
    ylabel('PSD(dB)');
    set(gcf, 'Position', get(0, 'Screensize'));
    set(gca,'xtick',[-pi,0,3*pi/8,pi/2,5*pi/8,pi]);
    set(gca,'xgrid','on');
    saveas(fig,['../results/Q2/','PSD estimate Autocorrelation method x',num2str(k_list(k))],'jpg');
end

%% (ii) : AR model covariance ( p = 7 )
% <include>AR_covariance_spectrum.m</include>

for k = 1:length(k_list)
    x = x_list(:,k);
    [AR_covar_psd,freq] = AR_covariance_spectrum(x,7,k_list(k));
    fig = figure;
    plot(freq,10*log10(AR_covar_psd));
    title(['PSD estimate covariance method x',num2str(k_list(k))]);
    xlabel('w');
    ylabel('PSD(dB)');
    set(gcf, 'Position', get(0, 'Screensize'));
    set(gca,'xtick',[-pi,0,3*pi/8,pi/2,5*pi/8,pi]);
    set(gca,'xgrid','on');
    saveas(fig,['../results/Q2/','PSD estimate covariance method x',num2str(k_list(k))],'jpg');
end

%% (iii): MUSIC method (8*8 covariance method matrix) 
% <include>MUSIC_spectrum.m</include>

for k = 1:length(k_list)
    x = x_list(:,k);
    [MUSIC_psd,freq] = MUSIC_spectrum(x,7,3,k_list(k));
    fig = figure;
    plot(freq,10*log10(MUSIC_psd));
    title(['PSD estimate MUSIC method x',num2str(k_list(k))]);
    xlabel('w');
    ylabel('PSD(dB)');
    set(gcf, 'Position', get(0, 'Screensize'));
    set(gca,'xtick',[-pi,0,3*pi/8,pi/2,5*pi/8,pi]);
    set(gca,'xgrid','on');
    saveas(fig,['../results/Q2/','PSD estimate MUSIC method x',num2str(k_list(k))],'jpg');
end

%% (iv) : Minimum Norm method (8*8 covariance method matrix)
% <include>minimum_norm_spectrum.m</include>

for k = 1:length(k_list)
    x = x_list(:,k);
    [minimum_norm_psd,freq] = minimum_norm_spectrum(x,7,3,k_list(k));
    fig = figure;
    plot(freq,10*log10(minimum_norm_psd));
    title(['PSD estimate minimum norm method x',num2str(k_list(k))]);
    xlabel('w');
    ylabel('PSD(dB)');
    set(gcf, 'Position', get(0, 'Screensize'));
    set(gca,'xtick',[-pi,0,3*pi/8,pi/2,5*pi/8,pi]);
    set(gca,'xgrid','on');
    saveas(fig,['../results/Q2/','PSD estimate minimum norm method x',num2str(k_list(k))],'jpg');

end

%% All plots combined
% Here all the plots are scaled for comparison.
for k = 1:length(k_list)
    x = x_list(:,k);
    
    [AR_autocorr_psd,freq] = AR_autocorrelation_spectrum(x,7,k_list(k));
    AR_autocorr_psd= (AR_autocorr_psd-min(AR_autocorr_psd))./(max(AR_autocorr_psd)-min(AR_autocorr_psd));
    [AR_covar_psd,freq] = AR_covariance_spectrum(x,7,k_list(k));
    AR_covar_psd = (AR_covar_psd-min(AR_covar_psd))./(max(AR_covar_psd)-min(AR_covar_psd));
    [MUSIC_psd,freq] = MUSIC_spectrum(x,7,3,k_list(k));
    MUSIC_psd = (MUSIC_psd-min(MUSIC_psd))./(max(MUSIC_psd)-min(MUSIC_psd));
    [minimum_norm_psd,freq] = minimum_norm_spectrum(x,7,3,k_list(k));
    minimum_norm_psd = (minimum_norm_psd-min(minimum_norm_psd))./(max(minimum_norm_psd)-min(minimum_norm_psd));
    
    prdgrm_psd_x01 = (prdgrm_psd_x01 - min(prdgrm_psd_x01))./(max(prdgrm_psd_x01)-min(prdgrm_psd_x01));
    
    all_plots = 10*log([prdgrm_psd_x01,AR_autocorr_psd,AR_covar_psd,MUSIC_psd,minimum_norm_psd]);
    fig = figure;
    plot(freq,all_plots);
    title(['Relative PSD plots for x',num2str(k_list(k))]);
    xlabel('w');
    ylabel('PSD(dB)');
    lgnd = legend('Periodogram (base)','AR autocorrelation','AR covariance','MUSIC','Minimum norm');
    lgnd.Orientation = 'horizontal';
    lgnd.Location = 'south';
    set(gcf, 'Position', get(0, 'Screensize'));
    set(gca,'xtick',[-pi,0,3*pi/8,pi/2,5*pi/8,pi]);
    set(gca,'xgrid','on');
    saveas(fig,['../results/Q2/','Relative PSD plots for x',num2str(k_list(k))],'jpg');

end

%% Comparison of different methods
%%
% 
% * AR autocorrelation method is not able to capture all three
% frequencies for any value of noise. It is not suitable for distinguishing closely spaced
% frequencies. 
% * For the lesser values of noise (0.01), AR covariance, MUSIC and minimum
% norm all three work well and produce peaks at given frequencies
% * For the larger values of noise (0.4), AR covarianc is not able to
% capture the middle peak. Also the quality of peaks produced MUSIC method
% decreases. Minimum norm method prodcues better peaks compared to others
% for higher values of noise
% * We also observe deviation of peaks from ideal input frequencies (which
% are displayed as vertical lines in PSD plots). The deviation is observed
% to increase as noise increases. Deviation from actual frequencies:
% Minimum norm < MUSIC < AR covariance < AR autocorrelation
% * Energy in sidelobes (bands other other than peaks) can also be compared
% to observe quality of peaks. Quality of peaks degrade with amount of
% noise. Also it depends on different methods. Energy in sidelobes:
% Minimum norm < MUSIC < AR covariance < AR autocorrelation
% * Overall performance for frequency estimation in line spectrum is: 
%   Minimum norm > MUSIC > AR covariance > AR autocorrelation

