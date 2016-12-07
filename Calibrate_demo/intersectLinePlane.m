function PT = intersectLinePlane(LINE, PLANE)
%Line = [x1 y1 z1; x2 y2 z2];
%Plane = [x1 y1 z1; x2 y2 z2; x3 y3 z3];
%PT = [x; y; z], point at screen
tempmatrix = [Line(1,:)' - Line(2,:)', Plane(2,:)' - Plane(1,:)', Plane(3,:)' - Plane(1,:)'];
tempmatrix = tempmatrix^-1;
tuv = tempmatrix * [Line(1,:)' - Plane(1,:)'];
PT = Line(1,:)' + (Line(2,:)' - Line(1,:)')*tuv(1);

end