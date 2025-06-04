L_Alarm_Prog:;闹钟判断的时间是贪睡闹钟时间，而正常闹钟时间作为显示闹钟时间
	LDA		R_Time_Sec
	BNE		L_Alarm_Prog_OUT
	JSR		L_Judgement_Alarm_Clock_Prog_1
	JSR		L_Judgement_Alarm_Clock_Prog_2
	JSR		L_Judgement_Alarm_Clock_Prog_3
	JSR		L_Judgement_Alarm_Clock_Prog_4
	JSR		L_Judgement_Alarm_Clock_Prog_5
	RTS























;-----------------------------------------
L_Judgement_Alarm_Clock_Prog_1:
	LDA		R_Alarm_Clock_Mode
	BNE		L_Judgement_Alarm_Clock_Prog_1_RTS
	STA		P_Temp
	LDA		R_Alarm_Clock_Hr
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_Prog_1_RTS
	LDA		R_Alarm_Clock_Min
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_Prog_1_RTS
	JSR		L_Control_Alarm_Clock_Prog
L_Judgement_Alarm_Clock_Prog_1_RTS:
	RTS
;-----------------------------------------
L_Judgement_Alarm_Clock_Prog_2:
	LDA		R_Alarm_Clock_Mode+1
	BNE		L_Judgement_Alarm_Clock_Prog_2_RTS
	STA		P_Temp
	LDA		R_Alarm_Clock_Hr+1
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_Prog_2_RTS
	LDA		R_Alarm_Clock_Min+1
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_Prog_2_RTS
	JSR		L_Control_Alarm_Clock_Prog
L_Judgement_Alarm_Clock_Prog_2_RTS:
	RTS
;-----------------------------------------
L_Judgement_Alarm_Clock_Prog_3:
	LDA		R_Alarm_Clock_Mode+2
	BNE		L_Judgement_Alarm_Clock_Prog_3_RTS
	STA		P_Temp
	LDA		R_Alarm_Clock_Hr+2
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_Prog_3_RTS
	LDA		R_Alarm_Clock_Min+2
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_Prog_3_RTS
	JSR		L_Control_Alarm_Clock_Prog
L_Judgement_Alarm_Clock_Prog_3_RTS:
	RTS
;-----------------------------------------
L_Judgement_Alarm_Clock_Prog_4:
	LDA		R_Alarm_Clock_Mode+3
	BNE		L_Judgement_Alarm_Clock_Prog_4_RTS
	STA		P_Temp
	LDA		R_Alarm_Clock_Hr+3
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_Prog_4_RTS
	LDA		R_Alarm_Clock_Min+3
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_Prog_4_RTS
	JSR		L_Control_Alarm_Clock_Prog
L_Judgement_Alarm_Clock_Prog_4_RTS:
	RTS
;-----------------------------------------
L_Judgement_Alarm_Clock_Prog_5:
	LDA		R_Alarm_Clock_Mode+4
	BNE		L_Judgement_Alarm_Clock_Prog_5_RTS
	STA		P_Temp
	LDA		R_Alarm_Clock_Hr+4
	CMP		R_Time_Hr
	BNE		L_Judgement_Alarm_Clock_Prog_5_RTS
	LDA		R_Alarm_Clock_Min+4
	CMP		R_Time_Min
	BNE		L_Judgement_Alarm_Clock_Prog_5_RTS
	JSR		L_Control_Alarm_Clock_Prog
L_Judgement_Alarm_Clock_Prog_5_RTS:
	RTS

