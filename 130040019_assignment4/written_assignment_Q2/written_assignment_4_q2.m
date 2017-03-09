% Written Assignment 4: Q2 plots
clear all
close all
theta = -pi/2:pi/180:pi/2;
m = 101;
m1 = (m - 1)/2;
dl=0.5; 
ws1 = 2*pi*dl*sin(theta);
ws2 = 2*pi*dl*cos(theta);
m1=(m-1)/2;
a1 = zeros(m1,length(theta));
a2 = zeros(m1,length(theta));
for k = 1:m1
    a1(k,:) = exp(-k*ws1*1i);
    a2(k,:) = exp(-k*ws2*1i);
end
a = [zeros(1,length(theta))+1;
        a1;
        a2]; 
theta0 = [pi/4,pi/2];
ws10 = 2*pi*dl*sin(theta0);
ws20 = 2*pi*dl*cos(theta0);
a10 = zeros(m1,length(theta0));
a20 = zeros(m1,length(theta0));
for k = 1:m1
    a10(k,:) = exp(-k*ws10*1i);
    a20(k,:) = exp(-k*ws20*1i);
end
a0 = [zeros(1,length(theta0))+1;
      a10;
      a20];
W = a0'*a;

fig = figure();
plot(theta*180/pi, abs(W).^2);
ylabel('|W(\theta)|.^2')
title('Written Assignment Q2 plots for \theta0 = 45 degree and \theta0 = 90 degree');
xlabel('Angle (degree)')
set(gcf, 'Position', get(0, 'Screensize'));
legend('45 degree', '90 degree');
saveas(fig,'Written_Assignment_Q2.jpg','jpg');
