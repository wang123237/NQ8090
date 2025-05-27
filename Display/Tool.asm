L_A_HexToHexD:
	STA		P_Temp								; 将十进制输入保存到 P_Temp
	LDA		#0									; 初始化高位寄存器
	STA		P_Temp+1							; 高位清零
	STA		P_Temp+2							; 低位清零

L_DecToHex_Loop:
	LDA		P_Temp								; 读取当前十进制值
	CMP		#10
	BCC		L_DecToHex_End						; 如果小于16，则跳到结束

	SEC											; 启用借位
	SBC		#10									; 减去16
	STA		P_Temp								; 更新十进制值
	INC		P_Temp+1							; 高位+1，累加十六进制的十位

	BRA		L_DecToHex_Loop						; 重复循环

L_DecToHex_End:
	LDA		P_Temp								; 最后剩余的值是低位
	STA		P_Temp+2							; 存入低位

	LDA		P_Temp+1							; 将高位放入A寄存器准备结果组合
	CLC
	ROL
	ROL
	ROL
	ROL											; 左移4次，完成乘16
	CLC
	ADC		P_Temp+2							; 加上低位值

	RTS

;======================================================================
L_A_HexDToHex:
	STA		P_Temp								; 将十六进制输入保存到 P_Temp
	LDA		#0									; 初始化高位寄存器
	STA		P_Temp+1							; 高位清零
	STA		P_Temp+2							; 低位清零

	LDA		P_Temp
	AND		#0FH
	STA		P_Temp+2
	LDA		P_Temp
	AND		#F0H
	CLC
	ROR
	ROR
	ROR
	ROR
	STA		P_Temp
L_A_HexDToHex_Loop:
	CLC
	LDA		#10
	ADC		P_Temp+2
	STA		P_Temp+2
	DEC		P_Temp
	LDA		P_Temp
	BNE		L_A_HexDToHex_Loop
	LDA		P_Temp+2
	RTS
;===========================================

L_12_24_Prog:;12小时和24小时切换
	STA		P_Temp	
	BBS2	Sys_Flag_B,L_12_24_Prog_5;判断是24小时制跳转退出
	LDA		P_Temp
	BEQ		L_12_24_Prog_1;为0是跳转
	CMP		#11
	BEQ		L_12_24_Prog_4
	BCS		L_12_24_Prog_3;比12大时跳转
L_12_24_Prog_4:
	JSR		L_Dis_lcd_AM_Prog
	JSR		L_Clr_lcd_PM_Prog
	LDA		P_Temp
L_12_24_Prog_OUT:
	RTS
L_12_24_Prog_1:;0点
	JSR		L_Dis_lcd_AM_Prog
	JSR		L_Clr_lcd_PM_Prog
	LDA		#12
	RTS
L_12_24_Prog_3:
	JSR		L_Clr_lcd_AM_Prog
	JSR		L_Dis_lcd_PM_Prog
	LDA		P_Temp
	CMP		#12
	BEQ		L_12_24_Prog_OUT
	SEC
	SBC		#12
	RTS
L_12_24_Prog_5:
	JSR		L_Clr_lcd_AM_Prog
	JSR		L_Clr_lcd_PM_Prog
	LDA		P_Temp
	RTS


;==================================
L_12_To_24_Prog:
	LDA		P_Temp+3
	CMP		#12
	BCC		L_AM_TO_24_Prog
L_PM_TO_24_Prog:;入口P_Temp+5(按键给的值)，P_Temp+3原值
	LDA		P_Temp+5
	CMP		#12
	BEQ		 L_PM_TO_24_Prog_RTS 
	CLC
	ADC		#12
	RTS

L_PM_TO_24_Prog_RTS:
	RTS

L_AM_TO_24_Prog:
	LDA		P_Temp+5
	CMP		#12
	BNE		L_PM_TO_24_Prog_RTS
	LDA		#0
	RTS