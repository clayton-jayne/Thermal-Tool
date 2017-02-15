function[ri,rj,rk,vi,vj,vk]=orbital_code(a,ec,taInit,jj,n,argP,inc,raan,acc)
%a=input('Semiparameter?');%The input fields should be obvious, I'd
%ec=input('Eccentricity?');%like to upgrade to a GUI when possible
%taInit=input('Initial True anomaly?');
musw=2;
p=a*(1-ec^2);%semi-parameter
%jj=101;%This number indicates the amount of seperate time positions
%Note to self: fully integrate step size into the program

                mu=3.986004e5;
                
ta=zeros(1,jj);eA=zeros(1,jj);%vectors that will store true anomaly and ecc. anomaly
period=(2*pi)*sqrt((a^3)/mu);Tm=linspace(0,n*period,jj);%time vector
ta(1)=taInit;%initial true anomaly fed into vector (artifact?)
eA(1)=acos((ec+cos(ta(1)))/(1+ec*cos(ta(1))));mA=eA(1)-ec*sin(eA(1));%inital ecc. anomaly gives mean anomaly
%h=sqrt(p*mu);%angular momentum
for ii=1:jj
    mAt=mA+(2*pi)*(Tm(ii)/period);%increments Mean anomaly (Tm(1)=0)
    [eAOut,taOut]=taFind(mAt,ec,acc);%sends incremented value to True anomaly finder
    eA(ii)=eAOut;
    ta(ii)=taOut;%writes the ecc and true anomaly vectors
    
end

[ri,rj,rk,vi,vj,vk]=coe2rv(p,ta,ec,mu,raan,argP,inc);%This function gives r/v 
%vectors but is not built into any iterative process
end

