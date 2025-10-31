use "/Users/mattwan/Google Drive/Academic/Social Research - 2017/RatPrice/Stata modeling/data.dta"

nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if subj == 1 & cond == 1
nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if subj == 2 & cond == 1
nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if subj == 3 & cond == 1
nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if subj == 4 & cond == 1

nl (lsocr =log10({b0=40})+(-({b1=1}))*exp(-({b2=0.001})*foodfr)) if subj == 1 & cond == 1
nl (lsocr =log10({b0=40})+(-({b1=1}))*exp(-({b2=0.001})*foodfr)) if subj == 2 & cond == 1
nl (lsocr =log10({b0=40})+(-({b1=1}))*exp(-({b2=0.000001})*foodfr)) if subj == 3 & cond == 1
nl (lsocr =log10({b0=40})+(-({b1=1}))*exp(-({b2=0.000001})*foodfr)) if subj == 4 & cond == 1

reg lsocr foodfr if subj == 1 & cond == 1
reg lsocr foodfr if subj == 2 & cond == 1
reg lsocr foodfr if subj == 3 & cond == 1
reg lsocr foodfr if subj == 4 & cond == 1
