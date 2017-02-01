function theta = ista(y,lambda,err,x0,A,alpha)
    %y is the given image
    %err is for checking convergence
    xcurr = x0;
    xdiff = 1;
    iter = 0;
    %alpha = max(eig(A'*A));
    while iter < 5000 && xdiff > err
        xprev = xcurr;
        %soft threshold
        xcurr = wthresh((xprev+(A'*(y-A*xprev))/alpha),'s',lambda/(2*alpha));
        iter = iter + 1;
        xdiff = norm(xcurr-xprev);
    end
    theta = xcurr;
