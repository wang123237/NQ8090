;=========================
L_Update_Time_Prog:
	JSR		L_Update_Time_Sec_Prog


	BCC		L_End_Update_Time_Prog

	
	JSR		L_Update_Time_Min_Prog
	

	BCC		L_End_Update_Time_Prog


	JSR		L_Update_Time_Hr_Prog


	BCC		L_End_Update_Time_Prog

	JSR		L_Update_Time_Day_Prog


	BCC		L_End_Update_Date_Prog

	JSR		L_Update_Time_Month_Prog


	BCC		L_End_Update_Date_Prog

	JSR		L_Update_Time_Year_Prog


L_End_Update_Date_Prog:
	JSR		L_Auto_Counter_Week
L_End_Update_Time_Prog:
	RTS	

;===================================
;-----时间的增加---------------------
;===================================
;----------------------------------
L_Update_Time_Sec_Prog:
	LDX 	#(R_Time_Sec-Time_Str_Addr)
	JMP		L_Inc_To_60_Prog
L_Update_Time_Min_Prog:;时间分钟更新加
	LDX		#(R_Time_Min-Time_Str_Addr)
	JMP		L_Inc_To_60_Prog
;---------------------------
L_Update_Time_Hr_Prog:;时间小时更新加
	LDX		#(R_Time_Hr-Time_Str_Addr)
	LDA		#23H
	JMP		L_Inc_To_Any_Count_Prog
;----------------------------------
L_Update_Time_Day_Prog:;时间天数更新加
	JSR		L_Check_MaxDay_Prog
	LDX		#(R_Time_Day-Time_Str_Addr)
	JMP		L_Inc_To_Any_Count_Prog_To_1
;-------------------------------------
L_Update_Time_Month_Prog:;时间月更新加
	LDX		#(R_Time_Month-Time_Str_Addr)
	LDA		#12H
	JMP		L_Inc_To_Any_Count_Prog_To_1

;----------------------------------
L_Update_Time_Year_Prog:;时间年更新加
	LDX		#(R_Time_Year-Time_Str_Addr)
	LDA		#99H
	JSR		L_Inc_To_Any_Count_Prog
	JSR		L_Judge_MaxDay_Prog
	RTS	
;================================
L_Inc_To_60_Prog:;将数从0加到59
	LDA		#59H	
L_Inc_To_Any_Count_Prog:
	SED
	SEC
	SBC		Time_Addr,X
	BEQ		L_Inc_Over_Prog
	BCC		L_Inc_Over_Prog
	CLC
	LDA		Time_Addr,X
	ADC		#1
	STA		Time_Addr,X
	CLC
	CLD
	RTS
L_Inc_Over_Prog:
	LDA		#0
	STA		Time_Addr,X
	CLD
	SEC
L_End_Inc_To_60_Prog:	
	RTS

L_Inc_To_Any_Count_Prog_To_1:;将数从1加到59
	SED
	SEC
	SBC		Time_Addr,X
	BEQ		L_Inc_Over_Prog_To_1
	BCC		L_Inc_Over_Prog_To_1
	CLC
	LDA		Time_Addr,X
	ADC		#1
	STA		Time_Addr,X
	CLD
	RTS
L_Inc_Over_Prog_To_1:
	LDA		#1
	STA		Time_Addr,X
	CLD
	RTS
;=======================================================
L_Dec_To_60_Prog:
	LDA		#59H
L_Dec_To_0_Prog:
	STA		P_Temp
	LDA		#0
L_Dec_To_Anycount_Prog:
	SED
	SEC
    SBC     Time_Addr,X
	BEQ		L_Dec_Over_Prog
	BCS		L_Dec_Over_Prog
	
	SEC
	LDA		Time_Addr,X
	SBC		#1
	STA		Time_Addr,X
	CLD
	SEC
	RTS
L_Dec_Over_Prog:
	LDA		P_Temp
	STA		Time_Addr,X
	CLD
	CLC	
	RTS
L_Dec_To_1_Prog:
    STA     P_Temp
	SED
    LDA     #1
    BRA     L_Dec_To_Anycount_Prog
;===============================================
;=====================================
;-------------------------------------
;=====================================
L_Check_MaxDay_Prog:;检查每月的最大天数
	LDA		R_Time_Month
	JSR		L_DToHx_Prog
	DEC
	TAX	
L_Check_MaxDay_Prog_Alarm_clock_Prog:
	LDA		Sys_Flag_B
	AND		#08H
	BNE		L_Check_LeapYear_MaxDay_Prog
	LDA		T_NoLeapYear_Month,X
	RTS
L_Check_LeapYear_MaxDay_Prog:
	LDA		T_LeapYear_Month,X
	RTS
;==============================
;------------------------------
;==============================
L_Judge_MaxDay_Prog:;如果最大天数最大超界限，则给予月份的最大天数
	JSR		L_Check_MaxDay_Prog
	STA		P_Temp+5
	CMP		R_Time_Day
	BCS		L_Judge_MaxDay_Prog_RTS
	LDA		P_Temp+5
	STA		R_Time_Day
L_Judge_MaxDay_Prog_RTS:
	RTS
;==================================
L_Check_LeapYear_Prog:;检查是否是闰年
	LDA		R_Time_Year
	JSR		L_DToHx_Prog
	STA		P_Temp
	CLC		
	ROR		P_Temp
	LDX		P_Temp
	LDA		T_LeapYear_Week,X
	STA		P_Temp
	LDA		R_Time_Year
	AND		#01H
	BEQ		L_Counter_LeapYear;建表从2000年开始处于低四位，高四位，需要右移四位
	CLC		
	ROR		P_Temp
	CLC		
	ROR		P_Temp	
	CLC		
	ROR		P_Temp	
	CLC		
	ROR		P_Temp	
