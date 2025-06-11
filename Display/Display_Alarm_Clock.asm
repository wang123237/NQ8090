L_Display_Alarm_Prog:
    JSR     L_Display_Alarm_Clock_Mode_Prog;显示5个闹钟的标识
    LDA     R_Mode
    CMP     #1
    BEQ     L_Display_Alarm_Prog_1
    CMP     #2
    BEQ     L_Display_Alarm_Prog_2
    CMP     #3
    BEQ     L_Display_Alarm_Prog_3
    CMP     #4
    BEQ     L_Display_Alarm_Prog_4
    RTS

L_Display_Alarm_Prog_4:
    CLC
    ROR
L_Display_Alarm_Prog_3:
    CLC
    ROR
L_Display_Alarm_Prog_2:
    CLC
    ROR
L_Display_Alarm_Prog_1:
    CLC
    ROR
    BCS     L_Display_Alarm_Clock_Usually_Prog
    JSR     L_Display_Alarm_Clock_OFF_Prog
L_Display_Alarm_Clock_Usually_Prog:
    JSR     L_Display_Alarm_Clock_Min_Prog
    JSR     L_Display_Alarm_Clock_Hr_Prog
    JSR     L_Display_Alarm_Clock_State_Prog
    RTS







;=====================================================
L_Display_Alarm_Clock_OFF_Prog:
    JSR     L_Clr_Col_Time_Prog
    LDX     #lcd_d17
    LDA     #19
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDX     #lcd_d16
    LDA     #19
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDX     #lcd_d15
    LDA     #0
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDX     #lcd_d14
    LDA     #10
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS
;======================================================
L_Display_Alarm_Clock_Min_Prog:
    LDA     R_Mode
    DEC     
    STA     P_Temp
    LDX     #(R_Alarm_Clock_Min-RAM)
    TXA
    CLC
    ADC     P_Temp
    TXA
    LDA     RAM,X
    STA     P_Temp+6
    AND     #0FH
    LDX     #lcd_d17
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA     P_Temp+6
    AND     #F0H
    JSR		L_ROR_4Bit_Prog
    LDX     #lcd_d16   
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS
;-----------------------------------------
L_Display_Alarm_Clock_Hr_Prog:
    LDA     R_Mode
    DEC     
    STA     P_Temp
    LDX     #(R_Alarm_Clock_Hr-RAM)
    TXA
    CLC
    ADC     P_Temp
    TXA
    LDA     RAM,X
    JSR     L_12_24_Prog
    STA     P_Temp+6

    AND     #0FH
    LDX     #lcd_d15
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA     P_Temp+6
    AND     #F0H
    BNE     L_Display_Alarm_Clock_Hr_Prog_1
    LDA     #A0H
L_Display_Alarm_Clock_Hr_Prog_1:
    JSR		L_ROR_4Bit_Prog
    LDX     #lcd_d14   
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS
;---------------------------------------
L_Display_Alarm_Clock_Snz_Time_Prog:
    LDA     R_Mode
    DEC     
    STA     P_Temp
    LDX     #(R_Snz_Time-RAM)
    TXA
    CLC
    ADC     P_Temp
    TXA
    LDA     RAM,X
    STA     P_Temp+6
    AND     #0FH
    LDX     #lcd_d17
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA     P_Temp+6
    AND     #F0H
    JSR		L_ROR_4Bit_Prog
    LDX     #lcd_d16   
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS
;--------------------------------------
L_Display_Alarm_Clock_State_Prog:
    LDA     R_Mode
L_Display_Alarm_Clock_State_Prog_Usually:
    DEC     
    STA     P_Temp
    LDX     #(R_Alarm_Clock_State-RAM)
    TXA
    CLC
    ADC     P_Temp
    TXA
    LDA     RAM,X
    CLC
    CLD
    ROL
    TAX
    LDA     Table_Alarm_Clock_State+1,X
    PHA
    LDA     Table_Alarm_Clock_State,X
    PHA
    RTS
