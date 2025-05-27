;==================================================
L_LCD_IRQ_WorkProg:;
	BBR0	Sys_Flag_A,L_END_LCD_IRQ_WorkProg;32hz扫键
	RMB0	Sys_Flag_A
	JSR		L_control_Beep_prog
	; JSR		L_Update_Timer_Ms_Prog
	; LDA		R_Reset_Time
	; BNE		L_END_LCD_IRQ_WorkProg
	JSR		L_Scankey_Prog
L_END_LCD_IRQ_WorkProg:
    RTS	
; ==============================================
L_ScanKey_Null_Prog:;如果编码器没有开启退出并且扫描到空键，停止按键扫描	
	LDA		R_Voice_Unit
	BNE		L_END_LCD_IRQ_WorkProg
	; BBS0	Sys_Flag_D,L_END_LCD_IRQ_WorkProg
	DIS_LCD_IRQ
	JSR		L_Judgement_Scankey_Prog
	RTS
L_Scankey_Prog_Ineffective:
	
	JSR		L_Scankey_usually_Prog
	LDA		P_Scankey_value_Temporary
	BNE		L_END_LCD_IRQ_WorkProg;如果为0则执行空键程序
	JSR		L_Judgement_Scankey_Prog
	JSR		L_ScanKey_Delay_Prog

	RMB5	Sys_Flag_A;清空无效标志位
	LDA		#10001011B
	AND		Sys_Flag_A
	STA		Sys_Flag_A
	
	EN_PA_IRQ
	RTS

;====================================================
L_Scankey_Prog:
	BBS5	Sys_Flag_A,L_Scankey_Prog_Ineffective
	BBS1	Sys_Flag_A,L_Scankey_Prog_First_TO;首次扫描判断
	
	BBS6	Sys_Flag_A,L_Scankey_Prog_Long_Press;快加情况
	
	BBR2	Sys_Flag_A,L_ScanKey_Null_Prog;没有按键扫描标志
	
	RTS



L_Scankey_Prog_First_TO:
	JMP		L_Scankey_Prog_First

L_Scankey_Prog_Long_Press:
	JSR		L_Scankey_usually_Prog
	LDA		R_Mode
	BNE		L_Scankey_Prog_Long_Press_Clock_Beep
L_Scankey_Prog_Long_Press_1:
	LDA		P_Scankey_value_Temporary
	CMP		P_Scankey_value
	BEQ		L_Scankey_Prog_Long_Press_RTS
	RMB6	Sys_Flag_A
	SMB5	Sys_Flag_A
	JSR		L_Clr_All_8Bit_Prog
	JSR		L_Display_Prog
L_Scankey_Prog_Long_Press_RTS:
	RTS
L_Scankey_Prog_Long_Press_Clock_Beep:
	CMP		#4
	BEQ		L_Scankey_Prog_Long_Press_1
	CMP		#2
	BNE		L_Scankey_Prog_Long_Press_Clock_Beep_1
	LDA		P_Scankey_value_Temporary
	CMP		P_Scankey_value
	BEQ		L_Scankey_Prog_Long_Press_Clock_Beep_RTS
	JSR		L_Close_Beep_Prog
	LDA		#0
	STA		R_Voice_Unit
	
L_Scankey_Prog_Long_Press_Clock_Beep_1:	
	SMB5	Sys_Flag_A
	RMB6	Sys_Flag_A
L_Scankey_Prog_Long_Press_Clock_Beep_RTS:
	RTS
L_Control_Beep_Test_Prog:
	BBR6	Sys_Flag_A,L_Scankey_Prog_Long_Press_Clock_Beep_RTS
	LDA		R_Mode
	CMP		#2
	BNE		L_Scankey_Prog_Long_Press_Clock_Beep_RTS
	LDA		#2
	STA		R_Voice_Unit
	EN_LCD_IRQ
	RTS	