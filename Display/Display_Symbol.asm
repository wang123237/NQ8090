L_Display_Beep_Sclient_Prog:
    BBS6    Sys_Flag_C,L_Display_Beep_Voice_Prog
    LDX     #lcd_Sclient
    JSR     F_ClrpSymbol
    LDX     #lcd_Voice
    JSR     F_DispSymbol
    RTS
L_Display_Beep_Voice_Prog:
    LDX     #lcd_Sclient
    JSR     F_DispSymbol
    LDX     #lcd_Voice
    JSR     F_ClrpSymbol
    RTS
;==========================================
L_Display_Temp_Prog:
    LDA     R_Temperature_L
    BNE     L_Display_Temp_Prog_under_0
    LDA     R_Temperature
    AND     #0FH
    LDX     #lcd_d8
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA     R_Temperature
    AND     #F0H
    JSR		L_ROR_4Bit_Prog
    LDX     #lcd_d7
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS

L_Display_Temp_Prog_under_0:
    LDA     R_Temperature
    AND     #0FH
    LDX     #lcd_d8
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA     #11
    LDX     #lcd_d7
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS
;================================================
L_Display_Prog_Init:
    LDX     #lcd_Week
    JSR     F_DispSymbol
    LDX     #lcd_T1
    JSR     F_DispSymbol
    LDX     #lcd_T8
    JSR     F_DispSymbol
    LDX     #lcd_C
    JSR     F_DispSymbol
    LDX     #lcd_P2
    JSR     F_DispSymbol
    RTS
;==============================================
L_Display_Col_Time_Prog:
    LDX     #lcd_P1
    JSR     F_DispSymbol
    RTS
L_Display_Col_Timer_Prog:
    LDX     #lcd_P2
    JSR     F_DispSymbol
    RTS
L_Display_Timer_Symbol_Prog:
    LDX     #lcd_P3
    JSR     F_DispSymbol
    RTS
L_Clr_Col_Time_Prog:
    LDX     #lcd_P1
    JSR     F_ClrpSymbol
    RTS
L_Clr_Col_Timer_Prog:
    LDX     #lcd_P2
    JSR     F_ClrpSymbol
    RTS
L_Clr_Timer_Symbol_Prog:
    LDX     #lcd_P3
    JSR     F_ClrpSymbol
    RTS
;-----------------------------------------------
L_Display_lcd_Alarm_Clock_Prog_1:
    LDX     #lcd_Alarm_Clock_1
    JSR     F_DispSymbol
    RTS
L_Display_lcd_Alarm_Clock_Prog_2:
    LDX     #lcd_Alarm_Clock_2
    JSR     F_DispSymbol
    RTS
L_Display_lcd_Alarm_Clock_Prog_3:
    LDX     #lcd_Alarm_Clock_3
    JSR     F_DispSymbol
    RTS
L_Display_lcd_Alarm_Clock_Prog_4:
    LDX     #lcd_Alarm_Clock_4
    JSR     F_DispSymbol
    RTS
L_Display_lcd_Alarm_Clock_Prog_5:
    LDX     #lcd_Alarm_Clock_5
    JSR     F_DispSymbol
    RTS
;---------------------------------------
L_Display_lcd_X10_Prog:
    LDX     #lcd_X10
    JSR     F_DispSymbol
    RTS
L_Display_lcd_X11_Prog:
    LDX     #lcd_X11
    JSR     F_DispSymbol
    RTS
L_Display_lcd_X12_Prog:
    LDX     #lcd_X12
    JSR     F_DispSymbol
    RTS
L_Display_lcd_X13_Prog:
    LDX     #lcd_X13
    JSR     F_DispSymbol
    RTS
;============================================
L_Display_AM_Prog:
    LDX     #lcd_AM
    JSR     F_DispSymbol
    RTS
L_Display_PM_Prog:
    LDX     #lcd_PM
    JSR     F_DispSymbol
    RTS    
L_Clr_AM_Prog:
    LDX     #lcd_AM
    JSR     F_ClrpSymbol
    RTS
L_Clr_PM_Prog:
    LDX     #lcd_PM
    JSR     F_ClrpSymbol
    RTS   
;================================= 
L_Clr_lcd_Alarm_Clock_Prog_1:
    LDX     #lcd_Alarm_Clock_1
    JSR     F_ClrpSymbol
    RTS
L_Clr_lcd_Alarm_Clock_Prog_2:
    LDX     #lcd_Alarm_Clock_2
    JSR     F_ClrpSymbol
    RTS
L_Clr_lcd_Alarm_Clock_Prog_3:
    LDX     #lcd_Alarm_Clock_3
    JSR     F_ClrpSymbol
    RTS
L_Clr_lcd_Alarm_Clock_Prog_4:
    LDX     #lcd_Alarm_Clock_4
    JSR     F_ClrpSymbol
    RTS
L_Clr_lcd_Alarm_Clock_Prog_5:
    LDX     #lcd_Alarm_Clock_5
    JSR     F_ClrpSymbol
    RTS
;---------------------------------------
L_Clr_lcd_X10_Prog:
    LDX     #lcd_X10
    JSR     F_ClrpSymbol
    RTS
L_Clr_lcd_X11_Prog:
    LDX     #lcd_X11
    JSR     F_ClrpSymbol
    RTS
L_Clr_lcd_X12_Prog:
    LDX     #lcd_X12
    JSR     F_ClrpSymbol
    RTS
L_Clr_lcd_X13_Prog:
    LDX     #lcd_X13
    JSR     F_ClrpSymbol
    RTS