clc;clear all;close all;
% DDS (Direct digital synthesizer) 
% https://en.wikipedia.org/wiki/Direct_digital_synthesizer

% Direct digital synthesizer (DDS) is a type of frequency synthesizer
% used for creating arbitrary waveforms from a single,
% fixed-frequency reference clock.
% Applications of DDS include: signal generation, local oscillators
% in communication systems, function generators, mixers, modulators,
% sound synthesizers and as part of a digital phase-locked loop


sintablen = 22050;
SINTAB = sin(2*pi*(0:sintablen-1)./sintablen);
fs = 22050;

% the sintable consists of one cycle of sine wave with 2048 samples
% if you access 2048 samples/sec (fs) from the above sintable,
% it will generate one complete cycle of sine wave in one sec.
% so, effectively the frequency is 1Hz.
% step = 1; Feff(Effective frequency) = fs/sintablen;
F_required = 1;
index = 1; step = (F_required/fs)*sintablen;
for i = 1:2048
    sin1Hz(i) = SINTAB(round(index));
    index = index+step;
    if index>sintablen
        index = index-sintablen;
    end
end
plot(sin1Hz); hold on;

% suppose we need to generate 2Hz sine wave.
% step = 2;
F_required = 1664;
index = 1; step = (F_required/fs)*sintablen;
for i = 1:2048
    sin2Hz(i) = SINTAB(round(index));
    index = index+step;
    if index>sintablen
        index = index-sintablen;
    end
end
plot(sin2Hz,'r'); hold on;

% suppose we need to generate 0.75Hz sine wave

index = 1;
F_required = 2496;
step = (F_required/fs)*sintablen;
for i = 1:2048
    sinp75Hz(i) = SINTAB(round(index));
    index = index+step;
    if index>sintablen
        index = index-sintablen;
    end
end
plot(sinp75Hz,'k'); hold on;
legend('1Hz','2Hz','0.75Hz')

% M Manoj Kumar
% could be reached at m.mnjkmr@gmail.com
