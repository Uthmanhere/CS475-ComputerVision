function [ H_ab, H_ba ] = projMatrix( pt_a, pt_b )
%projMatrix Evaluates forward and backward projection
%           Matrix for given points.


eqMat = zeros(2*length(pt_b),9);

for i = 1 : length(pt_b)
    eqMat(2*i-1,4:6) = -1.*[pt_b(i,:) 1];
    eqMat(2*i-1,7:9) = pt_a(i,2).*[pt_b(i,:) 1];
    eqMat(2*i,1:3) = [pt_b(i,:) 1];
    eqMat(2*i,7:9) = -pt_a(i,1).*[pt_b(i,:) 1];
end

[~,S,V] = svd(eqMat);

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

H_ba = vec2mat(nullSpace,3);
H_ab = inv(H_ba);

end

