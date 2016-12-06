function mouse_select_main(target, filePath, start, ending, radius, outName)
    %Example: mouse_select_main(true, 'Dataset/sample_frames/', 2, 5, 2, 'yanda.mat');
    if (target)
        outDir = 'Dataset/True_skin/';
    else
        outDir = 'Dataset/False_skin/';
    end
    totalFileList = cellstr(ls(strcat(filePath, '*.png')));
    selectedFiles = totalFileList(start+1:ending+1);
    selectedPoints = [];
    for k = 1:length(selectedFiles)
        imageName = selectedFiles{k};
        selectedPoints = cat(1, mouse_select(strcat(filePath, imageName), radius), selectedPoints);
    end
    save(strcat(outDir, outName), 'selectedPoints');
end