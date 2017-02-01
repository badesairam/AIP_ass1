function out = ista_2(x,err)
    U = kron(dctmtx(8),dctmtx(8));
    phi = rand(32,64);
    A = phi*U;
    lambda = 1;
    x = im2col(x,[8 8]);
    y = phi*x;
    x0 = rand(64,1);
    %err is for checking convergence
    xcurr = x0;
    xdiff = 1;
    iter = 0;
    alpha = max(eig(A'*A));
    while iter < 5000 && xdiff > err
        xprev = xcurr;
        %soft threshold
        xcurr = wthresh((xprev+(A'*(y-A*xprev))/alpha),'s',lambda/(2*alpha));
        iter = iter + 1;
        xdiff = norm(xcurr-xprev);
    end
    theta = xcurr;
    out = U*theta;
