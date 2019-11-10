im_0 = imread('C:\Users\Muhammad Usman\Documents\S7\Vision\panorama\im0.png');
im_1 = imread('C:\Users\Muhammad Usman\Documents\S7\Vision\panorama\im1.png');

subplot(2,2,1);
imshow(im_0);
subplot(2,2,2); 
imshow(im_1);

mapPts_corner = [1 1; 441 1; 441 604; 441 604];
%mapPts_0 = [273 130; 522 24; 344 374; 600 332];
%mapPts_1 = [113 148; 364 53; 179 396; 430 355];
mapPts_0 = [130 273; 24 522; 374 344; 332 600];
mapPts_1 = [148 113; 53 364; 396 179; 355 430];

imPts = im_0;

for i = -2:2
    for j = -2:2
        imPts(mapPts_0(1,:),:) = [0, 0, 0];
    end
end

subplot(2,2,3);
imshow(im_0);

%mapMat_10 = [
%    0 0 0 -mapPts_1(1,1) -mapPts_1(1,2) -1 mapPts_0(1,2)*mapPts_1(1,1) mapPts_0(1,2)*mapPts_1(1,2) mapPts_0(1,2)
%    mapPts_1(1,1) mapPts_1(1,2) 1 0 0 0 -mapPts_0(1,1)*mapPts_1(1,1) -mapPts_0(1,1)*mapPts_1(1,2)  -mapPts_0(1,1)
%    0 0 0 -mapPts_1(2,1) -mapPts_1(2,2) -1 mapPts_0(2,2)*mapPts_1(2,1) mapPts_0(2,2)*mapPts_1(2,2) mapPts_0(2,2)
%    mapPts_1(2,1) mapPts_1(2,2) 1 0 0 0 -mapPts_0(2,1)*mapPts_1(2,1) -mapPts_0(2,1)*mapPts_1(2,2)  -mapPts_0(2,1)
%    0 0 0 -mapPts_1(3,1) -mapPts_1(3,2) -1 mapPts_0(3,2)*mapPts_1(3,1) mapPts_0(3,2)*mapPts_1(3,2) mapPts_0(3,2)
%    mapPts_1(3,1) mapPts_1(3,2) 1 0 0 0 -mapPts_0(3,1)*mapPts_1(3,1) -mapPts_0(3,1)*mapPts_1(3,2)  -mapPts_0(3,1)
%    0 0 0 -mapPts_1(4,1) -mapPts_1(4,2) -1 mapPts_0(4,2)*mapPts_1(4,1) mapPts_0(4,2)*mapPts_1(4,2) mapPts_0(4,2)
%    mapPts_1(4,1) mapPts_1(4,2) 1 0 0 0 -mapPts_0(4,1)*mapPts_1(4,1) -mapPts_0(4,1)*mapPts_1(4,2)  -mapPts_0(4,1)
%    0 0 0 -mapPts_1(5,1) -mapPts_1(5,2) -1 mapPts_0(5,2)*mapPts_1(5,1) mapPts_0(5,2)*mapPts_1(5,2) mapPts_0(5,2)
%    mapPts_1(5,1) mapPts_1(5,2) 1 0 0 0 -mapPts_0(5,1)*mapPts_1(5,1) -mapPts_0(5,1)*mapPts_1(5,2)  -mapPts_0(5,1) 
%];

mapMat_10 = zeros(2*length(mapPts_1),9);

for i = 1 : length(mapPts_1)
    mapMat_10(2*i-1,4:6) = -1.*[mapPts_1(i,:) 1];
    mapMat_10(2*i-1,7:9) = mapPts_0(i,2).*[mapPts_1(i,:) 1];
    mapMat_10(2*i,1:3) = [mapPts_1(i,:) 1];
    mapMat_10(2*i,7:9) = -mapPts_0(i,1).*[mapPts_1(i,:) 1];
end

mapMatB = mapPts_0';
mapMatB = mapMatB(:);

[U,S,V] = svd(mapMat_10);

nullNum = 0;
for i = 1 : min(size(S))
   if (round(S(i,i),0)==0)
       nullNum = i;
       break;
   end
end

if ~nullNum
    fprintf('Cannot determine nullspace from SVD.\n\r');
else
    fprintf('The null space is %d column of V*\n\r', nullNum);
end

nullSpace = V(:,nullNum);

H = vec2mat(nullSpace,3);

% 
% mapPts_10 = zeros(4,2);
% 
% for i = 1 : length(mapPts_10)
%    tmp0 = H*[mapPts_corner(i,:) 1]';
%    tmp0 = tmp0./tmp0(3);
%    mapPts_10(i,:) = [tmp0(1) tmp0(2)];
% end
% 
% 
% size_box = [min(min(mapPts_10, mapPts_corner))
%             max(max(mapPts_10, mapPts_corner))];
% 
% size_box = round(size_box,0);
% imPort = zeros(size_box(2,1) - size_box(1,1) + 1, size_box(2,2) - size_box(1,2) + 1, 3);
% portSize = size(imPort);        
%         
% 
% im_1_size = size(im_1);
% for i = 1 : im_1_size(1)
%     for c = 1 : im_1_size(2)
%         projPos = H*[i; c; 1];
%         projPos = round(projPos./projPos(3),0);
%         imPort(projPos(1)-size_box(1,1)+1, projPos(2)-size_box(1,2)+1,:) = im_1(i,c,:);
%     end
% end
% 
% 
% im_0_size = size(im_0);
% for i = 1 : im_0_size(1)
%     for c = 1 : im_0_size(2)
%         imPort(i-size_box(1,2)+1,c-size_box(1,1)+1,:) = im_0(i,c,:);
%     end
% end
%         
        
