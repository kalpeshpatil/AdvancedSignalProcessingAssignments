%% EE779: PCA_assignment
%% Kalpesh Patil (130040019)
% Note that some unnecessary print statements in the original
% implementation file of PCA have incresed length of the report. Ignore
% them.

%% Q1 and Q2
% Required data was downloded. Code was studied to understand PCA implementation. 

%% Q3 and Q5
facerecog1_kalpesh
%%
% We can notice that MSE in training image is very low compared to that of
% test image and myImg. Training image belong to the same space for which
% Principal Components were extracted. Since it is the best low rank
% approximation of training image, the error is indeed quite low. Also the
% reconstructed face image is almost similar to the original image. Test
% image do not belong the same space, but it still contain faces with
% similar backgrounds, lightening conditions etc. Hence it still be 
% explained with Principal components of training data upto some extenct.
% The error is found to be
% greater that train image but lesser than myImg, which is expected. We
% can also compare reconstructed faces. Reconstruction is worse than
% training image but better than myImg.
% MyImg neither belongs training space, nor does to a similar space. The
% background, lightening conditions etc are drastically different. Hence
% the error is very large and reconstruction is worst amongst all

%%
% Also note the plots of eigenvalues and eigenfaces. Last few eigenvalues
% are very low compared to initial eigenvalues. Higher value in the plot
% implies more important (principal) component. Eigenfaces have struture
% similar to faces, but they are not faces of a particular individual,
% rather a combination of all faces which represents particular
% eigenvector. 

%% Q4 and Q5
% Only 100 principal components
facerecog2_kalpesh
%% 
% The error pattern is still the same (train < test < myImg).
% But we observe increase in training error, because we have used less
% number of (100 instead of 200 as in earlier case) principal components.
% Thishas caused more error in training image. The increase in the error of
% test image and myImg is low compared to increase in the error of train
% image (proportion wise increase). Test image and myImg didn't belong to
% the space, hence error didn't increase by that much amount as it has
% increased in case of training image. 


%% Q6. 

%% 
% Trick used in the paper: 
% Instead of calculating eigenvectors of XX', they claculated eigenvectors
% for X'X. (X is zeroMeanSpace matrix). 
%%
% Modification and Justification:
% X is 10304 by 200 matrix. I tried
% calculating actual eigenvectors of XX', which is a huge (10304*10304)
% matrix. My PC wasn't able to compute that matrix due to unsufficient RAM.
% This computation might be possible if we have sufficient computing power. As
% the paper justifies correctly, it is not necessary to calculate
% eigenvectors of XX', we can manage with eigenvectors of X'X because rank
% of matrix X is maximum 200 and hence other singular values will be zero.
% Therefore there is not point in computing vectors corresponding to them,
% because it is anyway going to be nullified.