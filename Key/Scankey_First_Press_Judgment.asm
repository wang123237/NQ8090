L_Scankey_Prog_First:
	LDA		P_Scankey_value_T_1;清空无效标志位
	CMP		#1
	BCS		L_Scankey_Prog_First_1
	INC		P_Scankey_value_T_1
L_Scankey_Prog_First_RTS:
	RTS
L_ScanKey_Null_Prog_To:
	SMB5	Sys_Flag_A
	JMP		L_Scankey_Prog_Ineffective





L_Scankey_Prog_First_1:
	RMB1	Sys_Flag_A
	JSR		L_Scankey_usually_Prog
	LDA		P_Scankey_value_Temporary
	BEQ		L_ScanKey_Null_Prog_To
	STA		P_Scankey_value



	LDA		#0
	STA		R_Scankey_Time
	SMB2	Sys_Flag_A

	LDA		P_Scankey_value
	CMP		#D_12_24_Hour_Press
	BEQ		L_Control_12_24_Hour_Prog	
	LDA		R_Mode
	BEQ		L_Timer_Clock_Prog_TO
	




L_Timer_Clock_Prog_TO:
	JMP		L_Timer_Clock_Prog


;===========================================================
L_Control_12_24_Hour_Prog:
	BBS2	Sys_Flag_B,L_Control_24_TO_12_Prog
	SMB2	Sys_Flag_B
	JSR		L_Display_Prog
	RTS	
L_Control_24_TO_12_Prog:
	RMB2	Sys_Flag_B
	JSR		L_Display_Prog
	RTS	
;===========================================================
L_Scankey_usually_Prog:
	LDA		#0
	STA		P_Scankey_value_Temporary
	JSR		L_PA_Input_Low
	LDA		P_PA
	AND		#P_Scankey_value
	BEQ		L_Scankey_usually_Prog_RTS
	JSR		L_PA_Input_High
L_Scankey_usually_Prog_RTS:
	RTS