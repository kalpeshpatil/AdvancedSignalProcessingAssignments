function [psd_welch_32, psd_welch_128] = psd_welch_method(x)
fft_len = 1024;
N = length(x);
L = 32;
D = L/2;
w = bartlett(L);
sum_psd = zeros(fft_len,1);
K = floor(N/(L-D))-1;
for i = 1:K
    xw_padded = zeros(fft_len,1);
    xw_padded(1:L) = x((i-1)*(L-D)+1:(i-1)*(L-D)+L)'.*w(1:L);
    sum_psd = sum_psd + abs(fftshift(fft(xw_padded, fft_len))).^2; 
    
end 
U = sum(abs(w).^2)/L;
psd_welch_32 = sum_psd/(K*L*U);


L = 128;
D = L/2;
w = bartlett(L);
sum_psd = 0;
K = floor(N/(L-D))-1;
for i = 1:K
    xw_padded = zeros(fft_len,1);
    xw_padded(1:L) = x((i-1)*(L-D)+1:(i-1)*(L-D)+L)'.*w(1:L);
    sum_psd = sum_psd + abs(fftshift(fft(xw_padded, fft_len))).^2; 
end  
U = sum(abs(w).^2)/L;
psd_welch_128 = sum_psd/(K*L*U);
end

