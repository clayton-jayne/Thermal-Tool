function[delt]=tstep(radcond,kmat,tcap)
for ii=1:length(tcap)
    radcond(ii,:)=tcap(ii)*radcond(ii,:);
    kmat(ii,:)=tcap(ii)*kmat(ii,:);
end
radcond=1./radcond;
    kmat=1./kmat;
    minstep=zeros(length(tcap),1);
    for jj=1:length(tcap)
        minstep(jj)=1/(sum(radcond(jj,:))+sum(kmat(jj,:)));
    end
    delt=.9*min(minstep);
end