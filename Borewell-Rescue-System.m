function borewell_rescue_system2
    % Initialize webcam
    cam = webcam;

    % Create the main figure window
    f = figure('Name', 'Borewell Rescue System', ...
        'NumberTitle', 'off', ...
        'Position', [100, 100, 800, 600], ...
        'CloseRequestFcn', @closeGUI);

    % Create axes for displaying camera feed
    ax = axes('Parent', f, 'Position', [0.4, 0.1, 0.55, 0.8]);
    hImage = imshow(zeros(240, 320, 3, 'uint8'), 'Parent', ax);

    % UI Buttons for controlling gripper and camera
    uicontrol('Style', 'pushbutton', 'String', 'Start Camera', ...
        'Position', [50, 400, 150, 40], 'Callback', @startCamera);

    uicontrol('Style', 'pushbutton', 'String', 'Stop Camera', ...
        'Position', [220, 400, 150, 40], 'Callback', @stopCamera);

    uicontrol('Style', 'pushbutton', 'String', 'Open Gripper', ...
        'Position', [50, 340, 150, 40], 'Callback', @openGripper);

    uicontrol('Style', 'pushbutton', 'String', 'Close Gripper', ...
        'Position', [220, 340, 150, 40], 'Callback', @closeGripper);

    uicontrol('Style', 'pushbutton', 'String', 'Simulate Rescue', ...
        'Position', [135, 280, 150, 40], 'Callback', @simulateRescue);

    % Initialize flag for camera streaming
    isStreaming = false;

    % ----------- Callback Functions ------------

    function startCamera(~, ~)
        disp('Camera Started');
        isStreaming = true;
        while ishandle(f) && isStreaming
            img = snapshot(cam);
            set(hImage, 'CData', img);
            pause(0.1);
        end
    end

    function stopCamera(~, ~)
        disp('Camera Stopped');
        isStreaming = false;
    end

    function openGripper(~, ~)
        disp('Gripper OPENED');
    end

    function closeGripper(~, ~)
        disp('Gripper CLOSED');
    end

    function closeGUI(~, ~)
        isStreaming = false;
        clear cam;
        delete(f);
    end

    % -------------- Simulation Logic --------------
    function simulateRescue(~, ~)
        cla(ax); % Clear axes
        axis(ax, [0 10 0 20]);
        hold(ax, 'on');
        set(ax, 'YDir', 'reverse');
        title(ax, 'Rescue Simulation');

        % Draw borewell
        rectangle(ax, 'Position', [4.5, 0, 1, 20], 'EdgeColor', 'k', 'LineWidth', 2);

        % Draw child as a circle
        child = rectangle(ax, 'Position', [4.75, 16, 0.5, 0.5], ...
            'Curvature', [1, 1], 'FaceColor', 'red');

        % Robotic arm (line)
        arm = line(ax, [5, 5], [0, 0], 'Color', 'blue', 'LineWidth', 3);

        % Simulate arm moving down
        for y = 0:0.5:16
            set(arm, 'YData', [0 y]);
            pause(0.05);
        end

        disp('Gripper reaches child...');
        pause(1);
        disp('Closing Gripper...');
        closeGripper();

        % Simulate lifting child
        for y = 16:-0.5:0
            set(child, 'Position', [4.75, y, 0.5, 0.5]);
            set(arm, 'YData', [0 y]);
            pause(0.05);
        end

        disp('Child rescued successfully!');
        title(ax, 'Child Rescued ✅');
    end
end
