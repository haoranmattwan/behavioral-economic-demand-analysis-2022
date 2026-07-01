* Run from the repository root so this relative path resolves correctly.
use "Stata/dataset/data.dta", clear

nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if subj == 2 & cond == 3
nl (lfoodr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*foodfr)-1))) if subj == 3 & cond == 3

nl (lsocr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*socfr)-1))) if subj == 2 & cond == 3
nl (lsocr = log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5)*(1+(exp(-({b1=0.1})/(log10(0.5*({b0=2})+(0.25*({b0=2})^2+1)^0.5))*(({b0=2}))*socfr)-1))) if subj == 3 & cond == 3
