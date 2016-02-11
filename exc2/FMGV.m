function v = FMGV(f, v, beta)
%v = FMGV(v, T, f)
%    full recursive multigrid method
N = length(v);
dx2 = (1/(N+1))^2;
if N <= 31
    %This can be speeded up by generating sparse matrix
    %Not yet implemented beta.
    main=(-4+beta*dx2)*ones(N^2, 1); 
    sub =ones(N^2, 1);
    sub(N*(1:N-1)) = 0;
    outer = ones(N^2, 1);
    T = spdiags([outer sub main [1; sub(1:end-1)] outer]/(-dx2), [-N, -1, 0, 1, N], N^2, N^2);
    %spy(T(1:40, 1:40))
    v = T\reshape(f', N^2, 1);
    v = vec2mat(v, N);
    return
else
    gamma = 1/2;
    %T = [1 -2 1]/dx2; %*%*
    rf = residual(f, v, beta);
    D = 4/dx2-beta;
    v = v - gamma*rf/D; %*%*
    rf = residual(f, v, beta);
    rf = lowpass(rf);
    rc = restrict(rf);
    ec = FMGV(rc, zeros(length(rc),length(rc)), beta); 
    ef = prolong(ec);
    v = v - ef;
    rf = residual(f, v, beta);
    v = v - gamma*rf/D; %*%*
    return
end
end

