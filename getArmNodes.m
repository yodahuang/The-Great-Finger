function getArmNodes
    lmat = getNodesFromVideo(true);
    rmat = getNodesFromVideo(false);
    armnodes = ones(size(lmat,1),2,size(lmat,2));
    armnodes(:,1,:) = lmat;
    armnodes(:,2,:) = rmat;
    save('armnodes.mat','armnodes');
end

function nodes = getNodesFromVideo(Left)
if Left == true
    pre = 'left';
else
    pre = 'right';
end
load(sprintf('Dataset/video/5s/%sbackground.mat',pre))
load(sprintf('Dataset/video/5s/%sborders.mat',pre))
load('yanda_model.mat')

frame_folder = sprintf('Dataset/video/5s/%sframes/',pre);

framelist = dir(frame_folder);
background_norm = double(background) ./ repmat(sum(background, 3),1,1,3) * 300;
nodes = [];

% for each frame
for i=2:4
    img = imread(strcat(frame_folder, framelist(i+2).name));
    mask = uint8(zeros(size(img)));
    mask(borders(i,1):borders(i,2), borders(i,3):borders(i,4), :) = ones(borders(i,2)-borders(i,1)+1, borders(i,4)-borders(i,3)+1,3);
    img = img .* mask;
%     figure;
%     imshow(img);
    img_norm = double(img) ./ repmat(sum(img, 3),1,1,3) * 300;
    bgdiff = abs(background_norm - img_norm);
    bgdiff = sum(bgdiff,3) > 20;
    img = img .* uint8(repmat(bgdiff,1,1,3));
%     figure;
%     imshow(img);
    skin_prob = SkinColorRGBGaussianDetector(model, cluster2label, img);
    img = img .* uint8(repmat(skin_prob,1,1,3));
%     figure;
%     imshow(img);
%     figure;
%     imshow(skin_prob>0.9);
%     hold on
    [row, column] = find(skin_prob>0.9);
    skin_indexs = cat(2, row, column);
    % May need to change the params
    [theta, rho] = ransac(skin_indexs', 1000, 8, 0.2);
    [h,~] = size(skin_indexs);
    
    inline_points = [];
    ps = [];
    for i = 1:h
        dist = getPointToLineDist(theta, rho, skin_indexs(i,1), skin_indexs(i,2));
        if (dist < 7)
            inline_points(end+1,:) = skin_indexs(i,:);
            if (dist <= 3)
                ps = [ps; skin_indexs(i,:)];
            end
        end
    end
    [sortedX, sortInd] = sort(ps(:,1));
    Y = ps(:,2);
    sortedY = Y(sortInd);
    len = size(sortInd,1);
    lind = int32(round(0.01 * len));
    rind = int32(round(0.99 * len));
    lp = [sortedX(lind), sortedY(lind)];
    rp = [sortedX(rind), sortedY(rind)];
    nodes = [nodes; lp, rp];
    
%     scatter(inline_points(:,2), inline_points(:,1));
%     scatter(lp(2), lp(1), 100, 5, 'filled');
%     scatter(rp(2), rp(1), 100, 5, 'filled');
%     hold off;
end

end