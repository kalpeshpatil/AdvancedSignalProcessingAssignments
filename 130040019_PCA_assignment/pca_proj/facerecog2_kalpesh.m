% This is a template that will help you get started on the PCA simulation. You
% will have to submit this file (and two more versions of this - one for reduced
% number of components and the other that uses your PCA algorithm).

load DATA
load imSpace
load pcaEigVals
load pcaEigVecs
load pcaProj
load psi
load w
load zeroMeanSpace

% Call pca_orl to get principle components
pca_orl(200); % fill to get 100 components
testDATA = orldata_test; % Get test images from orldata


%% Case 1: Test using trained image
% Fill to complete 3.(a)
% Use one image from the training data set 
orlImgTrain = DATA(:, 1);
orlImgTrain1 = orlImgTrain - psi; % The 'zero-mean' image
orlImgTrainEst = psi;
% Reconstruct the above image using the PCs by adding the projections of
% the zero mean images onto the eigenvectors
for i=1:100,
	orlImgTrainEst = orlImgTrainEst + (orlImgTrain1' * pcaEigVecs(:,i)) * pcaEigVecs(:,i);
end
trainMSE = (orlImgTrain - orlImgTrainEst)'*(orlImgTrain - orlImgTrainEst)/size(DATA,1);
trainMSE
fig = figure;
set(gcf, 'Position', get(0, 'Screensize'));
subplot(1,2,1)
imshow(reshape(orlImgTrain,112,92),[min(orlImgTrain) max(orlImgTrain)]);
title('Original Train Image');
subplot(1,2,2)
imshow(reshape(orlImgTrainEst,112,92),[min(orlImgTrain) max(orlImgTrain)]);
title('Reconstructed Train Image');
saveas(fig,'../results/q4_a.jpg','jpg');


%%
% train_MSE = 117.4848

%% Case 2: Test using a test image from orl data base
% Fill to complete 3.(b)
orlImgTest = testDATA(:,8);
orlImgTest1 = orlImgTest - psi;
orlImgTestEst = psi;
for i=1:100,
	orlImgTestEst = orlImgTestEst + (orlImgTest1' * pcaEigVecs(:,i)) * pcaEigVecs(:,i);
end
testMSE = (orlImgTest - orlImgTestEst)'*(orlImgTest - orlImgTestEst)/size(DATA,1);
testMSE
fig = figure;
set(gcf, 'Position', get(0, 'Screensize'));
subplot(1,2,1)
imshow(reshape(orlImgTest,112,92),[min(orlImgTest) max(orlImgTest)]);
title('Original Test Image');
subplot(1,2,2)
imshow(reshape(orlImgTestEst,112,92),[min(orlImgTestEst) max(orlImgTestEst)]);
title('Reconstructed Test Image');
saveas(fig,'../results/q4_b.jpg','jpg');

% testMSE = 431.0048



%% Case 3: Test using your face image 
% Read in your image
% Fill to complete 3.(c)
myImg = rgb2gray(imread('myImg.jpg'));
myImg = imresize(myImg,'outputSize',[112,92]);
myImg_vec = double(myImg(:));
myImg_vec1 = myImg_vec - psi;
myImgEst = psi;
for i=1:100,
	myImgEst = myImgEst + (myImg_vec1' * pcaEigVecs(:,i)) * pcaEigVecs(:,i);
end
myImgMSE = (myImg_vec - myImgEst)'*(myImg_vec - myImgEst)/size(DATA,1);
myImgMSE

fig = figure;
set(gcf, 'Position', get(0, 'Screensize'));
subplot(1,2,1)
imshow(reshape(myImg_vec,112,92),[min(myImg_vec) max(myImg_vec)]);
title('Original My Image');
subplot(1,2,2)
imshow(reshape(myImgEst,112,92),[min(myImgEst) max(myImgEst)]);
title('Reconstructed My Image');
saveas(fig,'../results/q4_c.jpg','jpg');

%myImgMSE = 1.6233e+03


%%
% Generate plots to show original and reconstructed images


fig = figure;
plot(pcaEigVals(1:100))
set(gcf, 'Position', get(0, 'Screensize'));
title('PCA Eigenvalues 100');
saveas(fig,'../results/q5_pca_eigenvalues_100.jpg','jpg');

fig = figure;

set(gcf, 'Position', get(0, 'Screensize'));

for j = 1:16
    subplot(4,4,j)
    temp = pcaEigVecs(:,j) + psi;
    imshow (reshape(temp,112,92),[min(temp) max(temp)])
end
saveas(fig,'../results/q5_pca_eigenfaces_100.jpg','jpg');



