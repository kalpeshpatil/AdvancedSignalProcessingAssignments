function [ psd_actual ] = psd_actual()
fft_len = 1024;
rx_padded = zeros(fft_len,1);
rx_len = fft_len - 1;
rx = zeros(rx_len,1);
sigma_not = 1;
rho = 0.95;
const = (sigma_not^2)/(1-rho^2);
rho = 0.95;
rx(fft_len/2) = (sigma_not^2)/(1-rho^2);
for i = 1:(rx_len + 1)/2 - 1
    l = (rx_len + 1)/2 - i;
    rx(i) = const*rho^l;
    rx(rx_len - i + 1) = rx(i);
end
rx_padded(1:rx_len) = rx;
psd_actual = abs(fftshift(fft(rx_padded, fft_len)));
end 