Table_Alarm_Clock_State:
    DW      L_Display_lcd_X10_Prog-1
    DW      L_Display_lcd_X11_Prog-1
    DW      L_Display_lcd_X12_Prog-1
    DW      L_Display_lcd_X13_Prog-1
;================================================
L_Display_Alarm_Clock_Mode_Prog:
    LDA     R_Mode
    DEC
    CLC
    CLD
    ROL
    TAX
    LDA     Table_Alarm_Clock+1,X
    PHA
    LDA     Table_Alarm_Clock,X
    PHA
    RTS
Table_Alarm_Clock:
    DW      L_Display_lcd_Alarm_Clock_Prog_1-1
    DW      L_Display_lcd_Alarm_Clock_Prog_2-1        
    DW      L_Display_lcd_Alarm_Clock_Prog_3-1        
    DW      L_Display_lcd_Alarm_Clock_Prog_4-1        
    DW      L_Display_lcd_Alarm_Clock_Prog_5-1        
        
;=================================================
L_Display_Prog_Under_Time_Mode:
    JSR   L_Display_Prog_Under_Time_Mode_1
    JSR   L_Display_Prog_Under_Time_Mode_2
    JSR   L_Display_Prog_Under_Time_Mode_3
    JSR   L_Display_Prog_Under_Time_Mode_4
    JSR   L_Display_Prog_Under_Time_Mode_5
    RTS
;---------------------------------------------
L_Display_Prog_Under_Time_Mode_1:
    LDA     Sys_Flag_F
    CLC
    ROR
    BCC     L_Display_Prog_Under_Time_Mode_1_RTS
    JSR     L_Display_lcd_Alarm_Clock_Prog_1
    LDA     #1
    JSR     L_Display_Alarm_Clock_State_Prog_Usually
L_Display_Prog_Under_Time_Mode_1_RTS:
    RTS
;---------------------------------------------
L_Display_Prog_Under_Time_Mode_2:
    LDA     Sys_Flag_F
    CLC
    ROR
    ROR
    BCC     L_Display_Prog_Under_Time_Mode_2_RTS
    JSR     L_Display_lcd_Alarm_Clock_Prog_2
    LDA     #2
    JSR     L_Display_Alarm_Clock_State_Prog_Usually
L_Display_Prog_Under_Time_Mode_2_RTS:
    RTS
;---------------------------------------------
L_Display_Prog_Under_Time_Mode_3:
    LDA     Sys_Flag_F
    CLC
    ROR
    ROR
    ROR
    BCC     L_Display_Prog_Under_Time_Mode_3_RTS
    JSR     L_Display_lcd_Alarm_Clock_Prog_3
    LDA     #3
    JSR     L_Display_Alarm_Clock_State_Prog_Usually
L_Display_Prog_Under_Time_Mode_3_RTS:
    RTS
;---------------------------------------------
L_Display_Prog_Under_Time_Mode_4:
    LDA     Sys_Flag_F
    CLC
    ROR
    ROR
    ROR
    ROR
    BCC     L_Display_Prog_Under_Time_Mode_4_RTS
    JSR     L_Display_lcd_Alarm_Clock_Prog_4
    LDA     #4
    JSR     L_Display_Alarm_Clock_State_Prog_Usually
L_Display_Prog_Under_Time_Mode_4_RTS:
    RTS
;---------------------------------------------
L_Display_Prog_Under_Time_Mode_5:
    LDA     Sys_Flag_F
    CLC
    ROR
    ROR
    ROR
    ROR
    ROR
    BCC     L_Display_Prog_Under_Time_Mode_5_RTS
    JSR     L_Display_lcd_Alarm_Clock_Prog_5
    LDA     #4
    JSR     L_Display_Alarm_Clock_State_Prog_Usually
L_Display_Prog_Under_Time_Mode_5_RTS:
    RTS