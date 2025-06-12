L_SysFlash_Prog:
	BBS1	Sys_Flag_E,L_SysFlash_Prog_Judgement_Timer_Prog
	JSR		L_SysFlash_Set_Mode_Prog
	JSR		L_Clr_Col_Time_Prog
L_SysFlash_Prog_Judgement_Timer_Prog:
	BBR1	Sys_Flag_D,L_SysFlash_Set_Mode_Prog_RTS
	JSR		L_Clr_Timer_Symbol_Prog
	JSR		L_Clr_Timer_TurnPlate_Prog
	RTS	


L_SysFlash_Set_Mode_Prog:
	BBR3	Sys_Flag_A,L_SysFlash_Set_Mode_Prog_RTS
	;快旋转不闪烁
	LDA		R_Mode_Set
	CLC
	CLD
	ROL
	TAX
	LDA		Table_Set_Mode+1,X
	PHA
	LDA		Table_Set_Mode,X
	PHA
L_SysFlash_Set_Mode_Prog_RTS:
	RTS
Table_Set_Mode:
	DW		L_Clr_Hr_Prog-1
	DW		L_Clr_Min_Prog-1
	DW		L_Clr_Year_Prog-1
	DW		L_Clr_Month_Prog-1
	DW		L_Clr_Day_Prog-1



L_Clr_Hr_Prog:
	LDA		#10
	LDX		#lcd_d14
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d15
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS

L_Clr_Min_Prog:
	LDA		#10
	LDX		#lcd_d16
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d17
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS

L_Clr_Year_Prog:
	LDA		#10
	LDX		#lcd_d1
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d2
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
L_Clr_Month_Prog:
	LDA		#10
	LDX		#lcd_d3
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDX		#lcd_T6
	JSR		F_DispSymbol
	LDX		#lcd_T7
	JSR		F_DispSymbol
	RTS
L_Clr_Day_Prog:
	LDA		#10
	LDX		#lcd_d4
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		#10
	LDX		#lcd_d5
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS