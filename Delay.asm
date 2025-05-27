;============================================================
L_ScanKey_Delay_Prog:    ;延时功能
	LDA		#$E0
	STA		P_Temp
L_Loop_ScanKey_Delay:
	INC		P_Temp
	LDA		P_Temp
	BNE		L_Loop_ScanKey_Delay
	RTS
L_Beep_1s:    ;响一声
	BBR5	Sys_Flag_B,L_Beep_1s_RTS
L_Beep_1s_Usually:
	LDA		#1
	STA		R_Voice_Unit
	EN_LCD_IRQ
L_Beep_1s_RTS
	RTS
