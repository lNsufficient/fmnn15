function vsmooth = lowpass(v)
%vsmooth = lowpass(v)
%   Lowpass filtering the vector.

vsmooth = conv(v, [1 2 1]/4,  'same');
end

