;========================================================================================
;				RFC 50P016_Program
;========================================================================================
;1、Set PD as input tri-state
;2、Disable TMR0 and TMR1 interrupt
;3、Set TRM0S0 to '1' to select TMR0 clock source as Frcx
;4、Clear TMR1S[1:0]='00' to select TMR1 clock source as TMR0 output
;5、Set TMR_SYNC to '1'
;6、Write 00h to both TMR0 and TMR1
;7、Select a desired RC combination for measurement by setting RFC[1:0], CRT0S and RT01S register bits
;8、Set RFCEN0 or RFCEN1 to ‘1’.The external RC combination will start oscillating.
;9、Clear DIVF interrupt flag.
;10、Enable DIV interrupt then wait a DIV interrupt occurs
;11、Clear TMR0F,TMR1F and DIVF interrupt flags.
;12、Set TMR0On and TMR1ON at the same time.TMR0 and TMR1 will not start counting until the next DIV interrupt occurs(1st DIV occurs).
;13、Wait while the nth DIV occurs, clear TMR0ON and TMR0ON at the same time.
;    TMR0 and TMR1 will not stop counting until the (n+1)th DIV occurs.
;14、Read TMR0 and TMR1 data and check TMR1F to get the RC counts of this measurement
;15、Clear RFCEN0 or RFCEN1 to finish the RC oscillation measurement
;16、Repeat step 6 to 15 will get the RC counts of other RC combination
;========================================================================================
C_RfcTime		equ		8 ;10 	;n(div)=1KHZ 10mS
;========================================================================================
M_RFC0IOEn:	.MACRO
		smb0	RFCC0
		smb1	RFCC0
		smb2	RFCC0
		smb3	RFCC0
		.ENDM   
M_RFC1IOEn:	.MACRO
		smb3	RFCC0
		smb5	RFCC0
		smb6	RFCC0
		smb7	RFCC0
		
		rmb7	PCSEG
		
		rmb4	PDSEG
		rmb5	PDSEG
		rmb6	PDSEG
		rmb7	PDSEG		
		.ENDM
		
M_PD0PD3:	.MACRO
		rmb0	RFCC0
		rmb1	RFCC0
		rmb2	RFCC0
		rmb3	RFCC0
		
		smb0	PDDIR
		smb1	PDDIR
		smb2	PDDIR
		smb3	PDDIR
    
		smb0	PDD
		smb1	PDD
		smb2	PDD
		smb3	PDD
		.ENDM				
M_PD4PD7:	.MACRO
		rmb4	RFCC0
		rmb5	RFCC0
		rmb6	RFCC0
		rmb7	RFCC0

		smb4	PDDIR
		smb5	PDDIR
		smb6	PDDIR
		smb7	PDDIR

		smb4	PDD
		smb5	PDD
		smb6	PDD
		smb7	PDD
		.ENDM	
;============================================
F_RFCInit:

		rmb3	PDSEG
		rmb2	PDSEG
		rmb1	PDSEG
		rmb0	PDSEG

		smb0	RFCC0
		smb1	RFCC0
		smb2	RFCC0
		smb3	RFCC0
		; M_RFC0IOEn
		; M_RFC1IOEn
		; M_PD0PD3
;		lda	#20
;		ldx	#0
;		jsr	F_GetFrcx
;		lda	<P_TMR0L
;		sta	R_RFC0+0
;		lda	<P_TMR0H
;		sta	R_RFC0+1
;		
;		lda	#20
;		ldx	#1
;		jsr	F_GetFrcx
;		lda	<P_TMR0L
;		sta	R_RFC1+0
;		lda	<P_TMR0H
;		sta	R_RFC1+1
		rts
;=================================================
F_GetFrcMode0:		;input R_RFCCH : wait time, Xcc : Which Port
		sta		R_RFCCH			;保存测量时间参数，等待DIV中断次数
;		stx		R_Tmp1
		rmb1	P_IER			;clear Tmr0 int，禁用中断
		rmb2	P_IER			;clear Tmr1 int，禁用中断
		
		rmb0	P_IFR			;clear div int flag，清除DIV中断标志
