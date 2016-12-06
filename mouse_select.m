function points = mouse_select(file, radius)
I = imread(file);
imshow(I);
[leny, lenx, ~] = size(I);
[x, y] = ginput;
x = int32(round(x));
y = int32(round(y));
side = radius * 2 + 1;
% number of points * size of square * 5
points = zeros(size(x, 1), side^2, 5);
for i = 1: size(x, 1)
    for xx = x(i)-radius: x(i)+radius
        for yy = y(i)-radius: y(i)+radius
            % contain x, y, R, G, B
            sx = xx - x(i) + radius;
            sy = yy - y(i) + radius + 1;
            disp([xx,yy]);
            if xx > 0 && yy > 0 && xx <= lenx && yy <= leny
                points(i,sx*side+sy,:) = [xx, yy, reshape(int32(I(yy,xx,:)),[1,3])];
            else
                points(i,sx*side+sy,:) = NaN(1,1,5);
            end
        end
    end
end

end