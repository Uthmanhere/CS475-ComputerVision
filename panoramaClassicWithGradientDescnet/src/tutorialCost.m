function [ meanSqError ] = tutorialCost( THETA, X, Y )
%TUTORIALCOST Calculate mean square error for
%             predicted theta against real Y
%             over X points.

output = THETA(1)*X + THETA(2);

meanSqError = mean( (output - Y).^2 );

end