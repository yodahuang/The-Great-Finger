function mouse_select_main(target, filePath, start, ending, radius, outName)
    %Example: mouse_select_main(true, 'Dataset/sample_frames/', 2, 5, 2, 'yanda.mat');
    outDir = strcat('Dataset/SkinClassifier/',int2str(radius), '/');
    totalFileList = cellstr(ls(strcat(filePath, '*.png')));
    selectedFiles = totalFileList(start+1:ending+1);
    selectedPoints = [];
    for k = 1:length(selectedFiles)
        imageName = selectedFiles{k};
        selectedPoints = cat(1, mouse_select(strcat(filePath, imageName), radius), selectedPoints);
    end
    [~, ~, dim] = size(selectedPoints);
    assert(dim==5);
    if (target)
        selectedPoints(:,:,dim+1) = 2;
    else
        selectedPoints(:,:,dim+1) = 1;
    end
    save(strcat(outDir, outName), 'selectedPoints');
end