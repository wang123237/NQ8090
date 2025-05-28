L_Alarm_Prog:;闹钟判断的时间是贪睡闹钟时间，而正常闹钟时间作为显示闹钟时间
	BBR1	Sys_Flag_C,L_Alarm_Prog_OUT
	BBS4	Sys_Flag_C,L_Alarm_Prog_OUT

	LDA		R_Time_Sec
	BNE		L_Alarm_Prog_OUT
	LDA		R_Time_Hr
	CMP		R_Alarm_Clock_Hr
	BNE		L_Alarm_Prog_OUT
	LDA		R_Time_Min
	CMP		R_Alarm_Clock_Min
	BNE		L_Alarm_Prog_OUT
L_Alarm_Prog_1:
	SMB4	Sys_Flag_C
	LDA		#D_Beep_Open_Last_Time_Alarm
	STA		R_Close_Beep_Time
	JSR		L_Control_Beep_prog_Auto_Exit
L_Alarm_Prog_OUT:
	RTS
		




	


