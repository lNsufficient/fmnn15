clear;

interval = 1;

bc0 = 1;
bc1 = -1;

Ncoarse = 31;
dx2 = 1/(Ncoarse+1)^2;
x = linspace(0,interval,Ncoarse+2);
x = x(2:end-1);
f = pi^2*cos(pi*x)';

Nfine = 2^10 - 1;
nbrProlongs = log2(Nfine + 1) - log2(Ncoarse + 1);
v = zeros(Ncoarse,1);
v =FMGV(f, v, bc0, bc1);
gamma = 1/2;
for i = 1:nbrProlongs
    dx2 = 1/(length(v) + 1)^2;
    T = [1 -2 1]/dx2;
    D = T(2);
    v = prolong(v, bc0, bc1);
    v = v - gamma*v/D; %*%*
end
x = linspace(0,interval,Nfine+2)';
x = x(2:end-1);
f = pi^2*cos(pi*x);
u = FMGV(f, v, bc0, bc1);
plot([0; x; interval], [bc0; u; bc1]);

