;============================================================
L_control_Beep_prog:
	LDA		R_Voice_Unit;闹铃持续的次数时间
	BEQ		L_control_Beep_prog_out
	CLC
	LDA		R_Alarm_Clock_Open_Beep_Time
	ADC		#1
	STA		R_Alarm_Clock_Open_Beep_Time
	CMP		#2
	BCS		L_Open_Beep_Prog
L_control_Beep_prog_out:
	RTS
	

; ;---------------------------------------------------------------------
L_Open_Beep_Prog:
	LDA		#0
	STA		R_Alarm_Clock_Open_Beep_Time
	BBR7	P_TMRCTRL,L_Open_Beep_Prog_1
	SEC
	LDA		R_Voice_Unit
	SBC		#1
	STA		R_Voice_Unit

L_Close_Beep_Prog:	
	LDA		#$00  	
	STA		P_AUD
	RMB7	P_TMRCTRL	;关闭声音输出
	RMB0	P_SYSCLK ;Weak	
	PB2_PB2_NOMS
	; LDA		#0
	; STA		P_PB
	RTS
;--------------------------------------
L_Open_Beep_Prog_1:
	PB2_PWM
	SMB7	P_DIVC		
	SMB0	P_SYSCLK ;STRONG
	LDA		#$FF   
	STA		P_AUD
	SMB7	P_TMRCTRL	;打开声音输出
	RTS
;==========================================
; L_Scankey_Short_ST_SP_Press_Prog_Alarm:
; 	SMB3	Sys_Flag_C
; ;====================================================
; L_Scankey_Close_Alarm_Beep:
; 	LDA		Sys_Flag_C
; 	AND		#10h
; 	BEQ		L_Scankey_Close_Alarm_Beep_OUT
; 	JSR		L_Close_Beep_Prog
; 	LDA		#0
; 	STA		R_Voice_Unit
; 	STA		R_Close_Beep_Time
; 	RMB4	Sys_Flag_C
; 	BBS3	Sys_Flag_C,L_Scankey_Close_Alarm_Beep_Close_Snz
; 	LDA		R_Snz_Frequency
; 	BNE		L_Scankey_Close_Alarm_Beep_2
; L_Scankey_Close_Alarm_Beep_Close_Snz:
; 	RMB3	Sys_Flag_C
; 	LDA		#0
; 	STA		R_Snz_Time
; 	STA		R_Snz_Frequency
; 	RMB7	Sys_Flag_C
; L_Scankey_Close_Alarm_Beep_2:
; 	LDA		R_Mode
; 	CMP		#1
; 	BEQ		L_Scankey_Close_Alarm_Beep_Clr_Alarm_Prog
; 	JSR		L_Clr_All_DisRam_Prog
; 	JSR		L_Display_Prog
; L_Scankey_Close_Alarm_Beep_OUT:	
; 	RTS
; L_Scankey_Close_Alarm_Beep_Clr_Alarm_Prog:
; 	JSR		L_Clr_lcd_Alm_Prog
	; RTS
L_Scankey_Close_Alarm_Beep:
L_Close_Timer_Beep_Prog:
	RTS





L_Control_Beep_prog_Auto_Exit:;多久自动退出响闹,如果没有则按每秒给值
	; LDA		Sys_Flag_C
	; AND		#10H
	; BEQ		L_Scankey_Close_Alarm_Beep_OUT
	; SEC
	; LDA		R_Close_Beep_Time
	; SBC		#1
	; STA		R_Close_Beep_Time;定时器
	; BEQ		L_Scankey_Close_Alarm_Beep
	; EN_LCD_IRQ
	; LDA		#2
	; STA		R_Voice_Unit
	; BBS4	Sys_Flag_D,L_Scankey_Close_Alarm_Beep_OUT
    RTS
