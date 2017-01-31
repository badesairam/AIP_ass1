tic;
dname = uigetdir();
img = imread(fullfile(dname,'barbara256.png'));
img = im2double(img);
% %part 1
img = imnoise(img,'gaussian',0,10);
%not sure about the intialization
x0 = rand(size(img));
theta = ista(img,1e-1,1e-4,x0,dctmtx(size(img,1)));
imshow(mat2gray(dctmtx(size(img,1))*theta))

%part 2
[row col] = size(img);
count = zeros(size(img));
sol = zeros(size(img));
for i=1:row-7
    for j=1:col-7
        x=img(i:i+7,j:j+7);
        out1 = ista_2(x,1e-4);
        count(i:i+7,j:j+7) = count(i:i+7,j:j+7)+ones(8,8);
        % reshaping the vec to matrix
        sol(i:i+7,j:j+7) = sol(i:i+7,j:j+7)+vec2mat(out1,8);
    end
end
sol = sol./count;
imshow(mat2gray(sol))
%part 3

toc;