function [fsurf]=solarflux(rsun,rsunabs,rsat,vsat,lit)
%despite the name, this script adds all sources of flux
fsurf=zeros(length(rsat),6);
for rr=1:length(rsat)
rsatabs=sqrt((rsat(rr,1)^2)+(rsat(rr,2)^2)+(rsat(rr,3)^2));
rsatu=rsat(rr,:)/rsatabs;%unit vector of sat position
vsatabs=sqrt((vsat(rr,1)^2)+(vsat(rr,2)^2)+(vsat(rr,3)^2));
vsatu=vsat(rr,:)/vsatabs;%unit vector of sat velocity (corresponds to forward facing)
rsunAU=rsun/1.496e+8;%converts back to AU
rsunu=rsunAU/rsunabs;
flux=1367.5/(rsunabs^2);%w/m^2

%Objects in order: Bottom, top,
%side walls starting from nadir and going clockwise as viewed from negative Z,
s3=-1*rsatu;
s5=rsatu;
s2=vsatu;%Needs to be rewritten as an internal loop
s1=-1*vsatu;
s4=cross(s2,s3);
s6=-1*s5;
fsurf=zeros(6,1);
if lit(rr)==1%check sunlit state
a1=dot(s1,rsunu);
if a1>0
    fsurf(rr,1)=a1*flux;
end
a2=dot(s2,rsunu);
if a2>0
    fsurf(rr,2)=a2*flux;
end
a3=dot(s3,rsunu);
if a3>0
    fsurf(rr,3)=a3*flux;
end
a4=dot(s4,rsunu);
if a4>0
    fsurf(rr,4)=a4*flux;
end
a5=dot(s5,rsunu);
if a5>0
    fsurf(rr,5)=a5*flux;
end
a6=dot(s6,rsunu);
if a6>0
    fsurf(rr,6)=a6*flux;
end
end
%This section adds albedo and IR flux
a=.25;%setting this arbitrarily for the moment at a reasonable value
emiss=1;%consider the earth as a blackbody
flag=0;
if dot(rsatu,rsunu)>0
    flag=1;%this flag will turn on albedo if the sat isn't past terminator
    
end
tearth=nthroot((flux*(1-a))/(4*emiss*(5.67e-8)),4);
qir=(5.67e-8)*(tearth^4);
thetas=acos(dot(rsatu,rsunu));
qalbedo=flux*a*cos(thetas);
fsurf(rr,3)=fsurf(rr,3)+(qir+qalbedo*flag)*.5;
fsurf(rr,1)=fsurf(rr,1)+(qir+qalbedo*flag)*.22;
fsurf(rr,4)=fsurf(rr,4)+(qir+qalbedo*flag)*.22;
fsurf(rr,2)=fsurf(rr,2)+(qir+qalbedo*flag)*.22;
fsurf(rr,6)=fsurf(rr,6)+(qir+qalbedo*flag)*.22;
end
end