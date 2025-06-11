L_Display_Time_Prog:
	JSR		L_Display_Col_Time_Prog
	JSR		L_Display_Time_Min_Prog
	JSR		L_Display_Time_Hr_Prog
	JSR		L_Display_Time_Day_Prog
	JSR		L_Display_Time_Week_Prog
	JSR		L_Display_Time_Month_Prog
	JSR		L_Display_Time_Year_Prog
	LDA		Sys_Flag_F
	BEQ		L_Display_Time_Prog_RTS
	JSR		L_Display_Prog_Under_Time_Mode
L_Display_Time_Prog_RTS:
	RTS







L_Display_Time_Min_Prog:
	LDA		R_Time_Min
	AND		#0FH
	LDX		#lcd_d17
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Min
	AND		#F0H
	JSR		L_ROR_4Bit_Prog
	LDX		#lcd_d16
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
;==================================
L_Display_Time_Hr_Prog:
	LDA		R_Time_Hr
	JSR		L_12_24_Prog
	STA		P_Temp+6
	AND		#0FH
	LDX		#lcd_d15
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		P_Temp+6
	AND		#F0H
	JSR		L_ROR_4Bit_Prog
	LDX		#lcd_d14
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
;==================================
L_Display_Time_Day_Prog:
	LDA		R_Time_Day
	AND		#0FH
	LDX		#lcd_d5
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Day
	AND		#F0H
	JSR		L_ROR_4Bit_Prog
	LDX		#lcd_d4
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
;==================================	
L_Display_Time_Week_Prog:
	LDA		R_Time_Week
	LDX		#lcd_d6
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
;==================================
L_Display_Time_Month_Prog:
	LDA		R_Time_Month
	AND		#0FH
	LDX		#lcd_d3
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Month
	AND		#F0H
	BEQ		L_Display_Time_Month_Prog_1
	JSR		L_ROR_4Bit_Prog
	LDX		#lcd_T6
	JSR		F_ClrpSymbol
	RTS
L_Display_Time_Month_Prog_1:
	LDX		#lcd_T6
	JSR		F_DispSymbol
	LDX		#lcd_T7
	JSR		F_DispSymbol
	RTS
;==================================	
L_Display_Time_Year_Prog:
	LDA		R_Time_Year
	AND		#0FH
	LDX		#lcd_d2
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Year
	AND		#F0H
	JSR		L_ROR_4Bit_Prog
	LDX		#lcd_d1
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
