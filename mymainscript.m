tic;
dname = uigetdir();
img = imread(fullfile(dname,'barbara256.png'));
img = im2double(img);
% %part 1
    img1 = imnoise(img,'gaussian',0,10);
    %not sure about the intialization
    x0 = rand(size(img1));
    A = dctmtx(size(img1,1));
    alpha = max(eig(A'*A));
    theta = ista(img1,1e-1,1e-4,x0,A,alpha);
    figure;
    imshow(mat2gray(dctmtx(size(img1,1))*theta))

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
            %vec2mat maybe a problem
            sol(i:i+7,j:j+7) = sol(i:i+7,j:j+7)+col2im(out1,[8,8],[8,8],'distinct');
        end
    end
    sol = sol./count;
    figure;
    imshow(mat2gray(sol))
%part 3
    %create the sparse signal
    signal = zeros(100,1);
    for i=1:10
        signal(i*8) = 2*rand;
    end
    h = [1,2,3,4,3,2,1]/16;
    A = convmtx(h',100);
    y = A*signal;
    sd = norm(signal)/20;
    y = imnoise(y,'gaussian',0,sd);
    x0 = randn(100,1);
    alpha = 1;%max(eig(A'*A));
    theta = ista(y,1e-1,1e-4,x0,A,alpha);
    norm(theta-signal)
toc;