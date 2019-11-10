ptsA = [136 270; 372 338; 366 478; 27 527];
ptsB = [147 108; 394 174; 383 308; 59 363];

[H_ab, H_ba] = projMatrix(ptsA, ptsB);

ptsAB = mapPt(H_ab, ptsA);
ptsBA = mapPt(H_ba, ptsB);

options = optimset('GradObj', 'off', 'Maxiter', 400, 'Display', 'iter');
[thetaFinal, cost] = fminunc(@(t)costHomography(t,ptsA,ptsB), H_ab, options);

%error = projCost(theta, ptsA, ptsB);


