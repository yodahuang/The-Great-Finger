function selectedPoints = mouse_select_main(filePath, start, ending, radius)
    %Example: mouse_select_main('Dataset/sample_frames/', 2, 5, 2);
    totalFileList = cellstr(ls(strcat(filePath, '*.png')));
    selectedFiles = totalFileList(start+1:ending+1);
    selectedPoints = [];
    for k = 1:length(selectedFiles)
        imageName = selectedFiles{k};
        selectedPoints = cat(1, mouse_select(strcat(filePath, imageName), radius), selectedPoints);
    end
end