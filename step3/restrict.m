function mc = restrict(mf)
%mc = restrict(mf)
%   restricts the vector (only keeping odd elements)
N = length(mf);
mc = mf((2:2:N),(2:2:N));

end

