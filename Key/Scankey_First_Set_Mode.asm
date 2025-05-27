L_Scankey_Set_Mode_First_Press_Prog:
    SMB5    Sys_Flag_A
    LDA     P_Scankey_value
    CMP     #D_Mode_Press
    BEQ     L_Scankey_Set_Mode_Mode_First_Press_Prog
    CMP     #D_Set_Press
    BEQ     L_Scankey_Set_Mode_Set_Press_First_Press_Prog
    JSR     L_Scankey_Set_Mode_First_Press_Prog_1
    JSR     L_Display_Set_Mode_Prog
    RTS

L_Scankey_Set_Mode_First_Press_Prog_1:
    CLD
    CLC
    LDA     R_Mode
    ROL
    TAX
    LDA     Table_Set_Mode_1+1,X
    PHA
    LDA     Table_Set_Mode_1,X
    PHA
L_Scankey_Set_Mode_First_Press_Prog_RTS:
    RTS
Table_Set_Mode_1:
    DW      L_Scankey_Set_Mode_Prog_Clock-1
    DW      L_Scankey_Set_Mode_First_Press_Prog_RTS-1
    DW      L_Scankey_Set_Mode_Prog_Alarm_Clock-1
    DW      L_Scankey_Set_Mode_Prog_Another_Time-1
    DW      L_Scankey_Set_Mode_First_Press_Prog_RTS-1
;==========================================
;设置模式下，按下mode键更换设置的情况
L_Scankey_Set_Mode_Mode_First_Press_Prog:
    SMB5    Sys_Flag_A
    LDA     R_Mode
    CMP     #1
    BEQ     L_Control_Key_Voice_Prog
    CMP     #4
    BEQ     L_Scankey_Set_Mode_Mode_First_Press_Prog_OUT
    TAX
    LDA     Table_Set_Mode,X
    STA     P_Temp
    LDA     R_Mode_Set
    CMP     P_Temp
    BCS     L_Scankey_Set_Mode_Mode_First_Press_Prog_1
    LDA     R_Mode_Set
    ADC     #1
    STA     R_Mode_Set
    JSR     L_Display_Set_Mode_Prog
L_Scankey_Set_Mode_Mode_First_Press_Prog_OUT:
    RTS

L_Scankey_Set_Mode_Mode_First_Press_Prog_1:
    LDA     #0
    STA     R_Mode_Set
    LDA     R_Mode
    BNE     L_Scankey_Set_Mode_Mode_First_Press_Prog_2
    JSR     L_Clr_All_DisRam_Prog     
L_Scankey_Set_Mode_Mode_First_Press_Prog_2:
    JSR     L_Display_Prog


L_Control_Key_Voice_Prog:
    BBS5    Sys_Flag_C,L_Control_Key_Voice_Prog_Close
    SMB5    Sys_Flag_C
    RTS
L_Control_Key_Voice_Prog_Close:
    RMB5    Sys_Flag_C
    RTS

Table_Set_Mode:
    DB      10
    DB      0
    DB      3
    DB      3
    DB      0

;============================================
;设置模式下按下Set键，退出设置
;=============================================
L_Scankey_Set_Mode_Set_Press_First_Press_Prog:
    RMB3    Sys_Flag_A
    LDA     #0
    STA     R_Mode_Set
    LDA     R_Mode
    BEQ     L_Scankey_Set_Mode_Set_Press_First_Press_Prog_Time
    CMP     #2
    BNE     L_Scankey_Set_Mode_Set_Press_First_Press_Prog_1
    LDA     #1
    STA     R_Alarm_Mode
L_Scankey_Set_Mode_Set_Press_First_Press_Prog_1    
    JSR     L_Clr_All_DisRam_Prog
    JSR     L_Display_Prog

    RTS
L_Scankey_Set_Mode_Set_Press_First_Press_Prog_Time:
    JSR     L_Check_LeapYear_Prog
    JSR     L_Check_MaxDay_Prog
    CMP     R_Time_Day
    BCS     L_Scankey_Set_Mode_Set_Press_First_Press_Prog_Time_1
    JSR     L_Update_Time_Month_Prog
    LDA     #1
    STA     R_Time_Day
    LDA     #0
    STA     R_Dis_Date_Time
L_Scankey_Set_Mode_Set_Press_First_Press_Prog_Time_1:
    JSR     L_Auto_Counter_Week
    JSR     L_Clr_All_DisRam_Prog
    JSR     L_Display_Prog
    RTS



