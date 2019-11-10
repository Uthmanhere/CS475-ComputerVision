function [ corner ] = cornerDim( im )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

imSize = size(im);

corner = [1 1; imSize(1) 1; imSize(1) imSize(2); 1 imSize(2)];

end

