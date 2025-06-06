L_Konb_Control_Change_Prog:
    LDA     R_Mode
    BEQ     L_Konb_Control_Change_Prog_Timer_Clock
    JMP     L_Konb_Control_Alarm_Prog

L_Konb_Control_Change_Prog_Timer_Clock:
    BBS3    Sys_Flag_A,L_Konb_Control_Change_Prog_Clock;在初始情况下，设置模式只存在于60
    BBS1    Sys_Flag_D,?RTS_1           ;当计时运行时，编码器无效
    LDA     #0
    STA     R_Timer_Sec
    STA     Sys_Flag_D                  ;清空标志位和计时器秒数
    BBS0    Sys_Flag_E,L_Konb_Control_Timer_Fanl;判断正反转标志
    JSR     L_Update_Timer_Min_Prog
    JSR     L_Display_Prog_Timer
    LDA     R_Timer_Min
    STA     R_Timer_Min_Backup
    RTS
L_Konb_Control_Timer_Fan:
    JSR     L_Update_Timer_Min_Prog_Desitive
    JSR     L_Display_Prog_Timer
    LDA     R_Timer_Min
    STA     R_Timer_Min_Backup
?RTS_1:
    RTS
;=================================================================
L_Konb_Control_Change_Prog_Clock:
    LDA     R_Mode_Set
    CMP     #1
    BNE     L_Konb_Control_Change_Prog_Clock_1;判断当前是不是处于时间设置的分钟设置模块
    LDA     #0
    STA     R_Time_Sec;是的话清空秒数
L_Konb_Control_Change_Prog_Clock_1:
    JSR     L_Konb_Control_Change_Prog_Clock_Zheng
    JSR     L_Auto_Counter_Week
    JSR     L_Display_Prog_Mode
    RTS


L_Konb_Control_Change_Prog_Clock_Zheng:    

    BBS0    Sys_Flag_E,L_Konb_Control_Change_Prog_Clock_Fan
    LDA     R_Mode_Set
    CLC
    CLD
    ROL
    TAX
    LDA     Table_Clock_Set_Zheng+1,X
    PHA
    LDA     Table_Clock_Set_Zheng,X
    PHA
    RTS
Table_Clock_Set_Zheng:
    DW      L_Update_Time_Hr_Prog-1
    DW      L_Update_Time_Min_Prog-1
    DW      L_Update_Time_Day_Prog-1
    DW      L_Update_Time_Month_Prog-1
    DW      L_Update_Time_Year_Prog-1
L_Konb_Control_Change_Prog_Clock_Fan:
    LDA     R_Mode_Set
    CLC
    CLD
    ROL
    TAX
    LDA     Table_Clock_Set_Fan+1,X
    PHA
    LDA     Table_Clock_Set_Fan,X
    PHA
    RTS
Table_Clock_Set_Fan:
    DW      L_Update_Time_Hr_Prog_DEC-1
    DW      L_Update_Time_Min_Prog_DEC-1
    DW      L_Update_Time_Day_Prog_DEC-1
    DW      L_Update_Time_Month_Prog_DEC-1
    DW      L_Update_Time_Year_Prog_DEC-1


L_Konb_Control_Alarm_Prog:
    JSR     L_Konb_Control_Alarm_Prog_Zheng
    JSR     L_Display_Set_Mode_Prog
    rtsq
L_Konb_Control_Alarm_Prog_Zheng:
    BBS0    Sys_Flag_E,L_Konb_Control_Alarm_Prog_Fan
    LDA     R_Mode_Set
    CLC
    CLD
    ROL
    TAX
    LDA     Table_Alarm_Clock_Set+1,X
    PHA
    LDA     Table_Alarm_Clock_Set,X
    PHA
    RTS
Table_Alarm_Clock_Set:
    DW      L_Update_Alarm_Clock_Hr_Prog-1
    DW      L_Update_Alarm_Clock_Min_Prog-1
    DW      L_Update_Alarm_Clock_Snz_Time_Prog-1
    DW      L_Update_Alarm_Clock_State_Prog-1


L_Konb_Control_Alarm_Prog_Fan:
    LDA     R_Mode_Set
    CLC
    CLD
    ROL
    TAX
    LDA     Table_Alarm_Clock_Set_Fan+1,X
    PHA
    LDA     Table_Alarm_Clock_Set_Fan,X
    PHA
    RTS
Table_Alarm_Clock_Set_Fan:
    DW      L_Update_Alarm_Clock_Hr_Prog_DEC-1
    DW      L_Update_Alarm_Clock_Min_Prog_DEC-1
    DW      L_Update_Alarm_Clock_Snz_Time_Prog_DEC-1
    DW      L_Update_Alarm_Clock_State_Prog_DEC-1
