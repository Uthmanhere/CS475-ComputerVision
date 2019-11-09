function [ imOut ] = invProj( imFrame, im, H, dims, dimsOut )
%invProj Project image on other plance using projection matrix
%        according to dimensions and sizes.

[imHeight, imWidth, ~] = size(im);

for i = dims(1,1) : dims(1,2)
    for c = dims(2,1) : dims(2,2)
        projPos = H*[i; c; 1];
        projPos = round(projPos./projPos(3),0);

        if (projPos(1) <= 0 || projPos(2) <= 0 || projPos(1) >= imHeight || projPos(2) >= imWidth)
             continue;
        end
        if (i <= dimsOut(1) && c <= dimsOut(2) && i >= 1 && c >= 1)
             continue;
        end
        imFrame(i-dims(1,1)+1, c-dims(2,1)+1,:) = im(projPos(1),projPos(2),:);
    end
end

imOut = imFrame;

end

