function
    % Path to the directory containing .bin.gz files
    % Change this path to the location of the .bin.gz files
    folderPath = '/Users/poyxinh/Desktop/Internship/UCI/bad_images';

    % Paths to the directories for categorized images
    % Change these paths to preferred directories for categorized images
    badImagesPath = '/Users/poyxinh/Desktop/Internship/UCI/Bad Images'; % Path for storing "Bad" images
    goodImagesPath = '/Users/poyxinh/Desktop/Internship/UCI/Good Images'; % Path for storing "Good" images
    undecidedImagesPath = '/Users/poyxinh/Desktop/Internship/UCI/Undecided Images'; % Path for storing "Undecided" images

    % Ensure all directories exist
    if ~exist(badImagesPath, 'dir')
        mkdir(badImagesPath);
    end
    if ~exist(goodImagesPath, 'dir')
        mkdir(goodImagesPath);
    end
    if ~exist(undecidedImagesPath, 'dir')
        mkdir(undecidedImagesPath);
    end

    % Get list of all .bin.gz files in the directory
    files = dir(fullfile(folderPath, '*.bin.gz'));

    % Check if any files are found
    if isempty(files)
        error('No .bin.gz files found in the specified directory.');
    end

    % Initialize index for file navigation
    currentIndex = 1;
    totalFiles = length(files);

    % Create a figure for displaying the image and controls
    hFig = figure('Name', 'Image Viewer', 'NumberTitle', 'off', 'MenuBar', 'none', 'ToolBar', 'none', ...
                  'Position', [100, 100, 1600, 900]); % Adjust size as needed

    % Panel for top layout with smaller width
    topPanel = uipanel('Parent', hFig, 'Position', [0.05, 0.7, 0.7, 0.2], 'BorderType', 'none');

    % File info and date-time labels with adjusted positions
    uicontrol('Style', 'text', 'Parent', topPanel, 'String', 'Processing File:', ...
              'Position', [10, 50, 150, 30], 'FontSize', 14, 'HorizontalAlignment', 'left');
    fileInfoText = uicontrol('Style', 'text', 'Parent', topPanel, 'String', '', ...
                             'Position', [170, 50, 400, 30], 'FontSize', 14, 'HorizontalAlignment', 'left');

    uicontrol('Style', 'text', 'Parent', topPanel, 'String', 'Date and Time:', ...
              'Position', [10, 10, 150, 30], 'FontSize', 14, 'HorizontalAlignment', 'left');
    dateTimeText = uicontrol('Style', 'text', 'Parent', topPanel, 'String', '', ...
                             'Position', [170, 10, 400, 30], 'FontSize', 14, 'HorizontalAlignment', 'left');

    % Total images and input controls with adjusted positions
    uicontrol('Style', 'text', 'Parent', topPanel, 'String', sprintf('Total Images: %d', totalFiles), ...
              'Position', [600, 50, 150, 30], 'FontSize', 14, 'HorizontalAlignment', 'left');
    uicontrol('Style', 'text', 'Parent', topPanel, 'String', 'Enter the Image Number:', ...
              'Position', [600, 10, 200, 30], 'FontSize', 14, 'HorizontalAlignment', 'left');
    indexInput = uicontrol('Style', 'edit', 'Parent', topPanel, 'String', num2str(currentIndex), ...
                           'Position', [810, 10, 80, 30], 'FontSize', 14);
    goButton = uicontrol('Style', 'pushbutton', 'Parent', topPanel, 'String', 'Enter', ...
                         'Position', [900, 10, 80, 30], 'Callback', @goToImage, 'FontSize', 14);

    % Create main buttons
    buttonWidth = 150;
    buttonHeight = 80;
    buttonSpacing = 40;

    % Centering calculations
    centerXMain = (1600 - 3 * buttonWidth - 2 * buttonSpacing) / 2;

    % Create main buttons
    uicontrol('Style', 'pushbutton', 'String', 'Bad', ...
              'Position', [centerXMain, 100, buttonWidth, buttonHeight], ...
              'Callback', @badImage, 'FontSize', 16, 'BackgroundColor', [0.8, 0.2, 0.2]);

    uicontrol('Style', 'pushbutton', 'String', 'Good', ...
              'Position', [centerXMain + buttonWidth + buttonSpacing, 100, buttonWidth, buttonHeight], ...
              'Callback', @goodImage, 'FontSize', 16, 'BackgroundColor', [0.2, 0.8, 0.2]);

    uicontrol('Style', 'pushbutton', 'String', 'Undecided', ...
              'Position', [centerXMain + 2 * (buttonWidth + buttonSpacing), 100, buttonWidth, buttonHeight], ...
              'Callback', @undecidedImage, 'FontSize', 16, 'BackgroundColor', [0.9, 0.9, 0.2]);

    % Create navigation buttons
    navButtonWidth = 80;
    navButtonHeight = 40;
    navButtonSpacing = 20;

    % Centering calculations for navigation buttons
    centerXNav = (1600 - 2 * navButtonWidth - navButtonSpacing) / 2;

    uicontrol('Style', 'pushbutton', 'String', '←', ...
              'Position', [centerXNav, 10, navButtonWidth, navButtonHeight], ...
              'Callback', @backImage, 'FontSize', 20, 'BackgroundColor', [0.8, 0.8, 0.8]);

    uicontrol('Style', 'pushbutton', 'String', '→', ...
              'Position', [centerXNav + navButtonWidth + navButtonSpacing, 10, navButtonWidth, navButtonHeight], ...
              'Callback', @nextImage, 'FontSize', 20, 'BackgroundColor', [0.8, 0.8, 0.8]);

    % Create axes for displaying images
    hAxes = axes('Parent', hFig, 'Position', [0.05, 0.15, 0.9, 0.5]); % Adjust the vertical size for a bigger image

    % Display the first image
    displayImageAtIndex(currentIndex);

    % Function to display image at the specified index
    function displayImageAtIndex(index)
        % Validate index
        if index < 1 || index > totalFiles
            errordlg('Index out of bounds.'); % Error dialog
            return;
        end

        % Clear the current image axes
        if ishandle(hAxes)
            cla(hAxes);
        end

        % Display current file
        currentFileName = files(index).name;
        currentFilePath = fullfile(folderPath, currentFileName);

        % Extract date and time from filename
        datetimeInfo = extractDatetimeFromFilename(currentFileName);
        if ~isempty(datetimeInfo)
            year = datetimeInfo(1);
            month = datetimeInfo(2);
            day = datetimeInfo(3);
            hour = datetimeInfo(4);
            minute = datetimeInfo(5);
            dateTimeStr = sprintf('%04d-%02d-%02d %02d:%02d', year, month, day, hour, minute);
        else
            dateTimeStr = 'Not extracted from filename';
        end

        % Update the text information
        set(fileInfoText, 'String', sprintf('%s (%d/%d)', currentFileName, index, totalFiles));
        set(dateTimeText, 'String', dateTimeStr);

        % Update order number input
        set(indexInput, 'String', num2str(index));

        % Load binary data from .bin.gz file
        data = loadbfn_gz_b(currentFilePath, [3000, 9000], 'int16');

        % Process and display the image
        displayImage(data);
    end

    % Function to display the image
    function displayImage(data)
        data(data < 0) = NaN;
        ir = double(data) / 100;
        ir = flipud([ir(:, 4501:end), ir(:, 1:4500)]); % Flip the image vertically

        imagesc(ir, 'Parent', hAxes);
        axis(hAxes, 'xy', 'image'); % Set aspect ratio to match data
        colormap(hAxes, flipud(jet)); % Use flipud(jet) colormap
        caxis(hAxes, [100 300]);
        colorbar('peer', hAxes); % Display colorbar relative to the axes
        title(hAxes, 'Satellite Image', 'FontSize', 20); % Set title font size
    end

    % Function to navigate to the previous image
    function backImage(~, ~)
        currentIndex = currentIndex - 1;
        if currentIndex < 1
            currentIndex = totalFiles; % Loop back to the last image
        end
        displayImageAtIndex(currentIndex);
    end

    % Function to navigate to the next image
    function nextImage(~, ~)
        currentIndex = currentIndex + 1;
        if currentIndex > totalFiles
            currentIndex = 1; % Loop back to the first image
        end
        displayImageAtIndex(currentIndex);
    end

    % Function to mark the current image as bad
    function badImage(~, ~)
        currentFileName = files(currentIndex).name;
        currentFilePath = fullfile(folderPath, currentFileName);

        % Copy the current file to the bad images folder
        copyfile(currentFilePath, fullfile(badImagesPath, currentFileName));
        fprintf('Copied %s to Bad Images folder.\n', currentFileName);

        % Move to the next image
        nextImage();
    end

    % Function to mark the current image as good
    function goodImage(~, ~)
        currentFileName = files(currentIndex).name;
        currentFilePath = fullfile(folderPath, currentFileName);

        % Copy the current file to the good images folder
        copyfile(currentFilePath, fullfile(goodImagesPath, currentFileName));
        fprintf('Copied %s to Good Images folder.\n', currentFileName);

        % Move to the next image
        nextImage();
    end

    % Function to mark the current image as undecided
    function undecidedImage(~, ~)
        currentFileName = files(currentIndex).name;
        currentFilePath = fullfile(folderPath, currentFileName);

        % Copy the current file to the undecided images folder
        copyfile(currentFilePath, fullfile(undecidedImagesPath, currentFileName));
        fprintf('Copied %s to Undecided Images folder.\n', currentFileName);

        % Move to the next image
        nextImage();
    end

    % Function to go to a specified image index from input
    function goToImage(~, ~)
        inputIndex = str2double(get(indexInput, 'String'));
        if ~isnan(inputIndex) && inputIndex >= 1 && inputIndex <= totalFiles
            currentIndex = inputIndex;
            displayImageAtIndex(currentIndex);
        else
            errordlg('Invalid index. Please enter a number between 1 and the total number of images.');
        end
    end

    % Function to extract date and time from filename
    function datetimeInfo = extractDatetimeFromFilename(filename)
        expression = 'bglob(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})';
        tokens = regexp(filename, expression, 'tokens');
        if ~isempty(tokens)
            datetimeInfo = [str2double(tokens{1}{1}) + 2000, str2double(tokens{1}{2}), ...
                            str2double(tokens{1}{3}), str2double(tokens{1}{4}), ...
                            str2double(tokens{1}{5})];
        else
            datetimeInfo = [];
        end
    end

    % Function to load binary data from a .bin.gz file
    function om = loadbfn_gz_b(fn, dim, sz)
        om = zeros(dim);

        if nargin < 3
            sz = 'float32';
        end

        clk = fix(clock);
        MS = sprintf('%-2.2d%-2.2d', clk(5), clk(6));

        lc = fliplr(find(fn == '.'));
        if isempty(lc)
            lc = length(fn) + 1;
        end
        fc = fliplr(find(fn == '/'));
        if isempty(fc)
            fc = 0;
        end
        tmpn = ['/tmp/' fn(fc(1) + 1:lc(1) - 1) MS];

        system(sprintf('gunzip -c %s > %s', fn, tmpn));

        f = fopen(tmpn, 'r', 'b');

        if nargout > 0
            om = fread(f, flipud(dim(:))', sz)';
        end
        fclose(f);

        delete(tmpn);
    end
end

