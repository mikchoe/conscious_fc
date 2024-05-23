﻿* Encoding: UTF-8.
DEFINE !GEE_lnconnect (iPath !TOKENS (1) / Filename !TOKENS (1))

GET FILE = !iPath + !Filename + ".sav".

GENLIN lnconnect BY con_state (ORDER=ASCENDING)
      /MODEL con_state INTERCEPT=YES
     DISTRIBUTION=NORMAL LINK=IDENTITY
      /CRITERIA SCALE=MLE PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 
        LIKELIHOOD=FULL
      /EMMEANS TABLES=con_state SCALE=ORIGINAL
      /REPEATED SUBJECT=subject SORT=YES CORRTYPE=EXCHANGEABLE ADJUSTCORR=YES COVB=ROBUST 
        MAXITERATIONS=100 PCONVERGE=1e-006(ABSOLUTE) UPDATECORR=1
      /MISSING CLASSMISSING=EXCLUDE
      /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION WORKINGCORR.
    EXAMINE lnconnect BY con_state 
      /PLOT BOXPLOT
      /COMPARE VARIABLES
      /STATISTICS NONE
      /CINTERVAL 95
      /MISSING LISTWISE
      /NOTOTAL.
!ENDDEFINE.

DEFINE !GEE_connect (iPath !TOKENS (1) / Filename !TOKENS (1))

GET FILE = !iPath + !Filename + ".sav".

GENLIN connect BY con_state (ORDER=ASCENDING)
      /MODEL con_state INTERCEPT=YES
     DISTRIBUTION=NORMAL LINK=IDENTITY
      /CRITERIA SCALE=MLE PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 
        LIKELIHOOD=FULL
      /EMMEANS TABLES=con_state SCALE=ORIGINAL
      /REPEATED SUBJECT=subject SORT=YES CORRTYPE=EXCHANGEABLE ADJUSTCORR=YES COVB=ROBUST 
        MAXITERATIONS=100 PCONVERGE=1e-006(ABSOLUTE) UPDATECORR=1
      /MISSING CLASSMISSING=EXCLUDE
      /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION WORKINGCORR.
    EXAMINE connect BY con_state 
      /PLOT BOXPLOT
      /COMPARE VARIABLES
      /STATISTICS NONE
      /CINTERVAL 95
      /MISSING LISTWISE
      /NOTOTAL.
!ENDDEFINE.

DEFINE !save_GEEoutput (iPath !TOKENS (1) / Filename !TOKENS (1))

OUTPUT EXPORT
  /CONTENTS  EXPORT=ALL  LAYERS=PRINTSETTING  MODELVIEWS=PRINTSETTING
  /XLSX  DOCUMENTFILE=!iPath + !Filename + ".xlsx"
     OPERATION=CREATEFILE
     LOCATION=LASTCOLUMN  NOTESCAPTIONS=YES.

OUTPUT SAVE OUTFILE=!iPath + !Filename + ".spv".
OUTPUT CLOSE *. 

!ENDDEFINE.

DEFINE !OpenSav (iPath !TOKENS (1) / oPath !TOKENS (1) / Filename !TOKENS (1))

GET DATA /TYPE=XLS  /FILE=!iPath + !Filename + ".xls"
/SHEET=name 'Sheet1'
/READNAMES=OFF.

rename variables(V1 V2 V3 V4 V5 V6 V7=subject con_state CH1 CH2 connect lnconnect zconnect).

CACHE.
EXECUTE.
FORMATS subject con_state CH1 CH2 (F8.0).
FORMATS connect lnconnect zconnect (F8.5).
EXECUTE.

VARIABLE LEVEL subject con_state CH1 CH2 (Nominal).
VARIABLE LEVEL connect lnconnect zconnect (SCALE).
EXECUTE.

SAVE OUTFILE=!oPath + !Filename + ".sav" /COMPRESSED.

!ENDDEFINE.

DEFINE !GEE_lnconnect_4bigdata (iPath !TOKENS (1) / Filename !TOKENS (1))

GET FILE = !iPath + !Filename + ".sav".

GENLIN lnconnect BY con_state (ORDER=ASCENDING)
      /MODEL con_state INTERCEPT=YES
     DISTRIBUTION=NORMAL LINK=IDENTITY
      /CRITERIA SCALE=MLE PCONVERGE=1E-006(ABSOLUTE) SINGULAR=1E-012 ANALYSISTYPE=3(WALD) CILEVEL=95 
        LIKELIHOOD=FULL
      /EMMEANS TABLES=con_state SCALE=ORIGINAL
      /REPEATED SUBJECT=subject SORT=YES CORRTYPE=EXCHANGEABLE ADJUSTCORR=YES COVB=ROBUST 
        MAXITERATIONS=100 PCONVERGE=1e-006(ABSOLUTE) UPDATECORR=1
      /MISSING CLASSMISSING=EXCLUDE
      /PRINT CPS DESCRIPTIVES MODELINFO FIT SUMMARY SOLUTION.
    EXAMINE lnconnect BY con_state 
      /PLOT BOXPLOT
      /COMPARE VARIABLES
      /STATISTICS NONE
      /CINTERVAL 95
      /MISSING LISTWISE
      /NOTOTAL.
!ENDDEFINE.