L_0WaitDiv:
		bbr0	P_IFR,L_0WaitDiv
		
		rmb0	P_IFR			;clear div int flag		
		rmb1	P_IFR			;clear tm0 int flag
		rmb2	P_IFR			;clear tm1 int flag
;保证计数器在DIV时钟的同步下启动，避免计数偏差


;		rmb0	<P_TMRC			;close tmr0
		rmb0	<P_TMRC			
		rmb1	<P_TMRC			;close tmr0 and tmr1

;		lda		#0		
;		sta		<P_TMR0L		;clr tmr0
;		sta		<P_TMR0H	    ;备注：易码母体必须先写低位，后写高位。
                                ;读则反之，必须先读高位，后读低位。
		lda		#0
		sta		P_TMR0
		sta		P_TMR1								
;重置计数器，为新的测量周期准备								

		lda		#%00000011	
		sta		P_TMCLK			;set timer0 from T01 ,timer1 from timer0
		
		smb6	P_DIVC			;set sync with tm0 and tm1
		smb6	P_TMRC			;T01=T0CK1，TMR1级联到TMR0形成24为计数器
;		rmb6	P_TMRC			;T01 = Fosc/4
		
		lda		T_RFCTable,x
		sta		RFCC1			;选择传感器接口
;		JSR	F_Delay100Ms
		
;		smb0	<P_TMRC			;open tmr0
		smb0	P_TMRC			
		smb1	P_TMRC			;open tmr0 and tmr1	
L_0WaitDiv2:
		bbr0	<P_IFR,L_0WaitDiv2
		rmb0	<P_IFR			;clear div int flag
		dec		R_RFCCH			;等待测量时间耗尽
		bne		L_0WaitDiv2
L_0Exit:
;		rmb0	<P_TMRC			;close tmr0
		rmb0	<P_TMRC			
		rmb1	<P_TMRC		;close tmr0 and tmr1
L_0WaitDiv3:
		bbr0	<P_IFR,L_0WaitDiv3
		rmb0	<P_IFR		;clear div int flag		
		lda		#0
		sta		RFCC1
		
		rmb6	P_TMRC			;T01 = Fosc/4		
		rts

T_RFCTable:
;;;;;;2nd
	; db	%00111000	; RT01		;0
	; db	%00011000	; RS1RT0 	;1
	; db	%00101000	; CS1RT01	;2 CS---GND
	db	%00101000	; RH_PD3
	db	%00011000	; RT_PD2
	db	%01101000	; RR_PD1	;CS---GND

	db	%10101000	; RT01		;3
	db	%10011000	; RS1RT0 	;CS---CS1RT01
;=========================================================
;=========================================================
F_GetFrcMode1:		;input R_Tmp0 : wait time, Xcc : Which Port(Long Time Mode)
		sta		R_Tmp0
		
		rmb0	RFCC1		;clear rfci

;		rmb0	<P_TMRC		;close tmr0
		rmb0	<P_TMRC			
		rmb1	<P_TMRC			;close tmr0 and tmr1

;		lda	#0
;		sta	<P_TMR0L
;		sta	<P_TMR0H
		lda		#0
		sta		<P_TMR0
		sta		<P_TMR1

		lda		#%00000011	
		sta		<P_TMCLK		;set timer0 from T01 ,timer1 from timer0
		
;		smb7	<P_TMRC			;set sync tm0 with div or frcx
;		rmb6	<P_TMRC			;T01 = F4M/4
		smb6	<P_DIVC			;set sync with tm0 and tm1
		rmb6	<P_TMRC			;T01 = Fosc/4		
		
		lda		T_RFCTable2,x
		sta		RFCC1			
		
		rmb0	RFCC1		;clear rfci int flag
L_1WaitDiv:
		bbr0	RFCC1,L_1WaitDiv
		
		rmb0	RFCC1		;clear rfci

;		smb0	<P_TMRC		;open tmr0
		smb0	<P_TMRC			
		smb1	<P_TMRC			;open tmr0 and tmr1
