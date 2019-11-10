function [ ptOut ] = mapPt( H, pt )
%mapPt Maps Points to the required proejction plane.
ptOut = zeros(length(pt),2);

for i = 1:length(pt)
    tmp0 = H*[pt(i,:) 1]';
    tmp0 = tmp0./tmp0(3);
    ptOut(i,:) = round([tmp0(1) tmp0(2)]);
end

