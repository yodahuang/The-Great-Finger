function P = SkinColorRGBGaussianDetector(model, cluster_to_label, img)

wd = size(img, 1);
ht = size(img, 2);
rgb = [reshape(img(:,:,1), wd*ht, 1), reshape(img(:,:,2), wd*ht, 1), reshape(img(:,:,3), wd*ht, 1)];
rgb = double(rgb);

r = rgb(:,1) ./ (rgb(:,1) + rgb(:,2) + rgb(:,3) + 1);
b = rgb(:,3) ./ (rgb(:,1) + rgb(:,2) + rgb(:,3) + 1);


cluster_assigned = cluster(model, [rgb, r, b]);

P = cluster_to_label(cluster_assigned, 2);

P = reshape(P, wd, ht);


end