;设置模式下的通用函数;(闹钟和第二时间可以使用)
;======================================
;入口A寄存器存储最大值（16进制），X寄存器存储偏移值
;适用于时间的分钟，24小时制是的小时，分钟
;P_Temp+4存储最大值,P_Temp+5存储按键读到的值，P_Temp+3读到的被改变的值
;P_Temp+6存储读到的被改变的值的高四位
;=======================================
L_Scankey_Input_Set_Mode_Usally:
    STA     P_Temp+4
    LDA     Time_Addr,X
    JSR     L_A_HexToHexD
    STA     P_Temp+3
    JSR     L_Scankey_Input_Press
    BBS2    Sys_Flag_C,L_Scankey_Input_Set_Mode_Usally_Low_Bit_RTS;判断按键是否无效，如果是退出，不是继续
    STA     P_Temp+5                                              ;将读取到的按键输入值存储到P_Temp+5中
    BBR0    R_Mode_Set,L_Scankey_Input_Set_Mode_Usally_High_Bit   ;根据R_Mode_Set的最后一位是否为1判断是否为高位
L_Scankey_Input_Set_Mode_Usally_Low_Bit:
    LDA     P_Temp+3
    AND     #F0H
    STA     P_Temp+6
    LDA     P_Temp+4
    AND     #F0H
    CMP     P_Temp+6;比较储存的值的高四位和最大值得高四位
    BCC     L_Scankey_Input_Set_Mode_Usally_Low_Bit_RTS
    CMP     P_Temp+6
    BNE     L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine
    LDA     P_Temp+4
    AND     #0FH
    CMP     P_Temp+5
    BCS     L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine
    LDA     P_Temp+6   
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Control_Set_Mode_Date
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog

    RTS
L_Scankey_Input_Set_Mode_Usally_Low_Bit_RTS:
    RTS
L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine:
    LDA     P_Temp+6
    ORA     P_Temp+5
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Control_Set_Mode_Date
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS
;======================================================

L_Scankey_Input_Set_Mode_Usally_High_Bit:
    JSR     L_ROL_4Bit_Prog;高4bit将读取到的按键值向左平移4个Bit
    STA     P_Temp+5
    LDA     P_Temp+4
    AND     #F0H
    CMP     P_Temp+5;将最大值和读取到的数比较，当大于时退出
    BEQ     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_Special
    BCS     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine;当按键输入值的前四位大于最大值时推出
    
L_Scankey_Input_Set_Mode_Usally_High_Bit_RTS:
    RTS
L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_Special:
    LDA     P_Temp+3
    AND     #0FH
    STA     P_Temp+6
    LDA     P_Temp+4
    AND     #0FH
    CMP     P_Temp+6;将最大值的低四位和对应内存的低四位相比较，小于或等于跳转，否则清零低四位
    BCS     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine
    LDA     P_Temp+5
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS
L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine:
    LDA     P_Temp+3;当小于时，直接将按键读取的值给到对应的内存
    AND     #0FH
    ORA     P_Temp+5
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS
;================================================
;12小时制度的问题.
;P_Temp+4存储最大值,P_Temp+5存储按键读到的值，P_Temp+3读到的被改变的值
;P_Temp+6存储读到的被改变的值的高四位
;================================================
L_Scankey_Input_Set_Mode_Hr_usually:
    STX     P_Temp+7
    STA     P_Temp+4    
    JSR     L_Scankey_Input_Press
    BBS2    Sys_Flag_C,L_Scankey_Input_Set_Mode_Usally_High_Bit_RTS_12_Hour
    STA     P_Temp+5
    LDA     Time_Addr,X
    JSR     L_24_Hour_12_Hour_Prog
    JSR     L_A_HexToHexD
    STA     P_Temp+3
    BBR0    R_Mode_Set,L_Scankey_Input_Set_Mode_High_Bit_12_Hour
L_Scankey_Input_Set_Mode_Low_Bit_12_Hour:
    LDA     P_Temp+3
    AND     #F0H        ;保存当前时间的高四位
    STA     P_Temp+6
    ; LDA     P_Temp+4
    ; AND     #F0H
    BEQ     L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine_12_Hour
    ; CMP     P_Temp+6;比当前时间高四位和最大允许高四位,此时为0
    ; BCC     L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine_12_Hour
    LDA     P_Temp+4
    AND     #0FH
    CMP     P_Temp+5;判断当前内存的低四位和最大值的低四位，当小于时，直接将输入的值给到低四位
    BCC     L_Scankey_Input_Set_Mode_Usally_Low_Bit_RTS_12_Hour
    LDA     P_Temp+6
    ORA     P_Temp+5
    JSR     L_A_HexDToHex
    JSR     L_12_Hour_24_Hour_Prog
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
L_Scankey_Input_Set_Mode_Usally_Low_Bit_RTS_12_Hour:
    RTS
