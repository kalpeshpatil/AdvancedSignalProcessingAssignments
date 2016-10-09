function [psd_covar,freq] = AR_covariance_spectrum(x,p,K)
N = length(x);

X = corrmtx(x,p,'covariance');
Rxx_covar = X'*X;
temp = Rxx_covar(2:length(Rxx_covar),2:length(Rxx_covar));
r_covar = -Rxx_covar(2:end,1);
a_covar = inv(temp)*r_covar;
a_covar = [1,a_covar.'].';
error_sq_covar = 0;
for j = 1:p+1
   error_sq_covar = error_sq_covar + a_covar(j)*conj(Rxx_covar(j,1));
end

error_covar = sqrt(abs(error_sq_covar));

[h,w] = freqz(1,a_covar,'whole',1024);
psd_covar = abs(fftshift(h)).^2;
freq = w - pi;
end