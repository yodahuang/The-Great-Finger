function selectedPoints = mouse_select_main(start, ending, radius)
    filePath = 'Dataset/sample_frames/';
    totalFileList = cellstr(ls(strcat(filePath, '*.png')));
    selectedFiles = totalFileList(start+1:ending+1);
    selectedPoints = [];
    for k = 1:length(selectedFiles)
        imageName = selectedFiles{k};
        selectedPoints = cat(1, mouse_select(strcat(filePath, imageName), radius), selectedPoints);
    end
end