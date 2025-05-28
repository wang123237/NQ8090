.Kdata
;***************************************
; RAM Address
;***************************************
RamStarAddr			EQU		1800H   ;RAM的开始地址
LCD_RamAddr			EQU		RamStarAddr     ;LCD RAM的地址
Time_Addr			EQU		RamStarAddr+Time_Str_Addr-Page0RamStarAddr
Cal_Addr			EQU		RamStarAddr+Calculator_Str_Addr-Page0RamStarAddr
RAM					EQU		80H
;***************************************
;Time_Addr		EUQ		B0H
;***************************************
.PAGE0     ;page 0的内存布局
;***************************************
;	ORG	0098H
;---------------------------------------------------------------------
	ORG	0080H

Page0RamStarAddr	EQU		$	
LCDRAM					DS	6*5
D_LCD_RAM				EQU	6*5

R_Int_Backup			DS	1

Sys_Flag_A				DS	1		;0	系统状态
; bit0 	=132hz标志
; bit1	=1按键首次扫描标志
; bit2 	=0按键循环扫描标志
; bit3	=0设置模式
; bit4 	=0快加设置(此工程无用)
; bit5 	=0无效键设置
; bit6	=01按键长按
; bit7	=0按键按下返回时间模式的标志
Sys_Flag_B				DS	1	;时钟模式的系统状态
; bit0 	=半秒标志
; bit1	=一秒标志
; bit2	=12小时/24小时制度
; bit3	=1是润年标志
; bit4 	=
; bit5 	=
; bit6	=
; bit7	=
Sys_Flag_C				DS	1	;闹钟模式的系统状态
; bit0 	=0闹铃界面/1 整点报时
; bit1	=1闹钟开启0闹钟关闭
; bit2 	=
; bit3	=
; bit4 	=闹钟闹铃
; bit5 	=1按键音开启
; bit6	=
; bit7	=1
Sys_Flag_D				DS	1	;计时器模式的系统状态
; bit0 	=1正计时开启计时
; bit1	=1,32HZ标志
; bit2	=1第一次倒计时
; bit3	=
; bit4 	=定时器闹铃
; bit5 	=0无中途测量，1中途测量
; bit6	=第一次进入补偿标志
; bit7	=
R_Reset_Time					DS	1;全显时间,一般为2s
	
R_Scankey_Time					DS	1;按键按下的时间
D_Rscankey_Half_Sec				EQU	16;按键时间
D_Rscankey_Sec					EQU	32
D_Rscankey_TWO_Sec				EQU	64


P_Scankey_value_T_1			DS	1
P_Scankey_value				DS	1;按键存储值
P_Scankey_value_Temporary	DS	1;按键临时储存



;---------------------------------------
Time_Str_Addr	EQU		$	
R_Time_Sec						DS	1;时钟的秒数;	
R_Time_Min						DS	1;时钟的分钟数;	
R_Time_Hr 						DS	1;时钟的小时数;	
R_Time_Day 						DS	1;日
R_Time_Month 					DS	1;月
R_Time_Year						DS	1;年
R_Time_Week						DS	1;0是星期天，1是星期一---

R_Time_Min_Another				DS	1;第二时间的分钟
R_Time_Hr_Another				DS	1;第二时间的小时

R_Timer_Ms						DS	1;定时器10ms次数
R_Timer_Sec						DS	1;定时器显示时间/正计时时间秒数
R_Timer_Min						DS	1;定时器显示时间/正计时时间分钟
R_Timer_Hr						DS	1;定时器显示时间/正计时时间小时
R_Timer_X						DS	1
R_Timer_X_1						DS	1

R_Timer_Hr_Measurement			EQU	BUF4
R_Timer_Min_Measurement			EQU	BUF4+1
R_Timer_Sec_Measurement			EQU	BUF4+2
R_Timer_Ms_Measurement			EQU	BUF4+3


D_Beep_Open_Last_Time_Alarm		EQU	21

R_Alarm_Clock_Min				DS	1;闹钟的分钟;	10
R_Alarm_Clock_Hr 				DS	1;闹钟的小时;	11
R_Alarm_Mode					DS	1;闹钟的模式，0是闹钟关闭，1是闹钟开启，2是循环闹铃


D_Snz_Time						EQU	5
D_Snz_Frequency					EQU	6


R_Mode_Set					DS	1;设置模式




;---------------------------------------       
P_Temp			ds	8
;显示从写P_Temp+4
;---------------------------------------
;---------------------------------------
;***************************************
.ENDS
;***************************************
.Udata
;---------------------------------------
	ORG    1880H
;---------------------------------------
;---------------------------------------
R_Set_Mode_Exit_Time			DS	1;自动设置退出时间
D_Set_Mode_Exit_Time			EQU	6
R_Alarm_Clock_Open_Beep_Time	DS	1;32Hz转化为16hz
R_Close_Beep_Time				DS	1;闹铃关闭时间，闹铃响多久
R_Voice_Unit					DS	1;闹铃响的次数，一秒响几次


.ENDS
