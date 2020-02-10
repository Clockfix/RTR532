function Kcmp = kcmpnd(Ain,Str)
% Kompresora pastiprinajuma koeficients
Kcmp = zeros (size(Ain));
Kcmp(Ain>0)=log10(Str*Ain(Ain>0)+1)./...
    Ain(Ain>0)/log10(Str+1);
Kcmp(Ain<=0)=Str/log(Str+1);