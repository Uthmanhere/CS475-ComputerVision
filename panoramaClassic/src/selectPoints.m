function [ pts ] = selectPoints()
%selectPoints Selects points for correspondences.

[pts_y, pts_x] = getpts();

pts = round([pts_x pts_y]);

end

