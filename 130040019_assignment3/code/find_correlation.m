function [rx] = find_correlation(x)
rx = zeros(length(x),1);
for i = 1:length(x)
    sum = 0;
    for j = i:length(x)
        sum = sum + x(j)*conj((x(j-i+1)));
    end
    rx(i) = sum/length(x);
end
end