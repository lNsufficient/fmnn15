function msmooth = lowpass(m)
%msmooth = lowpass(m)
%   Lowpass filtering the matrix.

msmooth = conv2(m, [1 2 1; 2 4 2; 1 2 1]/16,  'same');
end

