L_Timer_Clock_Prog:
    LDA     P_Scankey_value
    CMP     #D_KNOB_Press
    BEQ     L_Control_Timer_ST_SP_Prog
    CMP     #D_Voice_Press
    BEQ     L_Control_Beep_Silence_Prog
    CMP     L_Timer_Clock_Prog
    BEQ     L_Timer_Clock_Prog_RTS
    SMB5    Sys_Flag_A    
L_Timer_Clock_Prog_RTS:
    RTS
;===================================================
L_Control_Beep_Silence_Prog:
    BBS6    Sys_Flag_D,L_Control_Beep_Silence
    JSR     L_Display_Beep_Sclient_Prog
    RTS
L_Control_Beep_Silence:
    RMB6    Sys_Flag_D
    JSR     L_Display_Beep_Sclient_Prog
    RTS

;==================================================


L_Control_Timer_ST_SP_Prog:
    BBS1    Sys_Flag_D,L_Control_Timer_SP_Prog
    SMB1    Sys_Flag_D
    BBS2    Sys_Flag_D,L_Control_Timer_ST_SP_Prog_RTS
    SMB2    Sys_Flag_D
    RMB0    Sys_Flag_D
    LDA     R_Timer_Min_Backup
    ORA     R_Timer_Sec_Backup
    BEQ     L_Control_Timer_ST_SP_Prog_RTS
    SMB0    Sys_Flag_D
    JSR     L_Control_Timer_TurnPlate
    RTS
L_Control_Timer_SP_Prog:
    RMB1    Sys_Flag_D
L_Control_Timer_ST_SP_Prog_RTS:
    RTS


L_Control_Timer_TurnPlate:
    LDA     #0
    STA     Timer_TurnPlate_Min
    STA     Timer_TurnPlate_Sec;清除12个轮盘每一个轮盘所代表的时间
    STA     Timer_TurnPlate_Min_Backup
    STA     Timer_TurnPlate_Sec_Backup
    LDA     #12
    STA     Timer_TurnPlate_Frequeny
    LDA     R_Timer_Min_Backup
    STA     P_Temp
    SED
L_Control_Timer_TurnPlate_Min_Loop:
    LDA     P_Temp
    CMP     #6
    BCC     L_Control_Timer_TurnPlate_Sec
    SEC
    SBC     #6
    STA     P_Temp
    INC     Timer_TurnPlate_Min
    BRA     L_Control_Timer_TurnPlate_Min_Loop;循环减6，减1个6代表一个转盘的时间加1分钟
L_Control_Timer_TurnPlate_Sec:
    LDX     P_Temp
    LDA     Table_TurnPlate_Sec,X
    STA     Timer_TurnPlate_Sec
    ClD
    RTS                                         ;查表得到对应转盘秒数
Timer_TurnPlate_Sec:
    .DB     00H
    .DB     12H
    .DB     24H
    .DB     36H
    .DB     48H