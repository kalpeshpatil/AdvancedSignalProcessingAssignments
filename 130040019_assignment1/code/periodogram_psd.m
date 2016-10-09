function [perdgrm,x]=periodogram_psd(input,size)
N=length(input);
fft_length=2*N;

FFT=fft(input(1:size),fft_length); 
FFT_shifted=fftshift(FFT);
FFT_shifted_conj=conj(FFT_shifted);
perdgrm=FFT_shifted.*FFT_shifted_conj./size;
x=0:(2*pi)/fft_length:2*pi-2*pi/fft_length;

end

