%% % Runas signala komplresors analogajam signalam

Ain = linspace(0,1);
Ktr = kcmpnd(Ain,600);
figure(1)
plot(Ain,Ktr)

Ain = linspace(0,1);
Ktr = kcmpnd(Ain,600);
figure(2)
plot(Ain,Ktr.*Ain)