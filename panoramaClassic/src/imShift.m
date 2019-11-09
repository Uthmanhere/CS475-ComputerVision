function [ imOut ] = imShift( imOut, im, shift )
%imShift Shift image and paste it over defined offset
%        in the new frame.

[imHeight, imWidth, ~] = size(im);

for i = 1:imHeight
    for c = 1:imWidth
        imOut(i-shift(1)+1, c-shift(2)+1,:) = im(i,c,:);
    end
end

end

