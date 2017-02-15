function[eAOut,taOut]=taFind(mAt,ec,acc)
%see lecture 3, slide 13 for details
if mAt>pi%starting values depend on mean anom.
    e0=mAt-ec/2;
    err=(e0-ec*sin(e0)-mAt)/(1-ec*cos(e0));
    while err>acc
        f=e0-ec*sin(e0)-mAt;
        fp=1-ec*cos(e0);
        e0=e0-f/fp;
        err=f/fp;
    end
elseif mAt<pi
    e0=mAt+ec/2;
    err=(e0-ec*sin(e0)-mAt)/(1-ec*cos(e0));
    while err>acc
        f=e0-ec*sin(e0)-mAt;
        fp=1-ec*cos(e0);
        e0=e0-f/fp;
        err=f/fp;
    end
    
else% if Mean anom. is pi, ecc and true are also pi
    e0=pi;
end
eAOut=e0;%ecc anom is the main output
if eAOut>pi
taOut=2*pi-acos((cos(eAOut)-ec)/(1-ec*cos(eAOut)));%true anom is a secondary calculation
else
    taOut=acos((cos(eAOut)-ec)/(1-ec*cos(eAOut)));
end