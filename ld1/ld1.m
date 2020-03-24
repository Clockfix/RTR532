%% Funkcionalo un logisko shemu modelesana
% Laboratorijas darbs Nr.1.
% Runas signala kompresijas sistama
% Autors: Imants Pulkstenis
%
figure (1)
Ain = linspace(0,1);
Ktr = kcmpnd(Ain,600);
plot(Ain,Ktr.*Ain,'LineWidth',2)
title('Compressor A_{out}(A_{in})')
xlabel('A_{in}')
ylabel('A_{out}')
grid on

figure (2)
Ain = linspace(0,1);
Ktr = kcmpnd(Ain,600);
plot(Ain,Ktr,'LineWidth',2)
title('Compressor Gain')
xlabel('A_{in}')
ylabel('K_{tr}')
grid on

% Meroga koeficentu iegusana
Str = [400; 450; 500; 550; 600];
Aoutmax = log10(Str+1)*20;
T = table(Str,Aoutmax),

% Dekompresora raksturliknes
syms Arin Str Arout
% equ = Arin*log10(Str+1)-log10(Str*Arout+1);
equ = Arin*log10(Str+1)-log10(Str*Arin*Arout+1);
solve(equ,Arout);
pretty(ans),

Arin = linspace(0,1);
Krc = kexpnd(Arin,600);

figure(3)
plot(Arin,Krc.*Arin,'LineWidth',2)
title('Expander A_{rout}(A_{rin})')
xlabel('A_{rin}')
ylabel('A_{rout}')
grid on

figure(4)
plot(Arin,Krc,'LineWidth',2)
title('Expander Gain')
xlabel('A_{rin}')
ylabel('K_{rc}')
grid on

% linearitates parbaude
figure(5)
Ain = linspace(0,1);
Arin = (Ain.*kcmpnd(Ain,600));
Arout = Arin.*kexpnd(Arin,600);
plot(Ain,Arout,'LineWidth',2)
title('A_{rout}(A_{in})')
xlabel('A_{in}')
ylabel('A_{rout}')
grid on

% Vienkarsa LPF realizacija
syms tau s z Fs
Hs = 1/(tau*s+1);
bilin = 2*Fs*(z-1)/(z+1);
Hz = simplify(subs(Hs,s,bilin));
Hz = collect(Hz);
pretty(Hz),

% RC kedes parvades raksturlikne
figure(6)
tau = 1e-3; Fs = 8000;
f = linspace(0,10000,1000);
hs = freqs(1,[tau,1],2*pi*f);
b = [1,1];
a = [1+2*tau*Fs,1-2*tau*Fs];
hz = freqz(b,a,f,Fs);
semilogx(f,abs(hs),'-b', f,abs(hz), '--b', 'LineWidth',2);
title('Magnitudes for H(s) and H(z)')
xlabel('Frequency [Hz]')
%ylabel('magnitude')
grid on
legend ('H(s)','H(z)','Location','southwest')