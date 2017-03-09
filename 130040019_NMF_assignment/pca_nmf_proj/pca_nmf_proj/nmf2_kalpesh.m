clear all
close all
% nmf_main('show', 101)
% nmf_main('learn', 10125)
global imloadfunc
imloadfunc = 'pgma_read';
%%
train = orldata_train('nmf');
test = orldata_test('nmf');
load('results/experiment-10125.mat');
load('results/orldata.mat');
orlImgTrain = train(:,1);
h_train = ((inv(W'*W))*W')*orlImgTrain;
h_train = h_train.*double((h_train > 0));
WH = W*H;
orlImgTrainEst = WH(:,1);
or2 = W*h_train;
a = orlImgTrain/max(orlImgTrain);
b = orlImgTrainEst/max(orlImgTrainEst);
train_mse = (mean((a-b).^2))
%

% plot((H(1,10)/h_train(1))*h_train)
% hold on
% plot(H(:,10),'r')

%%
fig = figure;
set(gcf, 'Position', get(0, 'Screensize'));
subplot(1,2,1)
imshow(reshape(orlImgTrain,56,46),[min(orlImgTrain) max(orlImgTrain)]);
title('Original Train Image')
% subplot(1,2,1)
% imshow(reshape(or2,56,46),[min(or2) max(or2)])
subplot(1,2,2)
imshow(reshape(orlImgTrainEst,56,46),[min(orlImgTrainEst) max(orlImgTrainEst)]);
title('Reconstructed Train Image')
saveas(fig,'../results/q4_a.jpg','jpg');

%%
orlImgTest = test(:,7);
h_test = ((inv(W'*W))*W')*orlImgTest;
h_test = h_test.*double((h_test > 0));
orlImgTestEst = W*h_test;
a = orlImgTest/max(orlImgTest);
b = orlImgTestEst/max(orlImgTestEst);
test_mse = (mean((a-b).^2))

%%
fig = figure;
set(gcf, 'Position', get(0, 'Screensize'));
subplot(1,2,1)
imshow(reshape(orlImgTest,56,46),[min(orlImgTest) max(orlImgTest)]);
title('Original Test Image')
subplot(1,2,2)
imshow(reshape(orlImgTestEst,56,46),[min(orlImgTestEst) max(orlImgTestEst)]);
title('Reconstructed Test Image')
saveas(fig,'../results/q4_b.jpg','jpg');

%%
myImg = rgb2gray(imread('myImg.jpg'));
myImg = imresize(myImg,'outputSize',[56,46]);
myImg_vec = double(myImg(:));
h_myImg = ((inv(W'*W))*W')*myImg_vec;
h_myImg = h_myImg.*double((h_myImg > 0));
myImg_vecEst = W*h_myImg;
a = myImg_vec/max(myImg_vec);
b = myImg_vecEst/max(myImg_vec);
myImg_mse = (mean((a-b).^2))
%%
fig = figure;
set(gcf, 'Position', get(0, 'Screensize'));
subplot(1,2,1)
imshow(reshape(myImg_vec,56,46),[min(myImg_vec) max(myImg_vec)]);
title('Original My Image')
subplot(1,2,2)
imshow(reshape(myImg_vecEst,56,46),[min(myImg_vecEst) max(myImg_vecEst)]);
title('Reconstructed My Image')
saveas(fig,'../results/q4_c.jpg','jpg');
