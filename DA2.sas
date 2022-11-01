proc import out=my_data
    datafile="/home/u62322946/DA2/CompanyABCProfit.csv"
    dbms=csv
    replace;
    getnames=YES;
run;

PROC PRINT DATA=my_data;
RUN;

PROC CONTENTS DATA=my_data;
RUN;

PROC UNIVARIATE DATA=my_data;
  VAR "Profit(Rs '000)"n;
RUN;

proc sgplot data=my_data;
  histogram "Profit(Rs '000)"n;
  density "Profit(Rs '000)"n;
run;

proc surveyselect data=my_data method=srs n=100
                  out=sample_data;
run;

PROC PRINT DATA=sample_data;
RUN;

PROC UNIVARIATE DATA=sample_data;
  VAR "Profit(Rs '000)"n;
RUN;


/* t test */
ods noproctitle;
ods graphics / imagemap=on;

/* Test for normality */
proc univariate data=WORK.SAMPLE_DATA normal mu0=1000;
	ods select TestsForNormality;
	var 'Profit(Rs ''000)'n;
run;

/* t test */
proc ttest data=WORK.SAMPLE_DATA sides=2 h0=1000 plots(showh0);
	var 'Profit(Rs ''000)'n;
run;

/* correlation */
ods noproctitle;
ods graphics / imagemap=on;

proc corr data=WORK.SAMPLE_DATA pearson nosimple noprob plots=none;
	var 'Profit(Rs ''000)'n;
	with Year;
run;





