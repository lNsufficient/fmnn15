function res = residual(f, v, bc0, bc1)
%res = residual(f, v, bc0, bc1)
%   Computes the residual using conv. 
N = length(v);
dx2 = (1/(N+1))^2;
Tdxv = conv(v, [1 -2 1]/dx2,  'same');
res = Tdxv - f;
res(1) = res(1) + bc0/dx2;
res(end) = res(end) + bc1/dx2;
end

