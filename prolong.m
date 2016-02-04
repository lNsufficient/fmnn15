function vf = prolong(vc, bc0, bc1)
%vf = prolong(vc, bc0, bc1)
%   prolongs the vector by adding elements.
N = length(vc);
newN = N*2 + 1;
vf = zeros(newN,1 );
vf(2:2:end) = vc;
vf(1:2:end) = conv([1 1]/2, vc);
vf(1) = vf(1) + 1/2*bc0;
vf(end) = vf(end) + 1/2*bc1;
end

