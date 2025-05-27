
;===============================================

L_Display_Time_Sec_Prog:
	LDA		R_Time_Sec
	JMP		L_Display_lcd_Prog_Normal_Sec
;======================================
L_Display_Time_Min_Prog:
	LDA		R_Time_Min
	JMP		L_Display_lcd_Prog_Normal_Min
;=====================================
L_Display_Time_Hr_Prog:
	LDA		R_Time_Hr
	JMP		L_Display_lcd_Prog_Normal_Hr
;=====================================
L_Display_Time_Day_Prog:
	LDA		R_Time_Day
	JMP		L_Display_lcd_Prog_Normal_Day
;=====================================
L_Display_Time_Month_Prog:
	LDA		R_Time_Month
	JMP		L_Display_lcd_Prog_Normal_Month
;========================================
L_Display_Time_Year_Prog:
	LDA		R_Time_Year
	JMP		L_Display_lcd_Prog_Normal_Timer

;============================================
L_Display_Time_Week_Prog:;两位显示数字的
	