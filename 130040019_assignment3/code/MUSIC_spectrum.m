function [MUSIC_psd,freq] = MUSIC_spectrum(x,M,P,K)

N = length(x);
Rxx_covar = zeros(M+1,M+1);

for i = 0:M
    for j = 0:M
        sum = 0;
        for n = M+1:N
            sum = sum + x(n-j)*conj(x(n-i));            
        end
        Rxx_covar(j+1,i+1) = sum;
    end
end

X = corrmtx(x,M,'covariance');
Rxx_covar = X'*X;

M = length(Rxx_covar(:,1));
[V,lambda] = eig(Rxx_covar);
spectrum_len = 1024;
freq = linspace(-pi,pi,spectrum_len);
sum_denom = zeros(1,spectrum_len);
for j = 1:length(freq)
    w = freq(j); 
    sum_temp = 0;
    for i = 1:M-P
        v_i = V(:,i);
        temp = 0;
        for k = 1:M
            temp = temp + (exp(-1i*(k-1)*w))*v_i(k);
        end
        sum_temp = sum_temp + (abs(temp))^2;
    end
    sum_denom(j) = sum_temp;
end
MUSIC_psd = 1./sum_denom;
MUSIC_psd = MUSIC_psd';
end

