L_Update_Timer_Sec_Prog:
    LDX     #(R_Timer_Sec-Time_Str_Addr)
    JMP     L_Inc_To_60_Prog
;----------------------------------------------------
L_Update_Timer_Min_Prog:
    LDX     #(R_Timer_Min-Time_Str_Addr)
    JMP     L_Inc_To_60_Prog
; ----------------------------------------------------
L_Update_Timer_Min_Prog_Desitive:
	LDX		#(R_Timer_Min_Countdown-Time_Str_Addr)
	JMP		L_Dec_To_60_Prog
;----------------------------------------------------
L_Update_Timer_Sec_Prog_Desitive:
	LDX		#(R_Timer_Sec_Countdown-Time_Str_Addr)
	JMP     L_Dec_To_60_Prog
;====================================================

L_Control_Timer_Prog
    BBS4    Sys_Flag_D,L_Timer_Prog_OUT
    BBR1    Sys_Flag_D,L_Timer_Prog_OU
    BBS1    Sys_Flag_D,L_Desitive_Timer



L_Positive_Timer:
    JSR     L_Update_Timer_Sec_Prog
    BCC     L_Timer_Prog_OUT
    JSR     L_Update_Timer_Min_Prog
    BCC     L_Timer_Prog_OUT
    LDA     #0
    STA     R_Timer_Min
    STA     R_Timer_Sec;记满重启计时
L_Timer_Prog_OUT:
    RTS    




;============================================================
L_Desitive_Timer:;倒计时
    JSR     L_Update_Timer_Sec_Prog_Desitive
    BCS     L_Desitive_Timer_RTS
    JSR     L_Update_Timer_Min_Prog_Desitive
    BCS     L_Desitive_Timer_RTS
    JSR     L_Scankey_Close_Alarm_Beep;如果此时存在闹铃闹钟，则执行关闭闹铃程序
L_Desitive_Timer_1:
    LDA     #0
    STA     R_Timer_Min
    STA     R_Timer_Sec
    SMB4    Sys_Flag_D
    LDA     #D_Beep_Open_Last_Time_Timer
    STA     R_Close_Beep_Time
    JSR     L_Control_Beep_prog_Auto_Exit
L_Desitive_Timer_RTS:
    RTS
