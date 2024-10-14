clear s

% Set up serial communication
ports = "COM6";    % Adjust this if necessary
baudrate = 9600;
s = serialport(ports, baudrate);
timeout = 0;
i = 0;

% Define arrays to store the incoming data
position1 = [];    % Servo 1 (pan) positions
position2 = [];    % Servo 2 (tilt) positions
volts = [];        % Voltage data from the sensor

% Read data from the Arduino
while timeout < 5
    while s.NumBytesAvailable > 0
        timeout = 0;
        values = eval(strcat('[', readline(s), ']'));

        % Read both servo positions and sensor voltage
        pos1 = values(1);  % Servo 1 position
        pos2 = values(2);  % Servo 2 position
        voltage = values(3);  % Voltage from distance sensor

        % Store the data
        position1(i+1) = pos1;  % Servo 1 position
        position2(i+1) = pos2;  % Servo 2 position
        volts(i+1) = voltage;   % Voltage data
        i = i + 1;
    end
    pause(0.5);
    timeout = timeout + 1;
end