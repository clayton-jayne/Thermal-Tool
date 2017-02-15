function[gen]=cgen(dcyc,lit,tgen)
%dcyc will be a two column array with the right (1) number corresponding to
%sunlit running capacity and the left corresponding to eclipsed. If a
%uniform duty cycle is chosen then the two will be identical. tgen is the
%base power of the component
gen=zeros(length(lit),length(dcyc));
for ii=1:length(lit)
    if lit(ii)==1
    for jj=1:length(dcyc)
        gen(ii,jj)=tgen(jj)*dcyc(jj,1);
    end
    elseif lit(ii)==0
    for jj=1:length(dcyc)
        gen(ii,jj)=tgen(jj)*dcyc(jj,2);
    end
    end
end
end