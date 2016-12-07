function distance = getPointToLineDist(theta, rho, x, y)
    a = sin(theta);
    b = cos(theta);
    c = -rho;
    distance = abs(a*x+b*y+c)/sqrt(a^2+b^2);
end