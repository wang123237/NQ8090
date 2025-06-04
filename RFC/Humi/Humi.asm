;------------------------------------------------
; PD7 : CAP= 102
; PD6 : RR=  39K
; PD5 : RT=  10K(3435)
; PD4 : RH=  (AHR01//1M)+510R
;------------------------------------------------
.INCLUDE	ZK-HS01.asm	
;.INCLUDE	ZK-HS02.asm	
;.INCLUDE	BS-AHR01.asm
;.INCLUDE	MS-Z3.asm	
;================================================
L_Humidity_Fail_Program:
    LDA     #$BB
	STA     R_Humidity
;    LDA     #$DD
;    STA     R_Humidity
	RTS
;-----------------------------------------------------------
;***********************************************************
;-----------------------------------------------------------
L_Counter_Humidity_Prog:
	LDA		R_Temperature_L
	AND		#$E0
	BNE		L_Humidity_Fail_Program
	LDA		R_Temperature
	CMP		#$51
	BCS		L_Humidity_Fail_Program
    LDA     R_RH_L
    ORA     R_RH_M
    ORA     R_RH_H
    BEQ     L_Humidity_Fail_Program
    LDA     R_RR_L
    ORA     R_RR_M
    ORA     R_RR_H
    BEQ     L_Humidity_Fail_Program

    LDA     R_RH_L
    STA     P_Temp+10 ; 0 ; 3
    LDA     R_RH_M
    STA     P_Temp+11 ; 1 ; 4
    LDA     #0H
    STA     P_Temp+12 ; 2 ; 5
    LDA     R_RR_L
    STA     P_Temp+13 ; 3 ; 0
    LDA     R_RR_M
    STA     P_Temp+14 ; 4 ; 1
    LDA     #0H
    STA     P_Temp+15 ; 5 ; 2
    JSR     L_Counter_T_Sbc_Prog
    LDA     P_Temp+9
    STA     P_Temp+8
    JSR     L_LSR_RH_Freq_8Bit_Prog
    JSR     L_Counter_T_Sbc_Prog
    LDA     P_Temp+9		
    JSR     L_Judge_Humidity_Level
    LDA     #$09	;#$19	;
    STA     R_Humidity
	LDA		#0
	STA		P_Temp+6
L_Loop_Counter_Humidity_Prog:
	JSR		L_Get_CheckTab_Value
    STA     P_Temp
    SEC
    LDA     P_Temp+9
    SBC     P_Temp
    STA     P_Temp+9
    LDA     P_Temp+8
    SBC     #0
    BCC     L_Adjust_Counter_Humidity_Prog
    STA     P_Temp+8
;   CLC
;   LDA     P_Temp+6
;   ADC     #1
;   STA     P_Temp+6
	INC		P_Temp+6
	
    SED
    CLC
    LDA     R_Humidity
    ADC     #01
    STA     R_Humidity
    CLD
	BCS		L_Humidity_High_Prog
;   LDA     R_Humidity
	CMP     #$96
	BCS		L_Humidity_High_Prog
	JMP		L_Loop_Counter_Humidity_Prog
L_Humidity_High_Prog:	
    LDA     #$CC
    STA     R_Humidity	;显示HH
    RTS

L_Adjust_Counter_Humidity_Prog:
    LDA     R_Humidity
    CMP    	#$10		;	#$20 ;
	BCC     L_Humidity_Low_Prog
	BBS7	R_Temperature_L,?RTS
	SEC	
    LDX     R_Humidity_Level
    LDA     Table_Humidity_Level,X
	SBC     R_Temperature	;Adjust
    STA     P_Temp			;小于5度温度的差值	
	CLC		
	ROR		P_Temp			;除2
	SED	
    CLC
    LDA     R_Humidity
    ADC     P_Temp
    STA     R_Humidity
    CLD
;	CMP		#$96
	BCS		L_Humidity_High_Prog
	CMP		#$96	;#$91
	BCS		L_Humidity_High_Prog
?RTS:	
    RTS
	

L_Humidity_Low_Prog:
    LDA     #$DD
    STA     R_Humidity	;显示LL
L_End_Counter_Humidity_Prog:
	RTS
;=============================================	
L_LSR_RH_Freq_8Bit_Prog:
    LDA     P_Temp+11
    STA     P_Temp+12
    LDA     P_Temp+10
    STA     P_Temp+11
    LDA     #0
    STA     P_Temp+10
	RTS
;============================================================
L_Judge_Humidity_Level:
;	JSR		L_Get_Temper_AdjustValue
    LDA     #0
    STA     R_Humidity_Level
	BBS7	R_Temperature_L,L_End_Judge_Humidity_Level ;负温度
L_Loop_Judge_Humidity_Level:
    LDX     R_Humidity_Level
    LDA     Table_Humidity_Level,X
    CMP     R_Temperature	;_Adjust
    BCS     L_End_Judge_Humidity_Level
    INC     R_Humidity_Level
    JMP     L_Loop_Judge_Humidity_Level
L_End_Judge_Humidity_Level:
;	SED
;	SEC
;	LDA     Table_Humidity_Level,X
;   SBC     R_Temperature_Adjust
;	STA		P_Temp+1	;温度差值
	RTS
	
Table_Humidity_Level:
	DB $00,$05,$10,$15,$20,$25,$30,$35,$40,$45,$50,$55,$60,$65,$FF
;============================================================		
L_Get_CheckTab_Value:
	LDA		R_Humidity_Level
;	ASL		A
	CLC
	ROL		
	TAX
	LDA     Tab_Himi_Level_Addr+1,X
	PHA
    LDA     Tab_Himi_Level_Addr,X
	PHA
	LDX		P_Temp+6		
    RTS
Tab_Himi_Level_Addr:		
    DW      Tab_00_Himi-1		
    DW      Tab_05_Himi-1
    DW      Tab_10_Himi-1
    DW      Tab_15_Himi-1
    DW      Tab_20_Himi-1
    DW      Tab_25_Himi-1
    DW      Tab_30_Himi-1
    DW      Tab_35_Himi-1
    DW      Tab_40_Himi-1
    DW      Tab_45_Himi-1
    DW      Tab_50_Himi-1
    DW      Tab_55_Himi-1
    DW      Tab_60_Himi-1
    DW      Tab_60_Himi-1
	
Tab_00_Himi:
	LDA		Tab_Temp_00,X
	RTS
Tab_05_Himi:
	LDA		Tab_Temp_05,X
	RTS	
Tab_10_Himi:
	LDA		Tab_Temp_10,X
	RTS	
Tab_15_Himi:
	LDA		Tab_Temp_15,X
	RTS		
Tab_20_Himi:
	LDA		Tab_Temp_20,X
	RTS	
Tab_25_Himi:
	LDA		Tab_Temp_25,X
	RTS	
Tab_30_Himi:
	LDA		Tab_Temp_30,X
	RTS	
Tab_35_Himi:
	LDA		Tab_Temp_35,X
	RTS	
Tab_40_Himi:
	LDA		Tab_Temp_40,X
	RTS	
Tab_45_Himi:
	LDA		Tab_Temp_45,X
	RTS	
Tab_50_Himi:
	LDA		Tab_Temp_50,X
	RTS	
Tab_55_Himi:
	LDA		Tab_Temp_55,X
	RTS	
Tab_60_Himi:
	LDA		Tab_Temp_60,X
	RTS	
;;===========================================
