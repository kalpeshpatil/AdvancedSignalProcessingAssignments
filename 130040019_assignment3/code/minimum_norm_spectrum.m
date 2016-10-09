function [minimum_norm_psd,freq] = minimum_norm_spectrum(x,M,P,K)
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
V_noise = V(:,1:M-P);
u = zeros(1,M)';
u(1) = 1;

num = (V_noise*V_noise')*u;
den = u'*(V_noise*V_noise')*u;
a = num./den;

spectrum_len = 1024;
freq = linspace(-pi,pi,spectrum_len);
sum_denom = zeros(1,spectrum_len);


for j = 1:length(freq)
    w = freq(j); 
    sum_temp = 0;
    for k = 1:M
        sum_temp = sum_temp + (exp(-1i*(k-1)*w))*a(k);
    end
    sum_denom(j) = (abs(sum_temp))^2;
end

minimum_norm_psd = 1./sum_denom;


minimum_norm_psd = minimum_norm_psd';

end

