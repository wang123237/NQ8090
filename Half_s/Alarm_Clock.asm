L_Alarm_Prog:;闹钟判断的时间是贪睡闹钟时间，而正常闹钟时间作为显示闹钟时间
	LDA		R_Time_Sec
	BNE		L_Alarm_Prog_OUT
	LDA		R_Alarm_Open
	BEQ		L_Alarm_Prog_OUT;一分钟扫描一次，判断闹钟是否开启
	JSR		L_Judgement_Alarm_Clock_1
	JSR		L_Judgement_Alarm_Clock_2
	JSR		L_Judgement_Alarm_Clock_3
	JSR		L_Judgement_Alarm_Clock_4
	JSR		L_Judgement_Alarm_Clock_5


L_Alarm_Prog_OUT:
	RTS




;--------------------------------------------------------
L_Judgement_Alarm_Clock_1:
	BBS0	R_Alarm_Open,L_Judgement_Alarm_Clock_1_RTS
	LDA		R_Alarm_Clock_Hr
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_1_RTS
	LDA		R_Alarm_Clock_Min
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_1_RTS

	
L_Judgement_Alarm_Clock_1_RTS:
	RTS
;--------------------------------------------------------
L_Judgement_Alarm_Clock_2:
	BBS1	R_Alarm_Open,L_Judgement_Alarm_Clock_2_RTS
	LDA		R_Alarm_Clock_Hr+1
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_2_RTS
	LDA		R_Alarm_Clock_Min+1
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_2_RTS
	
L_Judgement_Alarm_Clock_2_RTS:
	RTS

;--------------------------------------------------------
L_Judgement_Alarm_Clock_3:
	BBS2	R_Alarm_Open,L_Judgement_Alarm_Clock_3_RTS
	LDA		R_Alarm_Clock_Hr+2
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_3_RTS
	LDA		R_Alarm_Clock_Min+2
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_3_RTS
	
L_Judgement_Alarm_Clock_3_RTS:
	RTS

;--------------------------------------------------------
L_Judgement_Alarm_Clock_4:
	BBS3	R_Alarm_Open,L_Judgement_Alarm_Clock_4_RTS
	LDA		R_Alarm_Clock_Hr+3
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_4_RTS
	LDA		R_Alarm_Clock_Min+3
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_4_RTS
	
L_Judgement_Alarm_Clock_4_RTS:
	RTS

;--------------------------------------------------------
L_Judgement_Alarm_Clock_5:
	BBS4	R_Alarm_Open,L_Judgement_Alarm_Clock_5_RTS
	LDA		R_Alarm_Clock_Hr+4
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_5_RTS
	LDA		R_Alarm_Clock_Min+4
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_5_RTS
	
L_Judgement_Alarm_Clock_5_RTS:
	RTS




L_JudgeMent_Alarm_Clock_State_Prog:
	STA		P_Temp
	LDA		R_Alarm_Open_State
	CMP		#1
	BEQ		L_Judgement_Alarm_Clock_5_RTS;判断一次性闹钟开启后，其余闹钟不响闹
	LDA		#(R_Alarm_Clock_State-RAM)
	CLC
	ADC		P_Temp
	TAX
	LDA		RAM,X
	CLC
	CLD
	LDA		Table_Judgement_Alarm_Clock+1,X
	PHA


Table_Judgement_Alarm_Clock:
	DW		L_JudgeMent_Alarm_Clock_State_Prog_Once-1
	DW		L_JudgeMent_Alarm_Clock_State_Prog_Every-1
	DW		L_JudgeMent_Alarm_Clock_State_Prog_Work_Day-1
	DW		L_JudgeMent_Alarm_Clock_State_Prog_Rest_Day-1

L_JudgeMent_Alarm_Clock_State_Prog_Once:
	LDA		P_Temp
	INC
	STA		R_Alarm_Beep
	LDA		#1
	STA		R_Alarm_Open_State
	JMP		L_Control_Beep_Open_Prog
L_JudgeMent_Alarm_Clock_State_Prog_Every:
	LDA		R_Alarm_Open_State
	BNE		L_Judgement_Alarm_Clock_5_RTS;如果闹钟开启状态不为零跳过


	LDA		P_Temp
	INC
	STA		R_Alarm_Beep
	
	LDA		#2
	STA		R_Alarm_Open_State
	JMP		L_Control_Beep_Open_Prog
L_JudgeMent_Alarm_Clock_State_Prog_Work_Day:
	LDA		R_Time_Week
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_Work_Day_RTS
	CMP		#6
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_Work_Day_RTS;
	LDA		P_Temp
	INC
	STA		R_Alarm_Beep
	LDA		#3
	STA		R_Alarm_Open_State
	JMP		L_Control_Beep_Open_Prog
L_JudgeMent_Alarm_Clock_State_Prog_Work_Day_RTS:
	RTS

L_JudgeMent_Alarm_Clock_State_Prog_Rest_Day:
	LDA		R_Time_Week
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_Rest_Day_Effictive	
	CMP		#6
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_Rest_Day_Effictive
	RTS

L_JudgeMent_Alarm_Clock_State_Prog_Rest_Day_Effictive:
	LDA		P_Temp
	INC
	STA		R_Alarm_Beep
	LDA		#4
	STA		R_Alarm_Open_State
L_Control_Beep_Open_Prog:
	LDA		#(R_Snz_Time-RAM)
	CLC
	ADC		P_Temp
	TAX
	LDA		RAM,X
	STA		R_Snz_Time_Last
	BBS4	Sys_Flag_D,L_Control_Beep_Open_Prog_Open_Beep
	JSR		L_Close_Timer_Beep_Prog

L_Control_Beep_Open_Prog_Open_Beep:
	LDA		#D_Beep_Open_Last_Time_Alarm
	STA		R_Close_Beep_Time
	JSR		L_Control_Beep_prog_Auto_Exit
	RTS























;==============================================
L_Update_Alarm_Clock_Min_Prog:
	LDX		#(R_Alarm_Clock_Min-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	JMP		L_Inc_To_60_Prog
;-----------------------------------------------
L_Update_Alarm_Clock_Hr_Prog:
	LDX		#(R_Alarm_Clock_Min-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#23H
	JMP		L_Inc_To_Any_Count_Prog
;-----------------------------------------------
L_Update_Alarm_Clock_Snz_Time_Prog:
	LDX		#(R_Snz_Time-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#30H
	JMP		L_Inc_To_Any_Count_Prog
;--------------------------------------------
L_Update_Alarm_Clock_State_Prog:
	LDX		#(R_Alarm_Clock_State-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#3H
	JMP		L_Inc_To_Any_Count_Prog
;===================================================
L_Update_Alarm_Clock_Min_Prog_DEC:
	LDX		#(R_Alarm_Clock_Min-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	JMP		L_Dec_To_60_Prog
;-----------------------------------------------
L_Update_Alarm_Clock_Hr_Prog_DEC:
	LDX		#(R_Alarm_Clock_Min-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#23H
	JMP		L_Dec_To_0_Prog
;-----------------------------------------------
L_Update_Alarm_Clock_Snz_Time_Prog_DEC:
	LDX		#(R_Snz_Time-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#30H
	JMP		L_Dec_To_0_Prog
;--------------------------------------------
L_Update_Alarm_Clock_State_Prog_DEC:
	LDX		#(R_Alarm_Clock_State-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#3H
	JMP		L_Dec_To_0_Prog
