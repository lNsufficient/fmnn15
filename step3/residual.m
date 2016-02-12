function res = residual(f, v, gamma)
%res = residual(f, v,beta)
%   Computes the residual using conv for homogenous bc = 0;

%Possible problems:
%Minus sign
%Beta
N = length(v);
dx2 = (1/(N+1))^2;
%Since we are using homogenous bc = 0:
Tdxv = conv2(v, -[0 1 0;1 -dx2/gamma-4 1;0 1 0]*gamma/dx2,  'same');
res = Tdxv - f;
end
