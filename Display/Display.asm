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
    