L_Display_Normal_Prog:
    BBS3    Sys_Flag_A,L_Display_Prog
    LDA     R_Mode
    BNE     L_Display_Normal_Prog_Judgemeut_Timer
    JSR     L_Display_Col_Time_Prog
    LDA     R_Time_Sec
    BNE     L_Display_Normal_Prog_Judgemeut_Timer

    JSR     L_Display_Time_Min_Prog

    LDA     R_Timer_Min
    BNE     L_Display_Normal_Prog_Judgemeut_Timer
    JSR     L_Display_Time_Hr_Prog

    LDA     R_Time_Hr
    BNE     L_Display_Normal_Prog_Judgemeut_Timer
    JSR		L_Display_Time_Day_Prog
	JSR		L_Display_Time_Week_Prog
	JSR		L_Display_Time_Month_Prog
	JSR		L_Display_Time_Year_Prog
L_Display_Normal_Prog_Judgemeut_Timer:
    BBR1    Sys_Flag_D,L_Display_Normal_Prog_RTS;判断即使是否开始
    BBS0    Sys_Flag_D,L_Display_Normal_Desitive_Prog
    JSR     L_Display_Timer_Sec_Prog
    LDA     R_Timer_Sec
    BNE     L_Display_Normal_Prog_RTS
    JSR     L_Display_Timer_Min_Prog
    RTS


L_Display_Normal_Desitive_Prog:
    JSR     L_Display_Timer_Sec_Prog
    LDA     R_Timer_Sec
    CMP     #59H
    BCS     L_Display_Normal_Prog_RTS
    JSR     L_Display_Timer_Min_Prog

L_Display_Normal_Prog_RTS:
    RTS












L_Display_Prog:
    LDA     R_Mode
    BEQ     L_Display_Prog_Time_To
    JMP     L_Display_Alarm_Prog
L_Display_Prog_Time_To:
    JMP     L_Display_Time_Prog


L_Clr_Alarm_Prog:
    JSR     L_Clr_lcd_Alarm_Clock_Prog_1
    JSR     L_Clr_lcd_Alarm_Clock_Prog_2
    JSR     L_Clr_lcd_Alarm_Clock_Prog_3
    JSR     L_Clr_lcd_Alarm_Clock_Prog_5
    JSR     L_Clr_lcd_Alarm_Clock_Prog_4
    JSR     L_Clr_lcd_X10_Prog
    JSR     L_Clr_lcd_X11_Prog
    JSR     L_Clr_lcd_X12_Prog
    JSR     L_Clr_lcd_X13_Prog
    RTS
    