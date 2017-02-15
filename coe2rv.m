function[ri,rj,rk,vi,vj,vk]=coe2rv(p,ta,ec,mu,raan,argP,inc)
%algorithm 10, pg 118
ri=zeros(1,101);
rj=zeros(1,101);
rk=zeros(1,101);
vi=zeros(1,101);
vj=zeros(1,101);
vk=zeros(1,101);
trans=[(cos(raan)*cos(argP))-(sin(raan)*sin(argP)*cos(inc)),(-1*cos(raan)*sin(argP))-(sin(raan)*cos(argP)*cos(inc)),sin(raan)*sin(inc);
    (sin(raan)*cos(argP))+(cos(raan)*sin(argP)*cos(inc)),(-1*sin(raan)*sin(argP))+(cos(raan)*cos(argP)*cos(inc)),-1*cos(raan)*sin(inc);
    sin(argP)*sin(inc),cos(argP)*sin(inc),cos(inc)];
for ii=1:101
rpqw=[(p*cos(ta(ii)))/(1+ec*(cos(ta(ii))));(p*sin(ta(ii)))/(1+ec*(cos(ta(ii))));0];
vpqw=[-1*(sqrt(mu/p)*(sin(ta(ii))));(sqrt(mu/p)*(ec+cos(ta(ii))));0];

rijk=trans*rpqw;
vijk=trans*vpqw;
ri(ii)=rijk(1);
rj(ii)=rijk(2);
rk(ii)=rijk(3);
vi(ii)=vijk(1);
vj(ii)=vijk(2);
vk(ii)=vijk(3);

end