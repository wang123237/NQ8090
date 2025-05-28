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
	LDA		