function [PT, Onplain] = intersectPT(LINE, PLANE)
%Line = [x1 y1 z1; x2 y2 z2];
%Plane = [x1 y1 z1; x2 y2 z2; x3 y3 z3, x4 y4 z4];
%PT = [x; y; z], intersection point at screen
%Onplain = 1 or 0, 1 means it on the plain

%A better function because it takes the average

[PT1, Onplain1] = intersectLinePlane(LINE, [PLANE(1,:);PLANE(2,:);PLANE(3,:)]);
[PT2, Onplain2] = intersectLinePlane(LINE, [PLANE(1,:);PLANE(2,:);PLANE(4,:)]);
[PT3, Onplain3] = intersectLinePlane(LINE, [PLANE(1,:);PLANE(3,:);PLANE(4,:)]);
[PT4, Onplain4] = intersectLinePlane(LINE, [PLANE(2,:);PLANE(3,:);PLANE(4,:)]);
if(Onplain1 == 1 || Onplain2 == 1 || Onplain3 == 1 || Onplain4 == 1)
    Onplain = 1;
else
    Onplain = 0;
end

PT = (PT1 + PT2 + PT3 + PT4)/4;
end