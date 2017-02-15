function [rsun,rsunabs]=sunv(jd)
tut1=(jd-2451545)/36525;
lamdam=280.46+36000.771*tut1;
msun=357.5291092+35999.05034*tut1;
lamdaecl=lamdam+1.914666*sind(msun)+.019994643*sind(2*msun);
rsunabs=1.000140612-.016708617*cosd(msun)-.000139589*cosd(2*msun);%absolute distance from the sun (AU)
ep=23.439291-.0130042*tut1;
rsun=[rsunabs*cosd(lamdaecl);rsunabs*cosd(ep)*sind(lamdaecl);rsunabs*sind(ep)*sind(lamdaecl)];
rsun=rsun*1.496e+8;%Convert solar vector to kilometers
end
%Vallado