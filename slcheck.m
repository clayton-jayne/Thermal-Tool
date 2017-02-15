function[lit]=slcheck(rsat,rsun,rsunabs)
rearth=6378.1;%km
lit=zeros(length(rsat),1);
for ii=1:length(rsat)
rsatabs=sqrt((rsat(ii,1)^2)+(rsat(ii,2)^2)+(rsat(ii,3)^2));
taumin=((rsatabs^2)-dot(rsat(ii,:),rsun))/((rsatabs^2)+(rsunabs^2)-2*dot(rsat(ii,:),rsun));
c=((1-taumin)*rsatabs^2)+(dot(rsat(ii,:),rsun)*taumin);

if taumin<0
    lit(ii)=1;
end
if taumin>1
    lit(ii)=1;
end
if c>=rearth
    lit(ii)=1;
end
end
end