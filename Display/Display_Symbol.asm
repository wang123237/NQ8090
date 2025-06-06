L_Display_Beep_Sclient_Prog:
    BBS6    Sys_Flag_C,L_Display_Beep_Voice_Prog
    LDX     #lcd_Sclient
    JSR     F_ClrpSymbol
    LDX     #lcd_Voice_Prog
    JSR     F_DispSymbol
    RTS
L_Display_Beep_Voice_Prog:
    LDX     #lcd_Sclient
    JSR     F_DispSymbol
    LDX     #lcd_Voice_Prog
    JSR     F_ClrpSymbol
    RTS