%---------------------        
mapPts_01 = zeros(4,2);

H_01 = inv(H);

for i = 1 : length(mapPts_01)
   tmp0 = H_01*[mapPts_corner(i,:) 1]';
   tmp0 = tmp0./tmp0(3);
   mapPts_01(i,:) = round([tmp0(1) tmp0(2)]);
end

minCoords = min(min(mapPts_corner, mapPts_01));
maxCoords = max(max(mapPts_corner, mapPts_01));
sizePan = round(maxCoords-minCoords);

imPan = zeros([sizePan,3]);

im_0_size = size(im_0);
minPos = [1; 1; 1];
for i = 1 : im_0_size(1)
    for c = 1 : im_0_size(2)
        projPos = H_01*[c; i; 1];
        projPos = round(projPos./projPos(3),0);
%        minPos = min(projPos, minPos);
%        imPan(projPos(2)-minCoords(2)+1, projPos(1)-minCoords(1)+1,:) = im_0(i,c,:);
        imPan(projPos(2)+115+1, projPos(1),:) = im_0(i,c,:);
    end
end        
subplot(2,2,3);
imshow(uint8(imPan));


im_1_size = size(im_1);
for i = 1 : im_1_size(1)
    for c = 1 : im_1_size(2)
%        imPan(i-minCoords(2)+1,c-minCoords(1)+1,:) = im_1(i,c,:);
        imPan(i, c+115+1,:) = im_1(i,c,:);
    end
end


subplot(2,2,4);
imshow(uint8(imPan));
%----------------------        
        
        
% 
% mapMatA = [
%     mapPts_1(1,1) mapPts_1(1,2) 1 0 0 0 -mapPts_0(1,1)*mapPts_1(1,1) -mapPts_0(1,1)*mapPts_1(1,2) mapPts_0(1,1)
%     0 0 0 mapPts_1(1,1) mapPts_1(1,2) 1 -mapPts_0(1,2)*mapPts_1(1,1) -mapPts_0(1,2)*mapPts_1(1,2) mapPts_0(1,2)
%     mapPts_1(2,1) mapPts_1(2,2) 1 0 0 0 -mapPts_0(2,1)*mapPts_1(2,1) -mapPts_0(2,1)*mapPts_1(2,2) mapPts_0(2,1)
%     0 0 0 mapPts_1(2,1) mapPts_1(2,2) 1 -mapPts_0(2,2)*mapPts_1(2,1) -mapPts_0(2,2)*mapPts_1(2,2) mapPts_0(2,2)
%     mapPts_1(3,1) mapPts_1(3,2) 1 0 0 0 -mapPts_0(3,1)*mapPts_1(3,1) -mapPts_0(3,1)*mapPts_1(3,2) mapPts_0(3,1)
%     0 0 0 mapPts_1(3,1) mapPts_1(3,2) 1 -mapPts_0(3,2)*mapPts_1(3,1) -mapPts_0(3,2)*mapPts_1(3,2) mapPts_0(3,2)
%     mapPts_1(4,1) mapPts_1(4,2) 1 0 0 0 -mapPts_0(4,1)*mapPts_1(4,1) -mapPts_0(4,1)*mapPts_1(4,2) mapPts_0(4,1)
%     0 0 0 mapPts_1(4,1) mapPts_1(4,2) 1 -mapPts_0(4,2)*mapPts_1(4,1) -mapPts_0(4,2)*mapPts_1(4,2) mapPts_0(4,2)
% ];
% ns = rref(mapMatA);
% ns = ns(:,9);
% ns(9) = 1;
% ns = vec2mat(ns,3);





% mapMat_10 = zeros(2*length(mapPts_1),9);
% 
% for i = 1 : length(mapPts_1)
%     mapMat_10(2*i-1,4:6) = -1.*[mapPts_1(i,:) 1];
%     mapMat_10(2*i-1,7:9) = mapPts_0(i,2).*[mapPts_1(i,:) 1];
%     mapMat_10(2*i,1:3) = [mapPts_1(i,:) 1];
%     mapMat_10(2*i,7:9) = -mapPts_0(i,1).*[mapPts_1(i,:) 1];
% end
% 
% mapMatB = mapPts_0';
% mapMatB = mapMatB(:);
% 
% [U,S,V] = svd(mapMat_10);
% 
% nullNum = 0;
% for i = 1 : min(size(S))
%    if (round(S(i,i),0)==0)
%        nullNum = i;
%        break;
%    end
% end
% 
% if ~nullNum
%     fprintf('Cannot determine nullspace from SVD.\n\r');
% else
%     fprintf('The null space is %d column of V*\n\r', nullNum);
% end
% 
% nullSpace = V(:,nullNum);
% 
% H_10 = vec2mat(nullSpace,3);
% H_01 = inv(H_10);