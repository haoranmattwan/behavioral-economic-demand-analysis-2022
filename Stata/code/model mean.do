use "/Users/mattwan/Google Drive/Academic/Social Research - 2017/RatPrice/Stata modeling/data_mean.dta"

nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if cond == 1
nl (lsocr =log10({b0=40})+(-({b1=1}))*exp(-({b2=0.001})*foodfr)) if cond == 1
reg lsocr foodfr if cond == 1

nl (lsocr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*socfr)-1))) if cond == 2
nl (lfoodr =log10({b0=100})+(-({b1=0}))*exp(-({b2=0})*socfr)) if cond == 2
reg lfoodr socfr if cond == 2

nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if cond == 3
nl (lsocr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*socfr)-1))) if cond == 3

nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if cond == 4
