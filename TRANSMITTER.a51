	mov TMOD,#20h
	mov TH1,#-3
	mov SCON,#50h
	setb TR1
	AGAIN:MOV SBUF,#"J"
	HERE:JNB TI,HERE
	CLR TI
	mov r1, #10
	xx:mov r2, #200
	yy:mov r3, #200
	ss: djnz r3, ss
	djnz r2, yy
	djnz r1, xx
	
	SJMP AGAIN	