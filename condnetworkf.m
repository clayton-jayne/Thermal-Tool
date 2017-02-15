function[kmat]= condnetworkf(env,twall,por,hbus,ctype,wallmat,kcustom)
%%conductors for heat network

wbus=.1;%bus width, m
wboard=.09;

kalindex=[1,1,1]; %conductivity index
if wallmat==0
    kal=kcustom;
else

kal=kalindex(wallmat);%conductivity of aluminum
end

kbolt=1; %conductance of a bolt
kpcb=1; %conductivity of pcb
tpcb=.002; %thickness of pcb, m
rjoint=1; %resistance of wall joints
kbat=1;
%how to read resistance matrix: View factor go to a column from a row. Objects in order: Bottom, top,
%side walls starting from nadir and going clockwise as viewed from negative Z,
%components in order.
kmat=zeros(length(env)+6);

kside2side=1/(2*((.5*wbus*(1+por))/(kal*(twall*hbus*(1-por))))+(rjoint/(hbus*twall))); %series conductivity between side walls
kside2top=1/(((.5*hbus*(1+por))/(kal*(twall*wbus*(1-por))))+(rjoint/(hbus*twall))+((.5*wbus*(1+por))/(kal*(twall*wbus*(1-por)))));
kpcb2side=1/(((.5*hbus*(1+por))/(kal*(twall*wbus*(1-por))))+(1/kbolt)+(.5*wboard/(kpcb*tpcb*wboard)));


kmat(1,3)=kside2top;
kmat(1,4)=kside2top;
kmat(1,5)=kside2top;
kmat(1,6)=kside2top;

kmat(2,3)=kside2top;
kmat(2,4)=kside2top;
kmat(2,5)=kside2top;
kmat(2,6)=kside2top;

kmat(3,1)=kside2top;
kmat(4,1)=kside2top;
kmat(5,1)=kside2top;
kmat(6,1)=kside2top;

kmat(3,2)=kside2top;
kmat(4,2)=kside2top;
kmat(5,2)=kside2top;
kmat(6,2)=kside2top;

kmat(3,4)=kside2side;
kmat(3,6)=kside2side;

kmat(4,5)=kside2side;
kmat(4,3)=kside2side;

kmat(5,6)=kside2side;
kmat(5,4)=kside2side;

kmat(6,3)=kside2side;
kmat(6,5)=kside2side;

for ii=1:length(env)
    if ctype(ii)==1 %corresponds to pcb
    kmat(ii+6,3)=kpcb2side;
    kmat(ii+6,4)=kpcb2side;
    kmat(ii+6,5)=kpcb2side;
    kmat(ii+6,6)=kpcb2side;
    
    kmat(3,ii+6)=kpcb2side;
    kmat(4,ii+6)=kpcb2side;
    kmat(5,ii+6)=kpcb2side;
    kmat(6,ii+6)=kpcb2side;
    elseif ctype(ii)==2 %corresponds to battery
        kbat2side=1/(((.5*hbus*(1+por))/(kal*(twall*wbus*(1-por))))+(1/kbolt)+(.5*wboard/(kbat*env(ii)*wboard)));% This is incomplete, fix it.
        
    kmat(ii+6,3)=kbat2side;
    kmat(ii+6,4)=kbat2side;
    kmat(ii+6,5)=kbat2side;
    kmat(ii+6,6)=kbat2side;
    
    kmat(3,ii+6)=kbat2side;
    kmat(4,ii+6)=kbat2side;
    kmat(5,ii+6)=kbat2side;
    kmat(6,ii+6)=kbat2side;
    end
    
end