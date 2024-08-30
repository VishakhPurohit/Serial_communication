org 000h
	mov tmod,#20h
	
	mov th1,#-3
	mov scon,#50h
	setb tr1
	clr ri
	here:jnb ri,here
	mov a,sbuf
	mov r1,a
	
	acall sev
	sjmp here
	
	
	sev:nop
	mov a,r1
	xrl a,#74h
	jnz aa
	mov p1,#0e0h
	sjmp en
	
	aa: mov p1,#0c0h
	en:nop
	ret