function [ H_ab, H_ba ] = calibratePanorama( im_a, im_b )
%calibratePanorama Calculate projection matrices for input images.

subplot(3,2,1)
ptsA = selectPoints();
imPtsA = markPt(im_a, ptsA, 'blue');
imshow(uint8(imPtsA));

subplot(3,2,2);
ptsB = selectPoints();
imPts_B = markPt(im_b, ptsB, 'blue');
imshow(uint8(imPts_B));

[H_ab, H_ba] = projMatrix(ptsA, ptsB);


ptsBA = mapPt(H_ba, ptsB);
ptsAB = mapPt(H_ab, ptsA);

imPtsProj_ba = markPt(im_a, ptsBA, 'red');
imPtsProj_ab = markPt(im_b, ptsAB, 'red');

options = optimset('GradObj', 'off', 'Maxiter', 400, 'Display', 'iter');
[H, cost] = fminunc(@(t)costHomography(t,ptsA,ptsB), H_ab, options);
H_ab = H;
H_ba = inv(H);


ptsBA = mapPt(H_ba, ptsB);
ptsAB = mapPt(H_ab, ptsA);

imPtsProj_ba = markPt(imPtsProj_ba, ptsBA, 'green');
imPtsProj_ab = markPt(imPtsProj_ab, ptsAB, 'green');

subplot(3,2,3);
imshow(uint8(imPtsProj_ba));
subplot(3,2,4);
imshow(imPtsProj_ab);

end

