;======================================================================
;非设置模式下吗,任何模式Mode键按下触发，更改显示模式,计算器模式下，非0情况下清零
;如果按键则跳转回时间模式
;======================================================================
L_Scankey_Mode_Press_Prog:
	JSR		L_Beep_1s
	BBS7	Sys_Flag_A,L_Scankey_Mode_Press_Prog_TO_Clock_Mode
	JSR		L_Clr_All_DisRam_Prog
	LDA		R_Mode
	CMP		#4
	BCS		L_Scankey_Mode_Press_Prog_Clr
	LDA		R_Mode
	ADC		#1
	STA		R_Mode
	CMP		#1
	BNE		L_Scankey_Mode_Press_Prog_1
	JSR		L_Clear_Calculator_Prog
L_Scankey_Mode_Press_Prog_1:	
	JMP		L_Display_Prog
L_Scankey_Mode_Press_Prog_Clr:
	LDA		#0
	STA		R_Mode
	JSR		L_Clear_Calculator_Prog
	RMB5	Sys_Flag_D
	BRA		L_Scankey_Mode_Press_Prog_1
;===========================================
L_Scankey_Mode_Press_Prog_TO_Clock_Mode:;当按下按键后回到时间界面
	RMB7	Sys_Flag_A
	LDA		R_Mode
	BEQ		L_Scankey_Mode_Press_Prog
	CMP		#1
	BEQ		L_Scankey_Mode_Press_Prog_Calculator
L_Scankey_Mode_Press_Prog_TO_Clock_Mode_1:	
	LDA		#0
	STA		R_Mode
	JSR		L_Clear_Calculator_Prog
	RMB5	Sys_Flag_D
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Display_Prog
	RTS
L_Scankey_Mode_Press_Prog_Calculator:
	
	LDA		ERR
	BNE		L_Scankey_Mode_Press_Prog_Calculator_Err
	LDA		Calculator_Symbol_State
	BNE		L_Scankey_Mode_Press_Prog_Calculator_1
	JSR		L_Judge_BUF1_BUF2_IBUF_Prog
	BEQ		L_Scankey_Mode_Press_Prog_TO_Clock_Mode_1
L_Scankey_Mode_Press_Prog_Calculator_1:
	SMB7	Sys_Flag_A
	JSR		L_Clear_Calculator_Prog
	JSR		L_Display_Number_IBUF_Prog
	RTS
L_Scankey_Mode_Press_Prog_Calculator_Err:
	SMB7	Sys_Flag_A
	JSR		L_Clear_Calculator_Prog_ERR
	LDA		#0	
	STA		ERR
	JSR		L_Display_Number_BUF1_Prog
	
	RTS

