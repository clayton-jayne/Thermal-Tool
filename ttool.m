%%Main function
%Preprocessing will be necessary, unsure whether to handle that here or
%outside. Simply put, the program will need to call orbital differently
%under different conditions. A flag will suffice here: 1 for traditional
%Keplerian, 2 for simplified. The parameters will need to be adjusted in
%the case of the simplified variables. May put it in an outside calling
%program as it would simplify calls for hot and cold cases.
function[temp]=ttool(a,ec,taInit,jj,n,argP,inc,raan,acc,yr,mo,d,dcyc,tgen,hbus,irabs,hcap,delt,kmat,radcond,hctype)
%need subroutine to set step size (n*period/jj) based on heat network
%n will correspond to number of orbits calculated for
[ri,rj,rk,vi,vj,vk]=orbital_code(a,ec,taInit,jj,n,argP,inc,raan,acc);%get the r and v vectors from the orbital program, convert them into compound matrices
rsat=zeros(length(ri),3);
rsat(:,1)=ri;
rsat(:,2)=rj;
rsat(:,3)=rk;
vsat=zeros(length(vi),3);
vsat(:,1)=vi;
vsat(:,2)=vj;
vsat(:,3)=vk;


[jd]=julian(yr,mo,d,0,0,0);%get julian date, use input date at midnight
[rsun,rsunabs]=sunv(jd);%get a static sun vector, operating on the assumption that it won't change much over the course of the simulation
switch hctype
    case hctype==1
    case hctype==2
        rsun=rsunabs*[1,0,0];
    case hctype==3
        rsun=rsunabs*[1,0,0];
end
[lit]=slcheck(rsat,rsun,rsunabs);%Is it lit?

[fsurf]=solarflux(rsun,rsunabs,rsat,vsat,lit);%surface fluxes
[gen]=cgen(dcyc,lit,tgen); %needs component type and generation
%[radcond]= vfcalcf(hm,env);%pass in radiative conductors
%[kmat]= condnetworkf(env,twall,por,hbus,ctype);%Pass in conduction network
%[tcap]=heatcapf(hbus,twall,masscom,ctype);
[temp]=tsolve(hcap,tinit,delt,kmat,radcond,fsurf,hbus,gen,irabs);%This needs an internal loop! Also add heat gen and rejection. Surface properties will go here.
end