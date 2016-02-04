function v = FMGV(f, v, bc0, bc1)
%v = FMGV(v, T, f)
%    full recursive multigrid method
N = length(v);
dx2 = (1/(N+1))^2;
if N <= 31
    sub = ones(N-1, 1);
    T = (diag(sub,-1) + diag([1; sub]*(-2), 0) + diag(sub,1))/dx2;
    bc = zeros(N, 1);
    bc(1) = bc0;
    bc(end) = bc1;
    v = T\(f - bc/dx2);
    return
else
    gamma = 1/2;
    T = [1 -2 1]/dx2; %*%*
    rf = residual(f, v, bc0, bc1);
    D = T(2); %*%*
    v = v - gamma*rf/D; %*%*
    rf = residual(f, v, bc0, bc1);
    rf = lowpass(rf);
    rc = restrict(rf);
    ec = FMGV(rc, zeros(length(rc),1), 0, 0); 
    ef = prolong(ec, 0, 0);
    v = v - ef;
    rf = residual(f, v, bc0, bc1);
    v = v - gamma*rf/D; %*%*
    return
end
end

