.Kdata
;***************************************
; RAM Address
;***************************************
RamStarAddr			EQU		1800H   ;RAM的开始地址
LCD_RamAddr			EQU		RamStarAddr     ;LCD RAM的地址
Time_Addr			EQU		RamStarAddr+Time_Str_Addr-Page0RamStarAddr
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
; bit6	=0响闹/1静音
; bit7	=
Sys_Flag_D				DS	1	;计时器模式的系统状态
; bit0 	=1正计时/倒计时开启计时
; bit1	=开始或者暂停计时
; bit2	=第一次倒计时
; bit3	=
; bit4 	=定时器闹铃
; bit5 	=
; bit6	=	
; bit7	=
Sys_Flag_E				DS	1	 ;编码器必备标志
; bit0 	=	0正旋转/1反旋转
; bit1	=
; bit2	=
; bit3	
; bit4 	=
; bit5 	=
; bit6	=	
; bit7	=

R_Reset_Time					DS	1;全显时间,一般为2s
	
R_Scankey_Time					DS	1;按键按下的时间
D_Rscankey_Half_Sec				EQU	16;按键时间
D_Rscankey_Sec					EQU	32
D_Rscankey_TWO_Sec				EQU	64


P_Scankey_value_T_1			DS	1
P_Scankey_value				DS	1;按键存储值
P_Scankey_value_Temporary	DS	1;按键临时储存

D_Scankey_Value				.EQU	11110100B
D_Date_Time_Press			.EQU	00010000B
D_12_24_Hour_Press			.EQU	00100000B
D_ALM_Press					.EQU	01000000B
D_Voice_Press				.EQU	10000000B
D_KNOB_Press				.EQU	00000100B
D_Konb_Value				.EQU	00000011B
;---------------------------------------
Time_Str_Addr	EQU		$	
R_Time_Sec						DS	1;时钟的秒数;	
R_Time_Min						DS	1;时钟的分钟数;	
R_Time_Hr 						DS	1;时钟的小时数;	
R_Time_Day 						DS	1;日
R_Time_Month 					DS	1;月
R_Time_Year						DS	1;年
R_Time_Week						DS	1;0是星期天，1是星期一---





R_Timer_Sec						DS	1;定时器显示时间/正计时时间秒数
R_Timer_Min						DS	1;定时器显示时间/正计时时间分钟
R_Timer_Min_Backup				DS	1;定时器显示时间/正计时时间分钟
Timer_TurnPlate_Min				DS	1;转盘每一个分段对应时间
Timer_TurnPlate_Sec				DS	1;转盘每一个分段对应时间
Timer_TurnPlate_Min_Backup		DS	1;转盘每一个分段对应时间
Timer_TurnPlate_Sec_Backup		DS	1;转盘每一个分段对应时间
Timer_TurnPlate_Frequeny		DS	1;转盘数


R_Alarm_Clock_State				DS	5;0是一次性闹钟，1是每天闹钟，2是工作日闹钟，3是周末闹钟

R_Alarm_Clock_Hr				DS	5
R_Alarm_Clock_Min				DS	5
R_Snz_Time						DS	5



D_Beep_Open_Last_Time_Alarm		EQU	21


D_Snz_Time						EQU	5
D_Snz_Frequency					EQU	6


R_Mode_Set					DS	1;设置模式

Konb_Last_State				DS	1



P_Temp			ds	16
R_Tmp0	equ	P_Temp	
R_Tmp1	equ	P_Temp+1
R_Tmp2	equ	P_Temp+2
R_Tmp3	equ	P_Temp+3
lcd_tmp_mask	equ	P_Temp+9
lcd_tmp_bit		equ	P_Temp+10

;==============================温湿度内存



R_RT_L					DS	1		;温度电阻
R_RT_M					DS  1		
R_RT_H                  DS  1
R_RR_L					DS	1		;标准电阻
R_RR_M                  DS  1
R_RR_H                  DS  1
R_RH_L					DS	1		;湿度电阻
R_RH_M                  DS  1
R_RH_H                  DS  1
;R_Measure_Temperature   DS  
R_Temperature        	DS	1		;温度
R_Temperature_L      	DS  1		;是否为零下温度
;R_Temperature_F_M		DS  1
;R_Temperature_F_H		DS  1

; R_Humidity				DS  1
; 
; R_Humidity_Level		DS  1
R_RFCCH					DS	1
; R_KeyCnt				DS	1




;---------------------------------------       

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
R_Mode							DS	1

.ENDS
