function mf = prolong(mc)
%mf = prolong(mc)
%   prolongs the matrix by adding elements.
N = length(mc);
newN = N*2 + 1;
mf = zeros(newN, newN);
mf((2:2:newN),(2:2:newN)) = mc;
mf = 4*lowpass(mf); %2^2 = 4;
end

