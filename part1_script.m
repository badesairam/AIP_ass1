tic;
dname = uigetdir();
img = imread(fullfile(dname,'barbara256.png'));
img = im2double(img);
% %part 1
    img1 = imnoise(img,'gaussian',0,10);
    %not sure about the intialization
    x0 = rand(size(img1));
%     A = dctmtx(size(img1,1));
    A = kron(dctmtx(16),dctmtx(16));
    alpha = max(eig(A'*A));
    theta = ista(img1,1,1e-4,x0,A,alpha);
    figure;
    imshow(mat2gray(dctmtx(size(img1,1))*theta))
toc;