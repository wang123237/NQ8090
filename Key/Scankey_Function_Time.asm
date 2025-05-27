;======================================================================
;非设置模式下吗,时钟模式按下/号键，显示日期
;======================================================================
L_Clock_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_Date_Press
	BNE		L_Clock_First_Press_Prog_OUT
    JSR		L_Clr_All_8Bit_Prog
	JSR		L_Display_Time_Date_Prog
	SMB6	Sys_Flag_A
	RMB5	Sys_Flag_A
L_Clock_First_Press_Prog_OUT:
	RTS
;==================================
;时间模式下，设置模式下按键处理问题
;==================================
L_Scankey_Set_Mode_Prog_Clock:
    LDA     P_Scankey_value
    CMP     #D_ST_SP_Press
    BEQ     L_Change_12_Clock_24_Clock_Prog_TO;按下加键，改变24小时——12小时制
    CMP     #D_NUM_Point_Press
    BEQ     L_Change_12_24_Prog_PM_AM_TO
    LDA     R_Dis_Date_Time
    BNE     L_Clock_First_Press_Prog_OUT
    LDA     R_Mode_Set
    CLD
    CLC
    ROL
    TAX     
    LDA     Table_Time_Plus+1,X
    PHA
    LDA     Table_Time_Plus,X
    PHA     
    RTS
L_Change_12_24_Prog_PM_AM_TO:
    JMP     L_Change_12_24_Prog_PM_AM
L_Change_12_Clock_24_Clock_Prog_TO:;按下按键改变12小时制和24小时制
    JMP     L_Change_12_Clock_24_Clock_Prog

Table_Time_Plus:
    DW      L_Control_Set_Mode_Clock_Prog_Sec-1
    DW      L_Control_Set_Mode_Clock_Prog_Hr-1
    DW      L_Control_Set_Mode_Clock_Prog_Hr-1
    DW      L_Control_Set_Mode_Clock_Prog_Min-1
    DW      L_Control_Set_Mode_Clock_Prog_Min-1
    DW      L_Control_Set_Mode_Clock_Prog_Year-1
    DW      L_Control_Set_Mode_Clock_Prog_Year-1
    DW      L_Control_Set_Mode_Clock_Prog_Month-1
    DW      L_Control_Set_Mode_Clock_Prog_Month-1
    DW      L_Control_Set_Mode_Clock_Prog_Day-1
    DW      L_Control_Set_Mode_Clock_Prog_Day-1

;========================================
;在时间设置模式下按下+键，改变24小时12小时制
;========================================
L_Change_12_Clock_24_Clock_Prog:
    BBS2    Sys_Flag_B,L_Change_12_24_Prog_12;当前是24小时制是跳转
    SMB2    Sys_Flag_B
    JSR     L_Display_Time_Hr_Prog
    RTS
L_Change_12_24_Prog_12:
    RMB2    Sys_Flag_B
    JSR     L_Display_Time_Hr_Prog
    RTS
;========================================
;在时间设置模式下按下.键，改变12小时的AM_PM
;========================================
L_Change_12_24_Prog_PM_AM:
    LDX     #(R_Time_Hr-Time_Str_Addr)
    JSR     L_Change_12_14_Prog_AM_PM_ususally_Prog
    JSR     L_Display_Time_Hr_Prog
    RTS
;=============================================
;---------------------------------------------
;=============================================

L_Control_Set_Mode_Clock_Prog_Sec:;30秒及以上清零并分钟加1，不到30秒清零
    LDA     P_Scankey_value_Temporary
    CMP     #D_NUM0_Press
    BNE     L_Control_Set_Mode_Clock_Prog_Sec_RTS
    LDA     R_Time_Sec
    STA     P_Temp
    LDA     #0
    STA     R_Time_Sec
    LDA     P_Temp
    CMP     #30
    BCS     L_Control_Set_Mode_Clock_Prog_Sec_1
    RTS
L_Control_Set_Mode_Clock_Prog_Sec_1:
    JSR     L_Update_Time_Min_Prog
L_Control_Set_Mode_Clock_Prog_Sec_RTS:
    RTS
;=============================================
;---------------------------------------------
;=============================================
L_Control_Set_Mode_Clock_Prog_Min:
    LDX     #(R_Time_Min-Time_Str_Addr)
    LDA     #59H
    JMP     L_Scankey_Input_Set_Mode_Usally_Time
;=============================================
;---------------------------------------------
;=============================================
L_Control_Set_Mode_Clock_Prog_Hr:
    LDX     #(R_Time_Hr-Time_Str_Addr)
    BBR2    Sys_Flag_B,L_Control_Set_Mode_Clock_Prog_Hr_1
    LDA     #23H
    JMP     L_Scankey_Input_Set_Mode_Usally_Time
L_Control_Set_Mode_Clock_Prog_Hr_1:
    LDA     #12H
    JMP     L_Scankey_Input_Set_Mode_Hr_Time

