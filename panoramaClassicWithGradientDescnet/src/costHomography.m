function [MSE] = costHomography(h,pts1,pts2)
%COSTHOMOGRAPHY
no_points = length(pts1(:,1));

pts2h = zeros(no_points,3);
pts2h(1:end,:) = (h* [pts1(1:end,:) ones(no_points,1)]')';
for i = 1:4
    pts2h(i,:) = pts2h(i,:)./pts2h(i,3);
end
pts2h = pts2h(:,1:2);

pts1h = zeros(no_points,3);
pts1h(1:end,:) = (h\ [pts2(1:end,:) ones(no_points,1)]')';
for i = 1:4
    pts1h(i,:) = pts1h(i,:)./pts1h(i,3);
end
pts1h = pts1h(:,1:2);


MSE = (pts1-pts1h).^2 +...
       (pts2-pts2h).^2;
MSE = sum((sum(MSE)))/no_points;
end

