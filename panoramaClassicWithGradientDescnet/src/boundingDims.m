function [ dims, imProjSize ] = boundingDims( mapCornerPts, cornerPts )
%boundingDims Evaluate corner points using corner points
%             and mapped corner points.

minHeight = min(mapCornerPts(1,1), mapCornerPts(4,1));
minHeight = min(minHeight, cornerPts(1,2));
maxHeight = max(mapCornerPts(2,1), mapCornerPts(3,1));
maxHeight = max(maxHeight, cornerPts(3,1));
minWidth = min(mapCornerPts(1,2), mapCornerPts(2,2));
minWidth = min(minWidth, cornerPts(1,1));
maxWidth =  max(mapCornerPts(3,2), mapCornerPts(4,2));
maxWidth = max(maxWidth, cornerPts(3,2));
imProjSize = [maxHeight - minHeight, maxWidth - minWidth];

dims = [minHeight, maxHeight; minWidth, maxWidth];

end

