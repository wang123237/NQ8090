
    


L_Display_Time_Normal_Prog:
	LDA		R_Time_Sec
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Time_Min_Prog
	LDA		R_Time_Min
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Time_Hr_Prog
	LDA		R_Time_Min
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Clr_Time_Week_Prog
	JMP		L_Display_Time_Week_Prog

	
		










L_Display_Prog:
	
	JSR		L_Display_Time_Sec_Prog
	JSR		L_Display_Time_Min_Prog
	JSR		L_Display_Time_Hr_Prog
	JSR		L_Display_Time_Month_Prog
	JSR		L_Display_Time_Day_Prog
	JSR		L_Display_Time_Week_Prog
	RTS






