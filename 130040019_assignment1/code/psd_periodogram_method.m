function [psd_prdgrm_128, psd_prdgrm_512] = psd_periodogram_method(x)
fft_len = 1024;
N = 128;
x_padded = zeros(fft_len,1);
x_padded(1:N) = x(1:N);

fft_xN = fftshift(fft(x(1:N), fft_len));

psd_prdgrm_128 = (abs(fft_xN).^2)/N;

N = 512;
% zero padding signal
x_padded = zeros(fft_len,1);
x_padded(1:N) = x(1:N);
fft_xN = fftshift(fft(x(1:N), fft_len));
psd_prdgrm_512 = (abs(fft_xN).^2)/N;

end

