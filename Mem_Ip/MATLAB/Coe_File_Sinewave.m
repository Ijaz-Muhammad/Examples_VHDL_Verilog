clear;
clc;
close all;

%% Parameters
N = 1024;          % Number of ROM locations
Amplitude = 511;   % For 10-bit ROM (0-1023)
Offset = 512;

%% Generate Sine Wave
x = Offset + Amplitude * sin(2*pi*(0:N-1)/N);

% Convert to integer
x = round(x);

%% Plot
figure;
plot(x);
grid on;
title('1024-Point Sine Wave');
xlabel('Sample');
ylabel('Amplitude');

%% Write COE File
filename = 'mysine.coe';

fid = fopen(filename,'w');

fprintf(fid,'memory_initialization_radix=10;\n');
fprintf(fid,'memory_initialization_vector=\n');

for k = 1:N-1
    fprintf(fid,'%d,\n',x(k));
end

fprintf(fid,'%d;\n',x(N));

fclose(fid);

disp('mysine.coe generated successfully.');