;=============================================
;---------------------------------------------
;=============================================
L_Control_Set_Mode_Clock_Prog_Day:
    ; JSR     L_Check_MaxDay_Prog
    ; JSR     L_A_HexToHexD.
    LDA     #31H
    LDX     #(R_Time_Day-Time_Str_Addr)
    JSR     L_Scankey_Input_Set_Mode_Usally_Time_Date
    JSR     L_Check_MaxDay_Prog
    RTS
;=============================================
;---------------------------------------------
;=============================================
L_Control_Set_Mode_Clock_Prog_Month
    LDX     #(R_Time_Month-Time_Str_Addr)
    LDA     #12H
    JSR     L_Scankey_Input_Set_Mode_Usally_Time_Date
    RTS
;=============================================
;---------------------------------------------
;=============================================
L_Control_Set_Mode_Clock_Prog_Year
    LDX     #(R_Time_Year-Time_Str_Addr)
    LDA     #99H
    JSR     L_Scankey_Input_Set_Mode_Usally_Time
    RTS


;==========================================
;==========================================
L_Control_Set_Mode_Date:
    LDA     R_Mode
    BNE     L_Control_Set_Mode_Date_RTS
    LDA     R_Mode_Set
    CMP     #4
    BNE     L_Control_Set_Mode_Date_RTS
    LDA     #4
    STA     R_Dis_Date_Time
    JSR     L_Display_Set_Mode_Prog
L_Control_Set_Mode_Date_RTS:
    RTS

;==========================================
;按键按下后输入的通用函数
;==========================================
L_Scankey_Input_Set_Mode_Usally_Time:
    STA     P_Temp+4
    LDA     Time_Addr,X
    JSR     L_A_HexToHexD
    STA     P_Temp+3
    JSR     L_Scankey_Input_Press
    BBS2    Sys_Flag_C,L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_RTS
    STA     P_Temp+5
    BBS0    R_Mode_Set,L_Scankey_Input_Set_Mode_Usally_High_Bit_TO;根据R_Mode_Set判断是否为高位
    JMP     L_Scankey_Input_Set_Mode_Usally_Low_Bit
L_Scankey_Input_Set_Mode_Usally_High_Bit_TO:
    JMP     L_Scankey_Input_Set_Mode_Usally_High_Bit
;==========================================
;==========================================
;==========================================
L_Scankey_Input_Set_Mode_Usally_Time_Date:
    STA     P_Temp+4
    LDA     Time_Addr,X
    JSR     L_A_HexToHexD
    STA     P_Temp+3
    JSR     L_Scankey_Input_Press
    BBS2    Sys_Flag_C,L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_RTS
    STA     P_Temp+5
    BBS0    R_Mode_Set,L_Scankey_Input_Set_Mode_Usally_High_Bit_TO;根据R_Mode_Set判断是否为高位
L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT:
    LDA     P_Temp+3
    AND     #F0H
    STA     P_Temp+6
    LDA     P_Temp+4
    AND     #F0H
    CMP     P_Temp+6;判断当前内存的高四位和最大值的高四位，当小于时，直接将输入的值给到低四位
    BCS     L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_Conutine   
    LDA     P_Temp+4
    AND     #0FH
    CMP     P_Temp+5;判断当前内存的低四位和最大值的低四位，当小于时，直接将输入的值给到低四位
    BCC     L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_RTS
    LDA     P_Temp+6
    ORA     P_Temp+5
    JSR     L_A_HexDToHex
    STA		Time_Addr,X
    JSR     L_Scankey_Set_Mode_Mode_First_Press_Prog
L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_RTS:
    RTS
L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_Conutine:
    LDA     P_Temp+3
    AND     #F0H
    BNE     L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_Conutine_1
    LDA     P_Temp+5
    BEQ     L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_RTS
L_Scankey_Input_Set_Mode_Usally_Time_Date_Low_BIT_Conutine_1:
    JMP     L_Scankey_Input_Set_Mode_Usally_Low_Bit_Conutine
;================================================================
;================================================================
;================================================================
;================================================================


;P_Temp+3存储读取到的时间，P_Temp+4
;
L_Scankey_Input_Set_Mode_Hr_Time:
    STX     P_Temp+7
    STA     P_Temp+4    
    JSR     L_Scankey_Input_Press
    BBS2    Sys_Flag_C,L_Scankey_Input_Set_Mode_Hr_Time_RTS
    STA     P_Temp+5
    LDA     Time_Addr,X
    JSR     L_24_Hour_12_Hour_Prog
    JSR     L_A_HexToHexD
    STA     P_Temp+3
    BBS0    R_Mode_Set,L_Scankey_Input_Set_Mode_High_Bit_12_Hour_TO
    JMP     L_Scankey_Input_Set_Mode_Low_Bit_12_Hour
L_Scankey_Input_Set_Mode_Hr_Time_RTS:

    RTS

L_Scankey_Input_Set_Mode_High_Bit_12_Hour_TO:
    JMP     L_Scankey_Input_Set_Mode_High_Bit_12_Hour