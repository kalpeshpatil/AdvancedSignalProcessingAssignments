function [psd_AR,freq] = AR_autocorrelation_spectrum(x,p,K)
r = find_correlation(x);
[X,Rxx_autocorr_AR] = corrmtx(x,p,'autocorrelation');
%Rxx_autocorr_AR = X'*X;
temp = Rxx_autocorr_AR(2:end,2:end);
r_AR = -r(2:p+1);
a_AR = temp\r_AR;
a_AR = [1,a_AR.'].';
error_sq_AR = 0;
for j = 1:p+1
   error_sq_AR = error_sq_AR + a_AR(j)*conj(r(j));
end

error_AR = sqrt(abs(error_sq_AR));

[h,w] = freqz(error_AR,a_AR,'whole',1024);
psd_AR = abs(fftshift(h)).^2;
freq = w - pi;
end