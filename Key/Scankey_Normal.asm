L_Scankey_usually_Prog:   
	JSR		L_Judgement_Scankey_Prog;调整按键输入输出模式
	JSR		L_ScanKey_Delay_Prog
	LDA		#0
	STA		P_Scankey_value_Temporary
	LDA		P_PA
	AND		#D_PA_Press
	CMP		#D_PA_Value
	BNE		L_Scankey_usually_Prog_Countine;不相等跳转
L_Scankey_usually_Prog_RTS:
	RTS
L_Scankey_Effictive_Prog:
	SMB5	Sys_Flag_A
	LDA		#90
	STA		P_Scankey_value_Temporary
	RTS	
L_Scankey_usually_Prog_Countine:
	STA		P_Temp+1;将读取的按键值存储起来
	CMP		#D_PA2_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA2
	CMP		#D_PA3_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA3
	CMP		#D_PA5_PA6_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA5_PA6;先扫描单键单独口的键和多键
	JSR		L_PC_Output_High_Prog
	BBS5	Sys_Flag_A,L_Scankey_Effictive_Prog
	LDA		P_Temp+1
	CMP		#D_PA4_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA4
	CMP		#D_PA5_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA5
	CMP		#D_PA6_Press
	BEQ		L_Scankey_usually_Prog_Countine_PA6
	
	RTS

L_Scankey_usually_Prog_Countine_PA2:
	LDA		#D_B_Press
	STA		P_Scankey_value_Temporary
	RTS

L_Scankey_usually_Prog_Countine_PA3:
	LDA		#D_C_Press
	STA		P_Scankey_value_Temporary
	RTS
L_Scankey_usually_Prog_Countine_PA5_PA6:;
	JSR		L_PC_Output_High_Prog
	LDA		P_Temp+3
	ORA		P_Temp+5
	ORA		P_Temp+6
	ORA		P_Temp+8
	BNE		L_Scankey_Effictive_Prog
	LDA		P_Temp+4	
	BEQ		L_Scankey_Effictive_Prog
	LDA		P_Temp+7
	BEQ		L_Scankey_Effictive_Prog
	LDA		#D_Beep_Test_Press
	STA		P_Scankey_value_Temporary
	RMB5	Sys_Flag_A
	RTS

L_Scankey_usually_Prog_Countine_PA4:
	CLC
	LDA		#0
	ADC		P_Temp+2
	STA		P_Scankey_value_Temporary
	RTS

L_Scankey_usually_Prog_Countine_PA5:
	CLC
	LDA		#7
	ADC		P_Temp+2
	STA		P_Scankey_value_Temporary
	RTS

L_Scankey_usually_Prog_Countine_PA6:
	CLC
	LDA		#14
	ADC		P_Temp+2
	STA		P_Scankey_value_Temporary
	RTS


L_PC_Output_High_Prog:;按键扫描程序
	JSR		L_PA_Intput_Low_Prog
	JSR		L_PC0_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog

	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+3

	JSR		L_PC1_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog

	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+4

	JSR		L_PC2_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog

	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+5

	JSR		L_PC3_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog

	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+6

	JSR		L_PC4_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog

	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+7

	JSR		L_PC5_Output_High_Prog
	JSR		L_ScanKey_Delay_Prog

	LDA		P_PA
	AND		#D_PA_Press
	STA		P_Temp+8



	JSR		L_Scankey_Effictive_Init

	LDA		P_Temp+3
	BNE		L_PC_Output_High_Prog_PC0
	LDA		P_Temp+4
	BNE		L_PC_Output_High_Prog_PC1
	LDA		P_Temp+5
	BNE		L_PC_Output_High_Prog_PC2
	LDA		P_Temp+6
	BNE		L_PC_Output_High_Prog_PC3
	LDA		P_Temp+7
	BNE		L_PC_Output_High_Prog_PC4
	LDA		P_Temp+8
	BNE		L_PC_Output_High_Prog_PC5
	RTS

L_PC_Output_High_Prog_PC0:
	LDA		P_Temp+4
	ORA		P_Temp+5
	ORA		P_Temp+6
	ORA		P_Temp+7
	ORA		P_Temp+8
	BNE		L_Scankey_Effictive_Prog_To
	LDA		#1
	STA		P_Temp+2
	RTS
L_PC_Output_High_Prog_PC1:
	LDA		P_Temp+5
	ORA		P_Temp+6
	ORA		P_Temp+7
	ORA		P_Temp+8
	BNE		L_Scankey_Effictive_Prog_To
	LDA		#2
	STA		P_Temp+2
	RTS
L_PC_Output_High_Prog_PC2:
	LDA		P_Temp+6
	ORA		P_Temp+7
	ORA		P_Temp+8
	BNE		L_Scankey_Effictive_Prog_To
	LDA		#3
	STA		P_Temp+2
	RTS
	
L_PC_Output_High_Prog_PC3:
	LDA		P_Temp+7
	ORA		P_Temp+8
	BNE		L_Scankey_Effictive_Prog_To
	LDA		#4
	STA		P_Temp+2
	RTS
L_PC_Output_High_Prog_PC4:
	LDA		P_Temp+8
	BNE		L_Scankey_Effictive_Prog_To
	LDA		#5
	STA		P_Temp+2
	RTS
L_PC_Output_High_Prog_PC5:
	LDA		#6
	STA		P_Temp+2
	RTS
L_Scankey_Effictive_Prog_To:
	JMP		L_Scankey_Effictive_Prog