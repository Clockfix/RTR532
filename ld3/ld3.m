%% Funkcionalo un logisko shemu modelesana
% Laboratorijas darbs Nr.3.
% sinusoidu generesana un filtresana
% Autors: Imants Pulkstenis
%
% Apliecibas Nr.021REB152
%% 1.Sakuma dati
% 
%   Piemers:https://la.mathworks.com/help/simulink/slref/digital-waveform-generation-approximating-a-sine-wave.html
%
clear; format shortEng;
fs = 22050;     % (ciparu dalas sample clock) = 22050 (audio standarts).
k = 52;         % k - studenta apliecibas pedejie 2 cipari
f1 = 32 * k;
f2 = 48 * k;
%% 2.FIR bandpass filtrs
n1 = 40;         % First filter order
n2 = 40;         % Second filter order

band = 100;     % filter bandwidth
fsh = fs/2;     % corresponding to half the sample rate

Wn1= f1/fsh;     % The cut-off frequency Wn must be between 0 < Wn < 1.0, with 1.0 corresponding to half the sample rate.
Wn2= f2/fsh;

b1 = fir1(n1,[Wn1-band/(fsh*2)  Wn1+band/(fsh*2) ], 'bandpass'); % Window-based FIR filter design
b2 = fir1(n2,[Wn2-band/(fsh*2)  Wn2+band/(fsh*2) ], 'bandpass'); % Window-based FIR filter design

[h1,w1] = freqz(b1);
[h2,w2] = freqz(b2);
figure (1)
plot (w1/pi,db(h1), ...
    w2/pi,db(h2),...
    [Wn1 Wn1],[3 -80], '--', ...
    [Wn2 Wn2], [3 -80], '--',...
    [0 1],[-20 -20], '--')
axis([0 1 -80 3])
grid on,
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
legend('Response FIR_1','Response FIR_2','f_1','f_2', '-20dB target', 'Location','East')
title('Magnitude response')
%% 3.IIR bandpass filtrs
[b,a] = iirpeak(Wn1,2*(Wn2-Wn1),-22);     %Wo must satisfy 0.0 < Wo < 1.0, with 1.0 corresponding to pi radians/sample
[h3,w3] = freqz(b,a);
[b,a] = iirpeak(Wn2,2*(Wn2-Wn1),-19); 
[h4,w4] = freqz(b,a);
figure (2)
plot (w3/pi,db(h3), ...
    w4/pi,db(h4),...
    [Wn1 Wn1],[3 -80], '--', ...
    [Wn2 Wn2], [3 -80], '--',...
    [0 1],[-20 -20], '--')
axis([0 1 -80 3])
grid on,
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
legend('Response IIR_1','Response IIR_2','f_1','f_2', '-20dB target', 'Location','East')
title('Magnitude response')


