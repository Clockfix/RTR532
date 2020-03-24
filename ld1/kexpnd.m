function Kexp = kexpnd(Arin,Str)
% Kompresora pastiprinajuma koeficients
Kexp=zeros(size(Arin));
% Kexp=((Str + 1).^Arin - 1)./Str;
% Kexp = (exp(Arin.*log(Str+1)) - 1 ) ./ Str;
Kexp =  ((Str + 1).^Arin - 1)./(Arin.*Str);