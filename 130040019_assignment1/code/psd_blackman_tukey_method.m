function [psd_bmt_32,psd_bmt_128] = psd_blackman_tukey_method(x)
N = length(x);
M = 32;
fft_len = 1024;
rxw_padded = zeros(fft_len,1);
rx = find_correlation(x);
w = zeros(length(rx),1);
w(N - M : N + M) = bartlett(2*M + 1);
rxw_padded(1:length(rx)) = rx.*w;
psd_bmt_32 = abs(fftshift(fft(rxw_padded,fft_len)));


N = length(x);
M = 128;
fft_len = 1024;
rxw_padded = zeros(fft_len,1);
rx = find_correlation(x);
w = zeros(length(rx),1);
w(N - M : N + M) = bartlett(2*M + 1);
rxw_padded(1:length(rx)) = rx.*w;
psd_bmt_128 = abs(fftshift(fft(rxw_padded,fft_len)));

end

function [rx] = find_correlation(x)
for i = 1:length(x)
    sum = 0;
    for j = i:length(x)
        sum = sum + x(j)*(x(j-i+1));
    end
    rx_pos(i) = sum/length(x);
end
pos_len = length(x);
rx = zeros(2*pos_len - 1,1);
rx(pos_len) = rx_pos(1);
for t = 2:length(rx_pos)
    rx(pos_len + t - 1) = rx_pos(t);
    rx(pos_len - t + 1) = rx_pos(t);
end

end

