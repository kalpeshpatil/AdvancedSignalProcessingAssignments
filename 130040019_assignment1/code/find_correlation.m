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