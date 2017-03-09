function [A] = findConvolutionMatrix(h,x)
    N = length(x);
    L = length(h);
    M = N + L -1;
    A = zeros(M,N);
    for i = 1:M
        for j = max(1,i-length(h)+1):min(i,N)
                A(i,j) = h(i-j+1);
        end
    end
end