L_1WaitDiv2:
		bbr0	RFCC1,L_1WaitDiv2
		rmb0	RFCC1			;clear div int flag
		dec		R_Tmp0
		bne		L_1WaitDiv2
L_1Exit:
;		rmb0	<P_TMRC			;close tmr0
		rmb0	<P_TMRC			
		rmb1	<P_TMRC		;close tmr0 and tmr1	
L_1WaitDiv3:
		bbr0	RFCC1,L_1WaitDiv3
		lda		#0
		sta		RFCC1
		rts
		
T_RFCTable2:
;;;;;;2nd
	db	%00101110	; RH_PD3
	db	%00011110	; RT_PD2
	db	%01101110	; RR_PD1	;CS---GND
	
	db	%10101110	; RT01	
	db	%10011110	; RS1RT0 	;CS---CS1RT01	
;======================================================
;======================================================
F_RfcTest:
		DIV_256HZ					;设置分频器为256HZ
		; Fsys_Fosc_1
		Fcpu_Fext					;切换外部时钟
		NOP
		Fosc_OFF					;关闭主振荡器
		NOP
		SEI							;关闭全局中断
		PD03_RFC	
		ldx		#2	;#1				;选择RFC通道2
  		lda		#C_RfcTime			;测量周期
		jsr		F_GetFrcMode0
		lda		P_TMR0
		STA 	R_RR_L
		lda		P_TMR1
		STA 	R_RR_M	
		LDA 	#$00
		STA 	R_RR_H				;将读取的值储存起来，测量的是参考电阻RR

		ldx		#1	;#2	;
  		lda		#C_RfcTime
		jsr		F_GetFrcMode0	
		LDA 	P_TMR0
		STA 	R_RT_L
		LDA 	P_TMR1
		STA 	R_RT_M		
		LDA		#$00
		STA 	R_RT_H				;将读取的值储存起来，测量的是温度电阻RT
		
		ldx		#0	;#2	;
  		lda		#C_RfcTime
		jsr		F_GetFrcMode0		
		LDA 	P_TMR0
		STA 	R_RH_L
		LDA 	P_TMR1
		STA 	R_RH_M
		LDA		#$00
		STA 	R_RH_H				;将读取的值储存起来，测量的是湿度电阻RH
		
		Fosc_ON
		NOP
		Fsys_Fosc_2		
		Fcpu_Fsys
		NOP
		CLI
		JSR		L_Counter_Temperature_Prog		
		JSR		L_Counter_Humidity_Prog
		RTS	
;=======================================================
F_Delay100Ms:
		ldx	#$FE	;#E0H
L_WaitLoop1:
		lda	#0
L_WaitLoop:
		clc
		adc	#1
		bne	L_WaitLoop
		inx
		bne	L_WaitLoop1
		rts
F_Delay2000Ms:
		LDX #0
L_2WaitLoop1:
		lda	#0
L_2WaitLoop:
		clc
		adc	#1
		bne	L_2WaitLoop
		inx
		bne	L_2WaitLoop1
		rts
;==================================
;F_WaitKey:
;		lda	<P_PA
;		and	#%00100000
;		bne	F_WaitKey
;		
;		lda	#10
;		sta	R_KeyCnt
;L_WaitDiv:
;		bbr0	<P_IFR,L_WaitDiv
;		rmb0	<P_IFR			;clear div int flag
;
;		lda	<P_PA
;		and	#%00100000
;		bne	F_WaitKey
;
;		dec	R_KeyCnt
;		bne	L_WaitDiv
;L_WaitKey:
;		lda	<P_PA
;		and	#%00100000
;		beq	L_WaitKey
;
;		lda	#10
;		sta	R_KeyCnt
;L_WaitDiv1:
;		bbr0	<P_IFR,L_WaitDiv1
;		rmb0	<P_IFR			;clear div int flag
;		lda	<P_PA
;		and	#%00100000
;		beq	L_WaitKey
;		dec	R_KeyCnt
;		bne	L_WaitDiv1
;		rts
;===============================================




		