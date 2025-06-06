L_Alarm_Prog:;闹钟判断的时间是贪睡闹钟时间，而正常闹钟时间作为显示闹钟时间
	LDA		R_Time_Sec
	BNE		L_Alarm_Prog_OUT
	LDA		R_Alarm_Open
	BEQ		L_Alarm_Prog_OUT;一分钟扫描一次，判断闹钟是否开启
	JSR		L_Judgement_Alarm_Clock_1



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
	BBS1	R_Alarm_Open,L_Judgement_Alarm_Clock_4_RTS
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
	BBS1	R_Alarm_Open,L_Judgement_Alarm_Clock_5_RTS
	LDA		R_Alarm_Clock_Hr+4
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_5_RTS
	LDA		R_Alarm_Clock_Min+4
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_5_RTS
	
L_Judgement_Alarm_Clock_5_RTS:
	RTS




L_JudgeMent_Alarm_Clock_State_Prog:
	LDA		P_Temp+1
	DEC
	STA		P_Temp
	LDA		#(R_Alarm_Clock_State-Time_Str_Addr)
	CLC
	ADC		P_Temp
	TAX
	LDA		Time_Str_Addr,X
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_Once;判断是不是一次性闹钟
	CMP		#1
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_Every
	CMP		#2
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_WorkDay
	CMP		#3
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_Weekends

L_JudgeMent_Alarm_Clock_State_Prog_Once:
	LDA		P_Temp


L_JudgeMent_Alarm_Clock_State_Prog_WorkDay:
	LDA		R_Time_Week
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_WorkDay_RTS
	CMP		#6
	BEQ		L_JudgeMent_Alarm_Clock_State_Prog_WorkDay_RTS

	JSR		L_Control_Alarm_Beep_Prog
L_JudgeMent_Alarm_Clock_State_Prog_WorkDay_RTS:
	RTS


L_JudgeMent_Alarm_Clock_State_Prog_Weekends:
	LDA		R_Time_Week






































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
	JMP		L_DEC_To_60_Prog
;-----------------------------------------------
L_Update_Alarm_Clock_Hr_Prog_DEC:
	LDX		#(R_Alarm_Clock_Min-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#23H
	JMP		L_DEC_To_Any_Count_Prog
;-----------------------------------------------
L_Update_Alarm_Clock_Snz_Time_Prog_DEC:
	LDX		#(R_Snz_Time-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#30H
	JMP		L_DEC_To_Any_Count_Prog
;--------------------------------------------
L_Update_Alarm_Clock_State_Prog_DEC:
	LDX		#(R_Alarm_Clock_State-Time_Str_Addr)
	TXA
	CLC
	ADC		R_Mode
	DEC
	TAX
	LDA		#3H
	JMP		L_DEC_To_Any_Count_Prog
