;清除贪睡功能
L_Control_SNZ_Close_Prog:
	LDA		R_Mode
	CMP		#1
	BEQ		L_Control_SNZ_Close_Prog_RTS
    CMP		#3
	BCS		L_Control_SNZ_Close_Prog_RTS
	RMB7	Sys_Flag_C
	LDA		#0
	STA		R_Snz_Time
	STA		R_Snz_Frequency;进入闹钟时间的设置会清除贪睡
L_Control_SNZ_Close_Prog_RTS:
    RTS
;======================================================================
;非设置模式下吗,闹钟模式，
;短按RESET，在整点报时界面，开启或关闭整点报时，按下触发
;在闹钟界面,按下触发闹铃模式的切换，关闭，普通和贪睡
;======================================================================

L_Alarm_First_Press_Prog:
	LDA		P_Scankey_value
	CMP		#D_Alm_Press
	BEQ		L_Alarm_First_Press_Prog_Alm_Press
	CMP		#D_Sig_Press
	BEQ		L_Alarm_First_Press_Prog_Sig_Press
	CMP		#D_Beep_Test_Press
	BEQ		L_Alarm_First_Press_Prog_Beep_Test_Press
	RTS



L_Alarm_First_Press_Prog_Alm_Press:;控制闹钟贪睡的开启关闭
	JSR		L_Control_SNZ_Close_Prog
	LDA		R_Alarm_Mode
	CMP		#2
	BCS		L_Alarm_First_Reset_Press_Prog_Alarm_Prog_Clr
	CLC
	LDA		R_Alarm_Mode
	ADC		#1
	STA		R_Alarm_Mode
	JMP		L_Dis_Alm_Snz_Symbol_Prog
L_Alarm_First_Reset_Press_Prog_Alarm_Prog_Clr:
	LDA		#0
	STA		R_Alarm_Mode
	JMP		L_Dis_Alm_Snz_Symbol_Prog
;======================================================
L_Alarm_First_Press_Prog_Sig_Press:;控制整点报时的开启和关闭

	BBS1	Sys_Flag_C,L_Alarm_First_Reset_Press_Prog_Every_Hour_Mode_Close
	SMB1	Sys_Flag_C
	JMP		L_Dis_lcd_Sig_Prog
L_Alarm_First_Reset_Press_Prog_Every_Hour_Mode_Close:
	RMB1	Sys_Flag_C
	JMP		L_Clr_lcd_Sig_Prog
;------------------------------------------
L_Alarm_First_Press_Prog_Beep_Test_Press:;声音测试
	SMB6	Sys_Flag_A;按键持续标志
	RMB5	Sys_Flag_A
	EN_LCD_IRQ
	LDA		#2
	STA		R_Voice_Unit
	RTS













;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;=====================================
;设置模式下闹钟的按键功能
;=====================================
L_Scankey_Set_Mode_Prog_Alarm_Clock:
   LDA      P_Scankey_value
   CMP      #D_NUM_Point_Press
   BEQ      L_Change_12_24_Prog_PM_AM_Alarm_Clock
   LDA      R_Mode_Set
   CLC
   CLD
   ROL
   TAX      
   LDA      Table_Alarm_Clock_Plus+1,X
   PHA
   LDA      Table_Alarm_Clock_Plus,X
   PHA
   RTS 
Table_Alarm_Clock_Plus:

    DW      L_Control_Set_Mode_Alarm_Clock_Prog_Hr-1
    DW      L_Control_Set_Mode_Alarm_Clock_Prog_Hr-1
	DW      L_Control_Set_Mode_Alarm_Clock_Prog_Min-1
    DW      L_Control_Set_Mode_Alarm_Clock_Prog_Min-1
;====================================================
L_Change_12_24_Prog_PM_AM_Alarm_Clock:
    LDX		#(R_Alarm_Clock_Hr-Time_Str_Addr)
	JSR		L_Change_12_14_Prog_AM_PM_ususally_Prog
    JSR     L_Display_Alarm_Clock_Hr_Prog
    RTS
;====================================================

L_Control_Set_Mode_Alarm_Clock_Prog_Min:
    LDX     #(R_Alarm_Clock_Min-Time_Str_Addr)
    LDA     #59H
    JMP     L_Scankey_Input_Set_Mode_Usally
;====================================================

L_Control_Set_Mode_Alarm_Clock_Prog_Hr:
    LDX     #(R_Alarm_Clock_Hr-Time_Str_Addr)
    BBR2    Sys_Flag_B,L_Control_Set_Mode_Alarm_Clock_Prog_Hr_1
    LDA     #23H
    JMP     L_Scankey_Input_Set_Mode_Usally
L_Control_Set_Mode_Alarm_Clock_Prog_Hr_1:
    LDA     #12H
    JMP     L_Scankey_Input_Set_Mode_Hr_usually
 