;------------------------------------------------------
L_Init_SystemRam_Prog:     ;初始化系统RAM的程序数据
	LDA		#4
	STA		R_Reset_Time
	LDA		#25
	STA		R_Time_Year
	LDA		#1
	STA		R_Time_Day
	STA		R_Time_Month
	; LDA		#4
	; STA		R_Mode
	JSR		L_Auto_Counter_Week

	RTS
;======================================================
L_Dis_All_DisRam_Prog:
	LDA		#$FF
L_All_DisRam:	
	LDX		#0	
L_Loop_DisplayRam:
	STA		LCD_RamAddr,X
	INX	
	CPX		#D_LCD_RAM
	BCC		L_Loop_DisplayRam    ;C=0是跳转
	RTS
;----------------------------------------------------
L_Clr_All_DisRam_Prog:
	LDA		#0
	BRA		L_All_DisRam	

L_Scankey_INIT:
	LDA		#11111101B;
	STA		P_PA_IO;PA0输出,其余输入   
	LDA		#10001101B
	STA		P_PA	;其他全部下拉
	LDA		#01111100B
	STA		P_PA_WAKE;	将PA做唤醒	
	LDA		#0
	STA		P_PC_IO
	STA		P_PC
	RTS

L_Judgement_Scankey_Prog:
	; LDA		#11111101B;
	; STA		P_PA_IO;PA0输出,其余输入   
	LDA		#10001101B
	STA		P_PA	;其他全部下拉
	LDA		#0
	STA		P_PC;PC口输出0
	RTS
L_PA_Intput_Low_Prog:
	LDA		#11111101B
	STA		P_PA
	RTS
L_PC0_Output_High_Prog:
	LDA		#01H
	STA		P_PC
	RTS
L_PC1_Output_High_Prog:
	LDA		#02H
	STA		P_PC
	RTS
L_PC2_Output_High_Prog:
	LDA		#04H
	STA		P_PC
	RTS
L_PC3_Output_High_Prog:
	LDA		#08H
	STA		P_PC
	RTS

L_PC4_Output_High_Prog:
	LDA		#10H
	STA		P_PC
	RTS

L_PC5_Output_High_Prog:
	LDA		#20H
	STA		P_PC
	RTS

; L_PA257_Input_Low:
; 	LDA		#10101101B	
; 	STA		P_PA	;其他全部下拉
; 	RTS
; L_PA257_Input_High:
; 	LDA		#00000001B	
; 	STA		P_PA
; 	RTS
L_Scankey_Effictive_Init:
	LDA		#11110001B;
	STA		P_PA
	LDA		#0
	STA		P_PC
	RTS
