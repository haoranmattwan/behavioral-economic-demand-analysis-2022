use "/Users/mattwan/Google Drive/Academic/Social Research - 2017/RatPrice/Stata modeling/data.dta"

nl (lsocr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*socfr)-1))) if subj == 1 & cond == 2
nl (lsocr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*socfr)-1))) if subj == 2 & cond == 2
nl (lsocr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*socfr)-1))) if subj == 3 & cond == 2
nl (lsocr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*socfr)-1))) if subj == 4 & cond == 2

nl (lfoodr =log10({b0=100})+(-({b1=0}))*exp(-({b2=0})*socfr)) if subj == 1 & cond == 2
nl (lfoodr =log10({b0=197.0726})+(-({b1=-9.57e-11}))*exp(-({b2=-.5601971})*socfr)) if subj == 2 & cond == 2
nl (lfoodr =log10({b0=100})+(-({b1=0}))*exp(-({b2=0})*socfr)) if subj == 3 & cond == 2
nl (lfoodr =log10({b0=199.732})+(-({b1=-8.15e-10}))*exp(-({b2=-1.190015})*socfr)) if subj == 4 & cond == 2

reg lfoodr socfr if subj == 1 & cond == 2
reg lfoodr socfr if subj == 2 & cond == 2
reg lfoodr socfr if subj == 3 & cond == 2
reg lfoodr socfr if subj == 4 & cond == 2
