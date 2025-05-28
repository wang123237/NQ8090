L_Display_Time_Min_Prog:
	LDA		R_Time_Min
	AND		#0FH
	LDX		#lcd_d4
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Min
	AND		#F0H
	LDX		#lcd_d3
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
;==================================
L_Display_Time_Hr_Prog:
	LDA		R_Time_Hr
	JSR		L_12_24_Prog
	AND		#0FH
	LDX		#lcd_d2
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Hr
	AND		#F0H
	LDX		#lcd_d1
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
;==================================
L_Display_Time_Day_Prog:
	LDA		R_Time_Day
	AND		#0FH
	LDX		#lcd_d15
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Day
	AND		#F0H
	LDX		#lcd_d14
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
;==================================
L_Display_Time_Month_Prog:
	LDA		R_Time_Month
	AND		#0FH
	LDX		#lcd_d2
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Month
	AND		#F0H
	LDX		#lcd_d1
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS
;==================================	
L_Display_Time_Month_Prog:
	LDA		R_Time_Month
	AND		#0FH
	LDX		#lcd_d2
	JSR		L_Dis_8Bit_DigitDot_Prog
	LDA		R_Time_Month
	AND		#F0H
	LDX		#lcd_d1
	JSR		L_Dis_8Bit_DigitDot_Prog
	RTS