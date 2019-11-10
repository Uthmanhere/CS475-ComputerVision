function [ meanSqError ] = projCost( theta_ab, ptsA, ptsB )
%PROJCOST 

%theta_ab = vec2mat(theta_ab, 3);
%theta_ab = theta_ab';
theta_ba = inv(theta_ab);
ptsAB = mapPt(theta_ab, ptsA);
ptsBA = mapPt(theta_ba, ptsB);

subCostA = (ptsA - ptsBA).^2;
subCostB = (ptsB - ptsAB).^2;

meanSqError = sum(sum(subCostA + subCostB));

end

