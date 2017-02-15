%%heatcap
function[tcap]=heatcapf(hbus,twall,masscom,ctype,por,wallmat,ccustom,mucustom)
%hbus=.1;%z height, m (input)
%twall=.005;%wall thickness (from input)
capindex=[1,1,1];% index of capacities of each material
muindex=[1,1,1];% index of densities of each material
if wallmat==0
    cal=ccustom;
    mual=mucustom;
else

cal=capindex(wallmat);%heat capacity of aluminum (j/kg*k)
mual=muindex(wallmat);%density of aluminum
end
cpcb=1;%heat capacity of pcb
%mupcb=1;%density of pcb
cec=1;%heat capacity of electronic components
%muec=1;%density of electronic components
cbat=1;%heat capacity of battery
%mubat=1;

masspcb=1;%mass of a standard pcb
%masscom=[1.5,1.5,1.5,1.5,1.5];%mass of each component, should feed from function input

tcap=zeros(6+length(masscom),1);

tcap(1)=.1*.1*twall*mual*cal*(1-por);
tcap(2)=.1*.1*twall*mual*cal*(1-por);
tcap(3)=.1*hbus*twall*mual*cal*(1-por);
tcap(4)=.1*hbus*twall*mual*cal*(1-por);
tcap(5)=.1*hbus*twall*mual*cal*(1-por);
tcap(6)=.1*hbus*twall*mual*cal*(1-por);

for ii=1:length(masscom)
    if ctype(ii)==1
    tcap(ii+6)=masspcb*cpcb+((masscom(ii)-masspcb)*cec);
    elseif ctype(ii)==2
       tcap(ii+6)=masscom(ii)*cbat;
    end
end
end