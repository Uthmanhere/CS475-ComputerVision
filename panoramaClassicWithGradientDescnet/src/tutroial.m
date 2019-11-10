% initial function.
m = 2;
c = 3;
x = -10 : 10;
y = m*x + c;

% plot points.
scatter(x,y,'f');

% add noise and plot points.
noise = rand(1, numel(y));
yNoise = y + 3*(noise - 0.5);

hold on;
scatter(x,yNoise,'f');

% gradient descent.
theta = zeros(1,2);
options = optimset('GradObj', 'off', 'Maxiter', 400, 'Display', 'iter');
[thetaFinal, cost] = fminunc(@(t)tutorialCost(t,x,yNoise), theta, options);

% plot prediction.
yPred = thetaFinal(1)*x + thetaFinal(2);
plot(x,yPred);