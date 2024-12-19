	PROGRAM TEST
	PARAMETER (NWPAWC = 15000)
	COMMON/PAWC/PAW(NWPAWC)
	CHARACTER*8 CHTAGS(5)
	DIMENSION EVENT(5)
	EQUIVALENCE (EVENT(1),X),(EVENT(2),Y),(EVENT(3),Z)
	EQUIVALENCE (EVENT(4),ENERGY),(EVENT(5),ELOSS)
	DATA CHTAGS/'X','Y','Z','Energy','Eloss'/
C
        CALL HLIMIT(NWPAWC)
	CALL HROPEN(1,'EXAMPLE','EXAMPLE.hbook','N',1024,ISTAT)
	IF(ISTAT.NE.0)GO TO 99

	CALL HBOOKN(10,'A Row-Wise-Ntuple',5,'//EXAMPLE',5000,CHTAGS)
	CALL HBOOK1(100,'Energy distribution',100,0.,100.,0.)
C
	DO 10 I=1,10000
	CALL RANNOR(X,Y)
	Z=SQRT(X*X+Y*Y)
	ENERGY=50. + 10.*X
	ELOSS=10.*ABS(Y)
	CALL HFN(10,EVENT)
	CALL HFILL(100,ENERGY,0.,1.)
 10	 CONTINUE
*
	CALL HROUT(0,ICYCLE,' ')
	CALL HREND('EXAMPLE')
*
 99	 CONTINUE
         END