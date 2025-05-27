L_SysFlash_Prog:
	JSR		L_SysFlash_Set_Mode_Prog
	JSR		L_SysFlash_Prog_Positive_Timer
	JSR		L_SysFlash_Alm_Symbol_Prog
	JSR		L_SysFlash_Snz_Symbol_Prog
L_SysFlash_Prog_RTS:
	RTS

L_SysFlash_Alm_Symbol_Prog:
	BBR4	Sys_Flag_C,L_SysFlash_Prog_RTS
	JSR		L_Clr_lcd_Alm_Prog
	RTS
L_SysFlash_Snz_Symbol_Prog:
	BBS4	Sys_Flag_C,L_SysFlash_Prog_RTS
	BBR7	Sys_Flag_C,L_SysFlash_Prog_RTS
	JSR		L_Clr_lcd_Snz_Prog
	RTS

L_SysFlash_Prog_Positive_Timer:
	BBR0	Sys_Flag_D,L_SysFlash_Prog_Positive_Timer_RTS
	LDA		R_Mode
	CMP		#4
	BNE		L_SysFlash_Prog_Positive_Timer_RTS
	JSR		L_Clr_col_Prog
L_SysFlash_Prog_Positive_Timer_RTS:
	RTS
	
L_SysFlash_Set_Mode_Prog:
	BBR3	Sys_Flag_A,L_SysFlash_Prog_Positive_Timer_RTS
	LDA		R_Dis_Date_Time
	BNE		L_SysFlash_Prog_Positive_Timer_RTS
	JSR		L_CLR_AM_PM_Prog
	LDA		R_Mode
	CLC
	CLD
	ROL
	TAX
	LDA		Table_SysFlash+1,X
	PHA
	LDA		Table_SysFlash,X
	PHA		
	RTS
Table_SysFlash:
	DW		L_SysFlash_Set_Mode_Prog_Time-1
	DW		L_SysFlash_Prog_Positive_Timer_RTS-1
	DW		L_SysFlash_Set_Mode_Prog_usually-1
	DW		L_SysFlash_Set_Mode_Prog_usually-1
	DW		L_SysFlash_Prog_Positive_Timer_RTS-1



L_SysFlash_Set_Mode_Prog_Time:
	CLC
	CLD
	LDA		R_Mode_Set
	ROL
	TAX
	LDA		Table_SysFlash_Time+1,X
	PHA
	LDA		Table_SysFlash_Time,X
	PHA
	RTS
Table_SysFlash_Time:
	DW		L_SysFlash_Set_Mode_Prog_Time_Sec-1
Table_Usually:
	DW		L_Clr_lcd_d1_Prog-1
	DW		L_Clr_lcd_d2_Prog-1
	DW		L_Clr_lcd_d4_Prog-1
	DW		L_Clr_lcd_d5_Prog-1
	DW		L_Clr_lcd_d1_Prog-1
	DW		L_Clr_lcd_d2_Prog-1
	DW		L_Clr_lcd_d4_Prog-1
	DW		L_Clr_lcd_d5_Prog-1
	DW		L_Clr_lcd_d7_Prog-1
	DW		L_Clr_lcd_d8_Prog-1
L_SysFlash_Set_Mode_Prog_Time_Sec:
	JSR		L_Clr_lcd_d8_Prog
	JSR		L_Clr_lcd_d7_Prog
	RTS
L_SysFlash_Set_Mode_Prog_usually:
	CLC
	CLD
	LDA		R_Mode_Set
	ROL
	TAX
	LDA		Table_Usually+1,X
	PHA		
	LDA		Table_Usually,X
	PHA
	RTS

L_CLR_AM_PM_Prog:
	LDA		R_Mode
	BEQ		L_CLR_AM_PM_Prog_Time
	LDA		R_Mode_Set
	CMP		#4
	BCS		L_CLR_AM_PM_Prog_RTS
	JSR		L_Clr_lcd_AM_Prog
	JSR		L_Clr_lcd_PM_Prog
L_CLR_AM_PM_Prog_RTS:
	RTS
L_CLR_AM_PM_Prog_Time:
	LDA		R_Mode_Set
	BEQ		L_CLR_AM_PM_Prog_RTS
	CMP		#4
	BCS		L_CLR_AM_PM_Prog_RTS
	JSR		L_Clr_lcd_AM_Prog
	JSR		L_Clr_lcd_PM_Prog
	RTS	