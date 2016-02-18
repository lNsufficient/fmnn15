clear;

beta = 1;
g = @(x, y) (pi^2*10-beta)*sin(pi*x)*sin(3*pi*y);
f_corr = @(x, y) sin(pi*x)*sin(3*pi*y);
interval = 1;


Ncoarse = 31;
dx2 = 1/(Ncoarse+1)^2;
x = linspace(0,interval,Ncoarse+2);
x = x(2:end-1)';

f = zeros(Ncoarse,Ncoarse);
for i = 1:Ncoarse
    f(i,:) = g(x(i),x);
end

%surf(x, x, f)
Nfine = 2^12 - 1;
nbrProlongs = log2(Nfine + 1) - log2(Ncoarse + 1);
v = zeros(Ncoarse,Ncoarse);
v =FMGV(f, v, beta);

r = residual(f, v, beta);
max(max(abs(r)))

gamma = 1/2;
for i = 1:nbrProlongs
    dx2 = 1/(length(v) + 1)^2;
    D = 4/dx2-beta;
    v = prolong(v);
    v = v - gamma*v/D; %*%*
end


x = linspace(0,interval,Nfine+2)';
x = x(2:end-1);
%surf(x, x, v)

f = zeros(Nfine,Nfine);
for i = 1:Nfine
    f(i,:) = g(x(i),x);
end
r = max(max(abs(residual(f, v, beta))));

u = v;
nbrV = 20;
for i = 1:nbrV
    u = FMGV(f, u, beta);
end
surf(x, x, u)

u_corr = zeros(Nfine,Nfine);
for i = 1:Nfine
    u_corr(i,:) = f_corr(x(i),x);
end

res = abs(u - u_corr);
semilogy(x, max(res));
%plot([0 ; x; interval], [bc0; u; bc1]);