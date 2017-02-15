%feed in heat capacity, current temp, time step, conductors and fixed fluxes

%calculate new temperatures. First 6 will be fixed, components will work
%with a for loop. Should be able to use a summation loop for every
%component

function [tcurrent]=tsolve(hcap,tinit,delt,kmat,radcond,fsurf,hbus,gen,irabs)
tcurrent=zeros(length(fsurf)+1,length(hcap));
asurf=zeros(1,6);
asurf(1:2)=.1*.1;
asurf(3:6)=.1*hbus;
tcurrent(1,:)=tinit;
for qq=2:length(fsurf)
for ii=1:length(tinit)
    for jj=1:length(tinit)
    tcurrent(qq,ii)=tcurrent(qq-1,ii)+(delt/hcap(ii))*((tinit(qq-1,jj)-tinit(qq-1,ii))/kmat(jj,ii)+(((tinit(qq-1,jj)^4)-(tinit(qq-1,ii)^4))/radcond(jj,ii)));%this entire statement needs to be reworked with a descending iterative structure.
    end
end
for kk=1:6
    tcurrent(qq,kk)=tcurrent(qq,kk)+(delt/hcap(kk))*(fsurf-((5.67e-8)*irabs*tcurrent(qq,kk)^4))*asurf(qq,kk);%need to add rejection to space
end
for mm=7:length(hcap)
    tcurrent(qq,mm)=tcurrent(qq,mm)+(delt/hcap(mm))*gen(qq,mm);%Adds generation
end
end
end