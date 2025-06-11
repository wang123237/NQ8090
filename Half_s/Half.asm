L_Half_Second_Prog:
	BBR0 	Sys_Flag_B,L_END_Half_Second_Prog	;判断半秒标志
	RMB0 	Sys_Flag_B							;清楚半秒标志
	LDA		R_Reset_Time
	BNE		L_Reset_2s_Prog
	BBS1	Sys_Flag_B,L_1Second_Prog			;判断一秒标志
	SMB1	Sys_Flag_B							;设置1秒标志
	; JSR		L_SysFlash_Prog						;闪烁程序	
L_END_Half_Second_Prog:
    RTS
;=================================================================
L_1Second_Prog:
    RMB1    Sys_Flag_B;清除1秒标志  
	JSR     L_Update_Time_Prog
; 	JSR		L_Alarm_Prog
; 	JSR		L_Control_Timer_Prog
; 	LDA		R_Time_Sec
; 	CMP		#30
; 	BNE		L_1Second_Prog_Countine
; 	JSR 	F_RfcTest
; 	JSR		L_Display_Temp_Prog
; L_1Second_Prog_Countine:
; 	JSR		L_Display_Normal_Prog		
	RTS
;==============================================================
L_Reset_2s_Prog:;全显
	DEC		R_Reset_Time
	LDA		R_Reset_Time
	BNE		L_End_Reset_2s_Prog
	JSR		L_Clr_All_DisRam_Prog
	JSR		L_Display_Prog
	JSR		L_Display_Prog_Init
	JSR		L_Display_Timer_Prog
	JSR		L_Clr_All_TurnPlate_Prog
	JSR		L_Display_Temp_Prog
	JSR		L_Display_Beep_Sclient_Prog
	RTS
L_End_Reset_2s_Prog:
	RTS
