L_Scankey_Prog_First:
	LDA		P_Scankey_value_T_1;清空无效标志位
	CMP		#1
	BCS		L_Scankey_Prog_First_1
	; JSR		L_Scankey_usually_Prog
	; LDA		P_Scankey_value_Temporary
	; STA		P_Scankey_value
	INC		P_Scankey_value_T_1
L_Scankey_Prog_First_RTS:
	RTS
L_ScanKey_Null_Prog_To:
	SMB5	Sys_Flag_A
	JMP		L_Scankey_Prog_Ineffective





L_Scankey_Prog_First_1:
	RMB1	Sys_Flag_A
	LDA		#0
	STA		P_Scankey_value_T_1
	STA		R_Voice_Unit
	
	JSR		L_Close_Beep_Prog

	JSR		L_Scankey_usually_Prog
	LDA		P_Scankey_value_Temporary
	STA		P_Scankey_value
	BEQ		L_ScanKey_Null_Prog_To
	BBS5	Sys_Flag_A,L_ScanKey_Null_Prog_To
	LDA		#0
	STA		R_Close_Beep_Time
	STA		R_Voice_Unit
	STA		R_Set_Mode_Exit_Time
	STA		R_Alarm_Clock_Open_Beep_Time
	STA		Time_To_Clock_Mode
	STA		R_Scankey_Time

	SMB5	Sys_Flag_A
	BBS4	Sys_Flag_C,L_Scankey_Short_ST_SP_Press_Prog_Alarm_TO;闹铃判断
	SMB2	Sys_Flag_A
;=======================
;-----按键无效键和按下触发的事件判定
	BBS3	Sys_Flag_A,L_Scankey_Set_Mode_First_Press_Prog_TO
	LDA		P_Scankey_value
	CMP		#D_Mode_Press
	BEQ		L_Scankey_Mode_Press_Prog_TO
	SMB7	Sys_Flag_A
	CMP		#D_Set_Press
	BEQ		L_Scankey_Set_Press_Prog
	LDA		R_Mode
	CMP		#5
	BCS		L_Scankey_Prog_First_1_OUT
	CLD
	CLC
	ROL
	TAX
	LDA		Table_Mode+1,X
	PHA
	LDA		Table_Mode,X
	PHA	
	RTS
L_Scankey_Mode_Press_Prog_TO:
	JMP		L_Scankey_Mode_Press_Prog
L_Scankey_Set_Mode_First_Press_Prog_TO:
	JMP		L_Scankey_Set_Mode_First_Press_Prog
L_Scankey_Short_ST_SP_Press_Prog_Alarm_TO:
	JMP		L_Scankey_Short_ST_SP_Press_Prog_Alarm
L_Scankey_Set_Press_Prog:
	SMB5	Sys_Flag_A
	LDA		R_Mode
	CMP		#1
	BEQ		L_control_Beep_Prog_ALL
	CMP		#4
	BEQ		L_Scankey_Prog_First_OUT
	JSR		L_Control_SNZ_Close_Prog
	LDA		#0
	STA		R_Mode_Set
	STA		R_Dis_Date_Time
	SMB3	Sys_Flag_A
	JSR		L_Display_Set_Mode_Prog
	LDA		R_Mode
	BEQ		L_Clr_Time_Week_Prog_TO
	CMP		#2
	BEQ		L_Scankey_Set_Press_Prog_Alarm_Mode
	RTS
L_Clr_Time_Week_Prog_TO:
	JMP		L_Clr_Time_Week_Prog

L_Scankey_Set_Press_Prog_Alarm_Mode:
	LDA		#0
	STA		R_Alarm_Mode
	JSR		L_Dis_Alm_Snz_Symbol_Prog
	RTS


L_Scankey_Prog_First_1_OUT:
	LDA		#0
	STA		R_Mode
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Display_Prog
	
L_Scankey_Prog_First_OUT:
	SMB5	Sys_Flag_A
	RTS

L_control_Beep_Prog_ALL:;控制声音
	BBS5	Sys_Flag_B,L_control_Beep_Prog_ALL_1
	SMB5	Sys_Flag_B
	JSR		L_Beep_1s
	RTS
L_control_Beep_Prog_ALL_1:
	RMB5	Sys_Flag_B
	RTS

Table_Mode:
	DW		L_Clock_First_Press_Prog-1
	DW		L_Calculator_Frist_Press_Prog-1
	DW		L_Alarm_First_Press_Prog-1
	DW		L_Clock_Twice_First_Press_Prog-1
	DW		L_Positive_Timer_First_Press_Prog-1
	