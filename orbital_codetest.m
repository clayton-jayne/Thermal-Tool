a=6782;%The input fields should be obvious, I'd
ec=.0004195;%like to upgrade to a GUI when possible
taInit=286.1333;

p=a*(1-ec^2);%semi-parameter
jj=101;%This number indicates the amount of seperate time positions
%Note to self: fully integrate step size into the program

                mu=3.986004e5;
                
argP=156.7166;
inc=51.6423;
raan=272.4012;
acc=.000001;
ta=zeros(1,jj);eA=zeros(1,jj);mArec=zeros(1,jj);%vectors that will store true anomaly and ecc. anomaly
period=(2*pi)*sqrt((a^3)/mu);Tm=linspace(0,period,jj);%time vector
ta(1)=taInit;%initial true anomaly fed into vector (artifact?)
eA(1)=acos((ec+cos(ta(1)))/(1+ec*cos(ta(1))));mA=eA(1)-ec*sin(eA(1));%inital ecc. anomaly gives mean anomaly
h=sqrt(p*mu);%angular momentum
for ii=1:jj
    mAt=mA+(2*pi)*(Tm(ii)/period);%increments Mean anomaly (Tm(1)=0)
    if mAt>2*pi
        mAt=mAt-2*pi;
    end
    [eAOut,taOut]=taFind(mAt,ec,acc);%sends incremented value to True anomaly finder
    eA(ii)=eAOut;
    ta(ii)=taOut;%writes the ecc and true anomaly vectors
    mArec(ii)=mAt;
end
[f,g,fdot,gdot]=coe2fg(h,mu,ta,ec);%This program outputs vectors, no external iteration is required
[ri,rj,rk,vi,vj,vk]=coe2rv(p,ta,ec,mu,raan,argP,inc);%This function gives r/v 
%vectors but is not built into any iterative process
figure(1)
plot(Tm,ta)
xlabel('Time (s)')
ylabel('True Anomaly (rad)')
title('True Anomaly vs Time')
figure(2)
plot(Tm,f)
xlabel('Time (s)')
ylabel('F')
title('F vs Time')

figure(3)
plot(Tm,fdot)
xlabel('Time (s)')
ylabel('F dot')
title('F dot vs Time')

figure(4)
plot(Tm,g)
xlabel('Time (s)')
ylabel('G')
title('G vs Time')

figure(5)
plot(Tm,gdot)
xlabel('Time (s)')
ylabel('G dot')
title('G dot vs Time')
