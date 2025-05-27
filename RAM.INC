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
; bit1	=0关闭整点报时，开启整点报时
; bit2 	=1设置输入的按键无效
; bit3	=
; bit4 	=闹钟闹铃
; bit5 	=1按键音开启
; bit6	=
; bit7	=1贪睡标志
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

D_PA_Value						EQU		01110000B
D_PA_Press						EQU		01111100B
D_PA2_Press						EQU		01110100B
D_PA3_Press						EQU		01111000B
D_PA4_Press						EQU		01100000B
D_PA5_Press						EQU		01010000B
D_PA6_Press						EQU		00110000B
D_PA5_PA6_Press					EQU		00010000B

D_PC_Press						EQU		00001111B
D_PC0_Press						EQU		00000001B
D_PC1_Press						EQU		00000010B
D_PC2_Press						EQU		00000100B
D_PC3_Press						EQU		00001000B

; P_Beep_Frequency				DS	1	;声音大小
; D_Beep_Frequency_1_2_Duty		EQU	0
; D_Beep_Frequency_3/4_Duty		EQU 80H
; D_Mode_Press					EQU		1 ;
; D_ST_SP_Press					EQU		2 ;
; D_Reset_Press					EQU		3 ;
; D_Light_Press					EQU		4 ;
D_NUM1_Press					EQU		1;1
D_NUM2_Press					EQU		2;2
D_NUM3_Press					EQU		3;3
D_NUM4_Press					EQU		4;4
D_NUM5_Press					EQU		5;5
D_NUM6_Press					EQU		8;6
D_NUM7_Press					EQU		9;7
D_NUM8_Press					EQU		10;8
D_NUM9_Press					EQU		11;9
D_NUM0_Press					EQU		12;0
D_NUM_Point_Press				EQU		15;.
D_NUM_Equal_Press				EQU		20;=
D_NUM_Add_Press					EQU		16;+
D_NUM_Minus_Press				EQU		17;-
D_NUM_Multiply_Press			EQU		18;*
D_NUM_Divid_Press				EQU		19;/
D_B_Press						EQU		21;mode
D_C_Press						EQU		22;set
D_Beep_Test_Press				EQU		23;声音测试

D_Date_Press					EQU		D_NUM_Divid_Press
D_Alm_Press						EQU		D_NUM4_Press
D_Sig_Press						EQU		D_NUM_Multiply_Press
D_ST_SP_Press					EQU		D_NUM_Add_Press
D_ST_Hour_Press					EQU		D_NUM_Divid_Press
D_Reset_Press					EQU		D_NUM0_Press
D_Mode_Press					EQU		D_C_Press
D_Set_Press						EQU		D_B_Press

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



;==================================================
;==================================================
;===================================================
Calculator_Str_Addr	EQU		$
;这个加1是存储小数点位置的，bit7是存储数据的正负，其余是存储有效移位次数
MAX_DIG		.EQU	8
MAX_BYTE	.EQU	MAX_DIG / 2

FD			.EQU	MAX_DIG
BUF1		.DS		MAX_DIG+1
BUF2		.DS		MAX_DIG+1
BUF3		.DS		MAX_DIG
BUF4		.DS		MAX_DIG
BUF5		.DS		MAX_DIG
BUF6		.DS		4


;==========================================
IBUF		 DS		MAX_BYTE+1
ACC			.EQU	P_Temp
IFD			.EQU	MAX_BYTE
;=======================================
; ERR_NULL	.EQU	0
ERR_DIV0	.EQU	1
Err_FUll	.EQU	2
; ERR_SQRT	.EQU	3
; ERR_M		.EQU	4
; ERR_GT		.EQU	5
; ERR_MU		.EQU	6
; ERR_PCT		.EQU	7
; ERR_IN		.EQU	8
;=======================================


DINX		.EQU	P_Temp+6


D1FD		.EQU	MAX_BYTE
DFD			.EQU	MAX_BYTE
BFD			.EQU	MAX_BYTE


; Calculator_State		DS	1
Calculator_State_Init				.EQU	0;计算器第一次输入状态
Calculator_State_Symbol_First_Press	.EQU	1;计算器第一次按下加减乘除后的状态
Calculator_State_Input				.EQU	2;计算器按下加减乘除后按下数字的状态
Calculator_State_Equal_Press		.EQU	3;计算器按下等于号的状态
Calculator_State_Involution			.EQU	4;计算器乘方模式
Calculator_State_Involution_Input	.EQU	5;计算器乘方模式按键输入
Calculator_State_Involution_Input_Symbol	.EQU	6
; Calculator_State_Symbol_Press_Again	.EQU	5;计算器非第一次按下加减乘除符号键
; Calculator_Symbol_State	DS	1
;=========================================
State_Null			.EQU	0
State_Add			.EQU	1
State_SUB			.EQU	2
State_Mul			.EQU	3
State_DIV			.EQU	4
State_Involution	.EQU	5


State_Equal			.EQU	6


Calc_Init				.EQU	0	;初始化，无意义
Calc_First_Output		.EQU	1	;按键第一次按下加减乘除符号键
Calc_First_Output_		.EQU	2	;第一次运算没有数字输入
Calc_First_Output_In	.EQU	3	;第一次按键按下有数字输入
Calc_First_Output_Involution	.EQU	4
Calc_First_Output_Involution_IN	.EQU	5
MAX_Number_Input		.EQU	16

Time_To_Clock_Mode	DS	1
D_Time_To_Clock_Mode	.EQU	6
;---------------------------------------       
P_Temp			ds	10
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

; IBUF		DS		MAX_DIG+1

DBUF		DS		MAX_BYTE+1
D1BUF		DS		MAX_BYTE+1
BBUF		DS		MAX_BYTE+1

Calculator_Symbol_State_1	DS	1
; Time_To_Clock_Mode	DS	1



ERR			DS		1
R_Mode						DS	1;0是时钟模式，1是闹钟，2是正计时，3是第二时钟，4是倒计时

R_Set_Mode_Exit_Time			DS	1;自动设置退出时间
D_Set_Mode_Exit_Time			EQU	6
R_Alarm_Clock_Open_Beep_Time	DS	1;32Hz转化为16hz
R_Close_Beep_Time				DS	1;闹铃关闭时间，闹铃响多久
R_Voice_Unit					DS	1;闹铃响的次数，一秒响几次

R_Snz_Time						DS	1;贪睡闹钟的分钟;
R_Snz_Frequency					DS	1;贪睡闹钟的小时;

Calculator_State				DS	1
Calculator_Symbol_State			DS	1
Calculator_State_Mechine		DS	1
; Calculator_Symbol_State_Equal	DS	1
; Loop_Count						DS	1

R_Dis_Date_Time					DS	1
OP								DS	1;运算
R_Timer_Ms_CMP					DS	1
R_Involution					DS	1
.ENDS
