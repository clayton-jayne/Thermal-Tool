function[irabs,solabs]=sprop(sirem,ssolabs,fracpanel)
solabspanel=1;
iremispanel=1;
irabs=sirem*(1-fracpanel)+(iremispanel*fracpanel);
solabs=ssolabs*(1-fracpanel)+(solabspanel*fracpanel);
end