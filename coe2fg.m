function[f,g,fdot,gdot]=coe2fg(h,mu,ta,ec)
%see lecture 3, slide 30
r0=((h^2)/mu)/(1+ec*cos(ta(1)));
vr0=(mu/h)*(ec*sin(ta(1)));
f=zeros(1,101);g=zeros(1,101);fdot=zeros(1,101);gdot=zeros(1,101);
for ii=1:101
    dTa=ta(ii)-ta(1);
    r=((h^2)/mu)/(1+((((h^2)/(mu*r0))-1)*cos(dTa))-(((h*vr0)/mu)*sin(dTa)));
    f(ii)=1-((mu*r/(h^2))*(1-cos(dTa)));
    g(ii)=((r*r0)/h)*sin(dTa);
    gdot(ii)=1-((mu*r0)/(h^2))*(1-cos(dTa));
    fdot(ii)=(mu/h)*((1-cos(dTa))/(sin(dTa)))*((mu/h^2)*(1-cos(dTa))-(1/r0)-(1/r));
end