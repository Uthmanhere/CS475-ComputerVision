%----------------------------
%   Find projection matrix
%----------------------------

im_0 = imread('C:\Users\Muhammad Usman\Documents\S7\Vision\panorama\im1.png');
im_1 = imread('C:\Users\Muhammad Usman\Documents\S7\Vision\panorama\im2.png');

%----------------------------
%   Mapped Points
%----------------------------

cornerPts = [1 1; 441 1; 441 604; 1 604];

mapPts_0 = [323 204; 397 220; 324 522; 56 364; 196 284; 139 570; 17 585; 211 501; 391 306; 204 381; 355 430; 9 489; 24 360];
mapPts_1 = [342 30; 419 43; 346 354; 74  205; 212 120; 166 403; 50 420; 234 336; 412 137; 223 218; 375 264; 28 329; 43 202];


%----------------------------
%   Mark mapped points
%----------------------------

imPts_0 = markPt(im_0, mapPts_0, 'blue');
imPts_1 = markPt(im_1, mapPts_1, 'blue');

subplot(2,2,1);
imshow(imPts_0);
subplot(2,2,2);
imshow(imPts_1);


%----------------------------
%   Find projection matrix
%----------------------------


[H_01, H_10] = projMatrix(mapPts_0, mapPts_1);

%----------------------------
%   Map and view points
%----------------------------


mapPts_10 = mapPt(H_10, mapPts_1);
mapPts_01 = mapPt(H_01, mapPts_0);

imPtsProj_10 = markPt(im_0, mapPts_10, 'red');
imPtsProj_01 = markPt(im_1, mapPts_01, 'red');

subplot(2,2,3);
imshow(imPtsProj_10);
subplot(2,2,4);
imshow(imPtsProj_01);