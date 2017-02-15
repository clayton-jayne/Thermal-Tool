function [jd]=julian(yr,mo,d,h,min,s)
jd=(367*yr)-int8((7*int8((mo+9)/12))/4)+int8(275*mo/9)+d+1721013.5+((((s/60)+min)/60)+h)/24;

end