L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine_12_Hour:
    LDA     P_Temp+6
    ORA     P_Temp+5
    BNE     L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine_12_Hour_1
    LDA     #1
L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine_12_Hour_1:
    JSR     L_A_HexDToHex
    JSR     L_12_Hour_24_Hour_Prog
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS    
;-----------------------------------------------------------------
L_Scankey_Input_Set_Mode_High_Bit_12_Hour:
    LDA     P_Temp+5
    JSR     L_ROL_4Bit_Prog;高4bit将读取到的按键值向左平移4个Bit
    STA     P_Temp+5
    LDA     P_Temp+4
    AND     #F0H
    CMP     P_Temp+5;将最大值和读取到的数比较，当大于时退出
    BEQ     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_Special_12_Hour
    BCS     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_12_Hour;当按键输入值的前四位大于最大值时推出
    
L_Scankey_Input_Set_Mode_Usally_High_Bit_RTS_12_Hour:
    RTS
L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_Special_12_Hour:
    LDA     P_Temp+3
    AND     #0FH
    STA     P_Temp+6
    LDA     P_Temp+4
    AND     #0FH
    CMP     P_Temp+6;将最大值的低四位和对应内存的低四位相比较，小于或等于跳转，否则清零低四位
    BEQ     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_Special_12_Hour_1
    BCS     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_12_Hour
    LDA     P_Temp+5
    JSR     L_A_HexDToHex
    JSR     L_12_Hour_24_Hour_Prog
    STA		Time_Addr,X
L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_Special_12_Hour_1    
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS

L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_12_Hour:
    LDA     P_Temp+3;当小于时，直接将按键读取的值给到对应的内存
    AND     #0FH
    ORA     P_Temp+5  
    BNE     L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_12_Hour_1
    LDA     #1
L_Scankey_Input_Set_Mode_Usally_High_Bit_Countine_12_Hour_1:
    JSR     L_A_HexDToHex
    JSR     L_12_Hour_24_Hour_Prog
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
    RTS












































L_Scankey_Input_Press:
    RMB2    Sys_Flag_C
    LDA     P_Scankey_value
    CMP     #D_NUM0_Press
    BEQ     L_Input_Prog_Time_Mode_NUM0_Press
    CMP     #D_NUM1_Press
    BEQ     L_Input_Prog_Time_Mode_NUM1_Press
    CMP     #D_NUM2_Press
    BEQ     L_Input_Prog_Time_Mode_NUM2_Press
    CMP     #D_NUM3_Press
    BEQ     L_Input_Prog_Time_Mode_NUM3_Press
    CMP     #D_NUM4_Press
    BEQ     L_Input_Prog_Time_Mode_NUM4_Press
    CMP     #D_NUM5_Press
    BEQ     L_Input_Prog_Time_Mode_NUM5_Press
    CMP     #D_NUM6_Press
    BEQ     L_Input_Prog_Time_Mode_NUM6_Press
    CMP     #D_NUM7_Press
    BEQ     L_Input_Prog_Time_Mode_NUM7_Press
    CMP     #D_NUM8_Press
    BEQ     L_Input_Prog_Time_Mode_NUM8_Press
    CMP     #D_NUM9_Press
    BEQ     L_Input_Prog_Time_Mode_NUM9_Press
    SMB2    Sys_Flag_C
    RTS
L_Input_Prog_Time_Mode_NUM0_Press:
    LDA     #0
    RTS
L_Input_Prog_Time_Mode_NUM1_Press:
    LDA     #1
    RTS
L_Input_Prog_Time_Mode_NUM2_Press:
    LDA     #2
    RTS
L_Input_Prog_Time_Mode_NUM3_Press:
    LDA     #3
    RTS
L_Input_Prog_Time_Mode_NUM4_Press:
    LDA     #4
    RTS
L_Input_Prog_Time_Mode_NUM5_Press:
    LDA     #5
    RTS
L_Input_Prog_Time_Mode_NUM6_Press:
    LDA     #6
    RTS
L_Input_Prog_Time_Mode_NUM7_Press:
    LDA     #7
    RTS
L_Input_Prog_Time_Mode_NUM8_Press:
    LDA     #8
    RTS
L_Input_Prog_Time_Mode_NUM9_Press:
    LDA     #9
    RTS

