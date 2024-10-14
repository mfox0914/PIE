clear s
freeports = serialportlist("available") ;% Shows available serial ports
%
%Choose which port to use for Arduino (proabably best to hardcode)
%
port = "COM6";%freeports(2)

baudrate = 9600;
angle2=0;
s = serialport(port,baudrate);

%initialize a timeout in case MATLAB cannot connect to the arduino
timeout = 0;
maxReadings = 362; % Estimate based on maximum readings from both motors
dataVector = []; % Preallocate 3 columns for angle1, angle2, sensorValue
currentReading = 0; % Track the number of readings collected

% main loop to read data from the Arduino, then display it%
while angle2 < 180    %    % check if data was received    %    
    while s.NumBytesAvailable > 0
        timeout = 0;

        % Read line and split it into components
        rawData = readline(s); % Read the data from Arduino
        dataComponents = str2double(strsplit(rawData, ',')); % Split and convert to double
        
        % Check if we received exactly 3 values
        if length(dataComponents) == 2
            % Store the angles and status into the vector
            angle1 = dataComponents(1);
            status = dataComponents(2);
            % Append to the data vector
            dataVector = [dataVector;angle1, angle2, status]; % Append new data as a new row
            if angle1 == 60
                angle2 = angle2+5;
            end
        else
            disp('There is something wrong.');
        end
        
        % Print the results
        %printing sensor value and one angle
        disp(dataComponents);
    end
    disp(size(dataVector));
    pause(2);
    timeout = timeout + 1;
    
end

% Trim the dataVector to the actual number of readings collected


% Display the size of the dataVector
disp(size(dataVector));