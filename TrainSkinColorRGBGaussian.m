function [model, cluster_to_label] = TrainSkinColorRGBGaussian(rgb, label)
%% Fit a Gaussian mixture model of 20 clusters, using R, G, B, H, S values
%% return: model -- the gmdistribution object
%%         cluster_to_label -- the list of the probability for each cluster to be skin or non-skin
rgb = double(rgb);
[h, s, ~] = rgb2hsv(rgb ./ 255);

k = 20;
min_sample = 1 / 2 / k;
model = fitgmdist([rgb, h, s], k, 'RegularizationValue', 0.01);
idx = cluster(model, [rgb, h, s]);

cluster_to_label = zeros(k, 2);
for i = 1:k
    % remove the clusters that has too few samples
    if (model.ComponentProportion(i) < min_sample)
        cluster_to_label(i, :) = [0, 0];
    else
        cluster_labels = label(idx == i);
        cluster_to_label(i, 2) = sum(cluster_labels) / size(cluster_labels, 1) - 1;
        cluster_to_label(i, 1) = 1 - cluster_to_label(i, 2);
    end
end

end
