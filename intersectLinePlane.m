function [PT, Onplain] = intersectLinePlane(LINE, PLANE)
%Line = [x1 y1 z1; x2 y2 z2];
%Plane = [x1 y1 z1; x2 y2 z2; x3 y3 z3];
%PT = [x; y; z], intersection point at screen
%Onplain = 1 or 0, 1 means it on the plain
tempmatrix = [LINE(1,:)' - LINE(2,:)', PLANE(2,:)' - PLANE(1,:)', PLANE(3,:)' - PLANE(1,:)'];
tempmatrix = tempmatrix^-1;
tuv = tempmatrix * [LINE(1,:)' - PLANE(1,:)'];
PT = LINE(1,:)' + (LINE(2,:)' - LINE(1,:)')*tuv(1);
if(tuv(2) + tuv(3) <= 1 && tuv(2) >=0 && tuv(3) >= 0)
    Onplain = 1;
else
    Onplain = 0;
end
end