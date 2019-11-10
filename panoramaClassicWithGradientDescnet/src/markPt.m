function [ imOut ] = markPt( im, pos, colorName, ptSize )
%-----------------------------------------
%   Marks image %[im] at position %[pos]
%   with color $[color]
%-----------------------------------------
%   im      --> 3D  any size     length, width, color
%   pos     --> 1D  2 positions     X, Y
%   color   --> 1D  3 positions  R, G, B
%   size    --> 1   constant
%-----------------------------------------

if nargin<4
    ptSize=10;
end

if strcmp(colorName, 'blue')
    color = [0, 0, 255];
elseif strcmp(colorName, 'red')
    color = [255, 0, 0];
elseif strcmp(colorName, 'green')
    color = [0, 255, 0];
end

imOut = im;
imSize = size(im);
for pt = 1:length(pos)
    for i = -ptSize/2:ptSize/2
        for j = -ptSize/2:ptSize/2
            if ( pos(pt,1)+i <= 0 || pos(pt,2)+j <= 0 || pos(pt,1)+i > imSize(1) || pos(pt,2)+j > imSize(2) )
                fprintf(' > Error in marking points: %d, %d\n', pos(1), pos(2));
                continue;
            end

            imOut(pos(pt,1)+i, pos(pt,2)+j,:) = color;
        end
    end
end

end

