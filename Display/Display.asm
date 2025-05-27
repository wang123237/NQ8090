
    


L_Display_Time_Normal_Prog:
	JSR		L_Display_Time_Sec_Prog
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

	
		
L_Display_Postive_Timer_Set_Mode_Prog:
	JSR		L_Dis_col_Prog
L_Display_Alarm_Normal_Prog:
L_Display_Alarm_Normal_Prog_OUT:
L_Display_Calculator_Normal_Prog:
	RTS	



L_Display_Another_Time_Normal_Prog:
	JSR		L_Display_Time_Sec_Prog
	LDA		R_Time_Sec
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Another_Time_Min_Prog
	LDA		R_Time_Min_Another
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Another_Time_Hr_Prog
	RTS




L_Display_Postive_Timer_Normal_Prog:
	BBR0	Sys_Flag_D,L_Display_Alarm_Normal_Prog;没有开始正计时是不显示
	BBS5	Sys_Flag_D,L_Display_Alarm_Normal_Prog;若有中途测量，不显示
	BBS6	Sys_Flag_A,L_Display_Alarm_Normal_Prog
	JSR		L_Display_Timer_Ms_Prog
	; LDA		R_Timer_Ms
	; BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Positive_Timer_Sec_Prog
	LDA		R_Timer_Sec
	BNE		L_Display_Alarm_Normal_Prog_OUT
	JSR		L_Display_Positive_Timer_Min_Prog
	; LDA		R_Timer_Min
	; BNE		L_Display_Alarm_Normal_Prog_OUT
	; JSR		L_Display_Positive_Timer_Hr_Prog
    RTS



L_Display_Set_Mode_Prog:
	LDA		R_Mode
	CLC
	CLD
	ROL
	TAX
	LDA		Table_Display_Set_Mode+1,X
	PHA		
	LDA		Table_Display_Set_Mode,X
	PHA	
L_Display_Set_Mode_Prog_RTS:
	RTS
Table_Display_Set_Mode:
	DW		L_Dispaly_Time_Prog_Set_Mode-1
	DW		L_Display_Set_Mode_Prog_RTS-1
	DW		L_Display_Alarm_Clock_Set_Prog-1
	DW		L_Display_Another_Time_Set_Mode_Prog-1
	DW		L_Display_Set_Mode_Prog_RTS-1


L_Dispaly_Time_Prog_Set_Mode:
	LDA		R_Mode_Set
	CMP		#5
	BCC		L_Display_Time_Prog_1
	LDA		R_Dis_Date_Time
	BNE		L_Dispaly_Time_Prog_Set_Mode_RTS
L_Dispaly_Time_Prog_Set_Mode_1:
	JSR		L_Display_Time_Date_Prog
	RTS
L_Dispaly_Time_Prog_Set_Mode_RTS:
	SEC
	LDA		R_Dis_Date_Time
	SBC		#1
	STA		R_Dis_Date_Time
	LDA		R_Dis_Date_Time
	BEQ		L_Dispaly_Time_Prog_Set_Mode_1
	RTS




L_Display_Prog:
	JSR		L_Dis_Alm_Snz_Symbol_Prog
	JSR		L_Dis_sig_Prog
	JSR		L_Dis_col_Prog
	CLD
	LDA		R_Mode
	CLC
	ROL
	TAX
	LDA		Table_Dis_1+1,X
	PHA
	LDA		Table_Dis_1,X
	PHA
L_Display_Prog_1:
	RTS
Table_Dis_1:
	DW		L_Display_Time_Prog-1
    DW      L_Display_Calculator_Prog-1
	DW		L_Display_Alarm_Prog-1
	DW		L_Display_Another_Time_Prog-1
	DW		L_Display_Postive_Timer_Prog-1

L_Display_Time_Prog:
	JSR		L_Display_Time_Week_Prog
L_Display_Time_Prog_1:
	JSR		L_Display_Time_Sec_Prog
	JSR		L_Display_Time_Min_Prog
	JSR		L_Display_Time_Hr_Prog
	RTS

L_Display_Alarm_Prog:
	JSR		L_Display_Alarm_Clock_AL_Symbol_Prog
L_Display_Alarm_Clock_Set_Prog:
	JSR		L_Display_Alarm_Clock_Hr_Prog
	JSR		L_Display_Alarm_Clock_Min_Prog
	RTS




L_Display_Postive_Timer_Prog:
	BBS6	Sys_Flag_A,L_Display_Prog_1
	BBS5	Sys_Flag_D,L_Display_Postive_Timer_Prog_1
    JSR     L_Display_Positive_Timer_Ms_Prog
	JSR		L_Display_Positive_Timer_Sec_Prog
	JSR		L_Display_Positive_Timer_Min_Prog
	JSR		L_Display_Positive_Timer_ST_Prog
    RTS
L_Display_Postive_Timer_Prog_1:
	JSR		L_Clr_Time_Week_Prog
	JSR		L_Display_Positive_Timer_LR_Prog
    JSR     L_Display_Positive_Timer_Ms_Prog_Measurement
	JSR		L_Display_Positive_Timer_Sec_Prog_Measurement
	JSR		L_Display_Positive_Timer_Min_Prog_Measurement
    RTS

L_Display_Another_Time_Prog:
	JSR		L_Display_Another_Time_DT_Symbol_Prog
L_Display_Another_Time_Set_Mode_Prog:	
	JSR		L_Display_Time_Sec_Prog
	JSR		L_Display_Another_Time_Min_Prog
	JSR		L_Display_Another_Time_Hr_Prog
	
	RTS






