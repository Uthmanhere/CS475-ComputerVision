function [ im_ba, im_ab ] = classicPanorama( im_a, im_b, H_ab, H_ba)
%classicPanorama Projects one image plane to the other using
%                projection matrices.

cornerPts_a = cornerDim( im_a );
cornerPts_b = cornerDim( im_b );

mapCornerPts_ba = mapPt(H_ba, cornerPts_b);
mapCornerPts_ab = mapPt(H_ab, cornerPts_a);

[dims_ba, imProjSize_ba] = boundingDims(mapCornerPts_ba, cornerPts_b);
[dims_ab, imProjSize_ab] = boundingDims(mapCornerPts_ab, cornerPts_a);

im_ba = zeros([imProjSize_ba 3]);
im_ab = zeros([imProjSize_ab 3]);

dimsOut_a = size(im_a);
dimsOut_b = size(im_b);

im_ba = invProj(im_ba, im_b, H_ab, dims_ba, dimsOut_a);
im_ba = imShift(im_ba, im_a, [dims_ba(1,1), dims_ba(2,1)]);


im_ab = invProj(im_ab, im_a, H_ba, dims_ab, dimsOut_b);
im_ab = imShift(im_ab, im_b, [dims_ab(1,1), dims_ab(2,1)]);

end