L_Counter_LeapYear:
	RMB3	Sys_Flag_B
	LDA		#08H
	AND		P_Temp	
	ORA		Sys_Flag_B
	STA		Sys_Flag_B;第四位为1则为闰年，否则·为平年
	RTS
;===========================================
;P_Temp,0-3bit存储对应年分的1月1日星期几，4bit存储平闰年
;P_Temp+1存储前几个月的天数除以7的余数
L_Auto_Counter_Week:
	JSR		L_Check_LeapYear_Prog
	JSR		L_Judge_MaxDay_Prog
	LDA		R_Time_Month
	JSR		L_DToHx_Prog
	TAX	
	LDA		T_Month_Week,X
	STA		P_Temp+1
	LDA		Sys_Flag_B
	AND		#08H
	BEQ		L_Counter_Week_2;非闰年跳转，非闰年需要将右移四位
	CLC		
	ROR		P_Temp+1
	CLC		
	ROR		P_Temp+1	
	CLC		
	ROR		P_Temp+1	
	CLC		
	ROR		P_Temp+1	
L_Counter_Week_2:;十六进制运算
	LDA		#$0F
	AND		P_Temp+1;保留低四位多余的天数
	STA		P_Temp+1
	LDA		#7
	AND		P_Temp;保留低三位位每年一月一号星期几
	SED
	CLC
	ADC		P_Temp+1;每年一月一日星期几加上日期再加上多余的天数
	ADC		R_Time_Day
	STA		P_Temp
L_Loop_WeekSub_7:
	SEC
	LDA		P_Temp
	SBC		#7
	BCC		L_End_Counter_Week
	STA		P_Temp
	BRA		L_Loop_WeekSub_7
L_End_Counter_Week:
	LDA		P_Temp		
	BEQ		L_SetWeek_Sat
	DEC		P_Temp
	BRA		L_Exit_Counter_Week
L_SetWeek_Sat:
	LDA		#6
	STA		P_Temp
L_Exit_Counter_Week:
	LDA		P_Temp
	STA		R_Time_Week
	CLD
	RTS
;===============================================
;-------------------------------------------
T_LeapYear_Month:
	DB		31H
	DB		29H
	DB		31H
	DB		30H	
	DB		31H
	DB		30H
	DB		31H
	DB		31H
	DB		30H
	DB		31H
	DB		30H
	DB		31H
T_NoLeapYear_Month:
	DB		31H
	DB		28H
	DB		31H
	DB		30H
	DB		31H
	DB		30H
	DB		31H
	DB		31H
	DB		30H
	DB		31H
	DB		30H
	DB		31H
T_LeapYear_Week:
	DB		1EH   ;2001,2000 ;E="1110"代表2000年1月1日是星期六(110),是闰年(1),
	DB		32H   ;2003,2002	;000星期天
	DB		6CH   ;2005,2004	;001星期一
	DB		10H   ;2007,2006	;010星期二
	DB		4AH   ;2009,2008	;011星期三
	DB		65H   ;2011,2010	;100星期四
	DB		28H   ;2013,2012	;101星期五
	DB		43H   ;2015,2014	;110星期六
	DB		0DH   ;2017,2016
	DB		21H   ;2019,2018
	DB		5BH   ;2021,2020
	DB		06H   ;2023,2022
	DB		39H   ;2025,2024
	DB		54H   ;2027,2026
	DB		1EH   ;2029,2028
	DB		32H   ;2031,2030
	DB		6CH   ;2033,2032
	DB		10H   ;2035,2034
	DB		4AH   ;2037,2036
	DB		65H   ;2039,2038
	DB		28H   ;2041,2040
	DB		43H   ;2043,2042
	DB		0DH   ;2045,2044
	DB		21H   ;2047,2046
	DB		5BH   ;2049,2048
	DB		06H   ;2051,2050
	DB		39H   ;2053,2052
	DB		54H   ;2055,2054
	DB		1EH   ;2057,2056
	DB		32H   ;2059,2058
	DB		6CH   ;2061,2060
	DB		10H   ;2063,2062
	DB		4AH   ;2065,2064
	DB		65H   ;2067,2066
	DB		28H   ;2069,2068
	DB		43H   ;2071,2070
	DB		0DH   ;2073,2072
	DB		21H   ;2075,2074
	DB		5BH   ;2077,2076
	DB		06H   ;2079,2078
	DB		39H   ;2081,2080
	DB		54H   ;2083,2082
	DB		1EH   ;2085,2084
	DB		32H   ;2087,2086
	DB		6CH   ;2089,2088
	DB		10H   ;2091,2090
	DB		4AH   ;2093,2092
	DB		65H   ;2095,2094
	DB		28H   ;2097,2096
	DB		43H   ;2099,2098
;--------------------------------
T_Month_Week:
	DB		00H   	
	DB		00H   ;JANUARY		从1月1日开始，所以1月为0
	DB		33H   ;FABRUARY 	低4Bit为非闰年，高4Bit为闰年,
	DB		43H   ;MARCH		每4bit数字是前几个月全部的天数减去7的倍数的剩余天数
	DB		76H   ;APRIL
	DB		21H   ;MAY
	DB		54H   ;JUNE
	DB		76H   ;JULY
	DB		32H   ;AUGUST
	DB		65H   ;SEPTEMBER
	DB		10H   ;OCTOBER
	DB		43H   ;NOVEMBER
	DB		65H   ;DECEMBER  