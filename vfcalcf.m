%%Input matrices: rows represent components in order going towards ram
%%direction. hm-mount height (from bottom of stack). env-height envelope
function[radcond]= vfcalcf(hm,env)


emiss=.9; %greybody emissivity
sb=5.67e-8;

aboard=.09^2;
abside=.09*env;
atboard=2*aboard+4*abside;
atop=.1^2;
wtop=.1;
wboard=.09;
%htop should be assigned based on the size of the satellite
htop=.1;
awall=.1*htop;
%ratio of view to adjacent walls and the parallel wall, changes with size
radj=0.235401618249073;
rpar=0.529196763501854;
%how to read vf matrix: View factor go to a column from a row. Objects in order: Bottom, top,
%side walls starting from nadir and going clockwise as viewed from negative Z,
%components in order.
vf=zeros(6+length(hm));

%start with the bottom
%to/from board
hus=hm(1);
w1=wboard/hus;
w2=wtop/hus;
p1=((w1^2)+(w2^2)+2)^2;
x1=(w2-w1);
y1=(w2+w1);
q1=((x1^2)+2)*((y1^2)+2);
u1=sqrt(4+x1^2);
v1=sqrt(4+y1^2);
s1=u1*((x1*atan(x1/u1))-(y1*atan(y1/u1)));
t1=v1*((2*atan(x1/v1))-(y1*atan(y1/v1)));
fucsp=(1/(pi*(w1^2)))*(log(p1/q1)+s1-t1);
vf(7,1)=fucsp*(aboard/atboard(1));
vf(1,7)=fucsp*(aboard/atop);
vf(1,3:6)=(1-fucsp*(aboard/atop))/4;
vf(3:6,1)=((1-fucsp*(aboard/atop))/4)*(atop/awall);

%top next, reuse the code above
hus=htop-hm(length(hm))-env(length(hm));

w1=wboard/hus;
w2=wtop/hus;
p1=((w1^2)+(w2^2)+2)^2;
x1=(w2-w1);
y1=(w2+w1);
q1=((x1^2)+2)*((y1^2)+2);
u1=sqrt(4+x1^2);
v1=sqrt(4+y1^2);
s1=u1*((x1*atan(x1/u1))-(y1*atan(y1/u1)));
t1=v1*((2*atan(x1/v1))-(y1*atan(y1/v1)));
fucsp=(1/(pi*(w1^2)))*(log(p1/q1)+s1-t1);
vf(6+length(hm),2)=fucsp*(aboard/atboard(length(hm)));
vf(2,6+length(hm))=fucsp*(aboard/atop);
vf(2,3:6)=(1-fucsp*(aboard/atop))/4;
vf(3:6,2)=((1-fucsp*(aboard/atop))/4)*(atop/awall);

%next step is to solve between boards
for ii=1:length(hm)-1
    d=hm(ii+1)-(hm(ii)+env(ii));

xbar=wboard/d;
ybar=xbar;
%view factor between parallel boards
fij=(2/(pi*xbar*ybar))*((log(((1+xbar^2)*(1+ybar^2))/(1+xbar^2+ybar^2))^.5)+(xbar*((1+ybar^2)^.5)*atan(xbar/((1+ybar^2)^.5)))+(ybar*((1+xbar^2)^.5)*atan(ybar/((1+xbar^2)^.5)))-(xbar*atan(xbar))-(ybar*atan(ybar)));
vf(ii+7,ii+6)=fij*(aboard/(2*aboard+4*abside(ii+1)));
vf(ii+6,ii+7)=fij*(aboard/(2*aboard+4*abside(ii)));
vf(ii+6,3:6)=(1-sum(vf(ii+6,:)))/4;
vf(3:6,ii+6)=vf(ii+6,3)*(atboard(ii)/awall);
end
vf(length(hm)+6,3:6)=(1-sum(vf(length(hm)+6,:)))/4;
vf(3:6,length(hm)+6)=vf(length(hm)+6,3)*(atboard(length(hm))/awall);

%now for side walls to other side walls
rem=sum(vf(2:6,:));
vf(3,4)=rem(1)*radj;
vf(3,5)=rem(1)*rpar;
vf(3,6)=rem(1)*radj;

vf(4,3)=rem(2)*radj;
vf(4,5)=rem(2)*radj;
vf(4,6)=rem(2)*rpar;

vf(5,3)=rem(3)*rpar;
vf(5,4)=rem(3)*radj;
vf(5,6)=rem(3)*radj;

vf(6,3)=rem(4)*radj;
vf(6,4)=rem(4)*rpar;
vf(6,5)=rem(4)*radj;

radcond=vf;

radcond(1,:)=radcond(1,:)*atop*emiss*sb;
radcond(2,:)=radcond(2,:)*atop*emiss*sb;
radcond(3,:)=radcond(3,:)*awall*emiss*sb;
radcond(4,:)=radcond(4,:)*awall*emiss*sb;
radcond(5,:)=radcond(5,:)*awall*emiss*sb;
radcond(6,:)=radcond(6,:)*awall*emiss*sb;

for jj=7:length(radcond)
    radcond(jj,:)=radcond(jj,:)*atboard(jj-6)*emiss*sb;
end
end
