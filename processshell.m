%function[tnom,thot,tcold]=processshell(otype,hm,env,twall,por,hbus,ctype,por,masscom,a,ec,taInit,n,argP,inc,raan,acc,elev,n,yr,mo,d,dcyc,tgen,sirem,ssolabs,fracpanel,wallmat,ccustom,mucustom,kcustom)

[radcond]= vfcalcf(hm,env);%pass in radiative conductors
[kmat]= condnetworkf(env,twall,por,hbus,ctype,wallmat,kcustom);%Pass in conduction network
[hcap]=heatcapf(hbus,twall,masscom,ctype,por,wallmat,ccustom,mucustom);%wallmat will be zero for custom
[delt]=tstep(radcond,kmat,hcap);
[irabs,solabs]=sprop(sirem,ssolabs,fracpanel);
acc=.000001;%hardcoded error acceptance for true anomaly
if otype==1 %traditional orbital elements
[tnom]=ttool(a,ec,taInit,jj,n,argP,inc,raan,acc,yr,mo,d,dcyc,tgen,hbus,irabs,hcap,delt,kmat,radcond,1);%nominal case
[thot]=ttool(a,ec,taInit,jj,n,pi/2,inc,pi/2,acc,yr,1,3,dcyc,tgen,hbus,irabs,hcap,delt,kmat,radcond,2);%hot case
[tcold]=ttool(a,ec,taInit,jj,n,0,inc,0,acc,yr,7,3,dcyc,tgen,hbus,irabs,hcap,delt,kmat,radcond,3);%cold case
elseif otype==2 %simplified orbital elements
    %fill in orbital elements to make
    ec=0;
    a=(elev+6353e3)*2;
%[tnom]=ttool(a,ec,0,jj,n,0,inc,pi/4,acc,yr,mo,d,dcyc,tgen,hbus,irabs,hcap,delt,kmat,radcond,1)%nominal case
%[thot]=ttool(a,ec,0,jj,n,0,inc,pi/2,acc,yr,1,3,dcyc,tgen,hbus,irabs,hcap,delt,kmat,radcond,2)%hot case
%[tcold]=ttool(a,ec,0,jj,n,0,inc,0,acc,yr,7,3,dcyc,tgen,hbus,irabs,hcap,delt,kmat,radcond,2)%cold case
end
%graphs and print
%end