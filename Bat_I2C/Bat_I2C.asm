;需要内存：

L_I2C_BatData:
L_SendStart:
	; LDA		R_BOP
	; AND		#BIT0
	; BEQ		L_SendStart_
	; LDA		R_Light_Time
	; BNE		L_End_GetBatData
L_SendStart_:
	LDA		P_PC_DIR_Backup
	AND		#11101111B;PC4   11011111;PC5	;修改
	STA		P_PC_DIR_Backup
;	LDA		P_PCIO
;	AND		#~BIT3
	STA		P_PC_DIR		;将改变的值变为输出
	
	LDA		P_PC_Backup
	AND		#11101111B
	STA		P_PC_Backup		;将对应的口变为输出低
	STA		P_PC
;	LDA		P_PC
;	AND		#~BIT3
;	STA		P_PC




	JSR		Delay_1ms
	JSR		Delay_1ms
	JSR		Delay_1ms
	JSR		Delay_1ms
	JSR		Delay_1ms
	JSR		Delay_1ms
	JSR		Delay_1ms	;7个延时1ms	
	
	SEI							;禁用中断
	LDA		P_PC_DIR_Backup
	ORA		#00010000B			;修改
	STA		P_PC_DIR_Backup
;	LDA		P_PCIO
;	ORA		#020H
	STA		P_PC_DIR
	JSR		Delay_50us		;将对应的I/O口变为输入下拉
;	RTS
L_ReadwWait:
	LDA		#200
	STA		R_Delay
L_ReadwWait_:		
	LDA		P_PC
	AND		#00010000B					;读取对应的口，修改
	BEQ		L_GotoReceiveData
	JSR		Delay_50us
	JSR		Delay_50us
	DEC		R_Delay
	BNE		L_ReadwWait_
	CLI
L_End_GetBatData:
	RTS		;20MS读等待超时
	
L_GotoReceiveData:
	LDA		#0
	STA		R_BatGrade
	STA		R_Delay
L_GotoReceiveData_Bit0_L:
;	JSR		Delay_50us
L_Loop_Bit0_L:	
	LDA		P_PC
	AND		#020H			
	BNE		L_GotoReceiveData_Bit0_H
	JSR		Delay_50us
	INC		R_Delay
	BNE		L_Loop_Bit0_L
	CLI	
	RTS
	
L_GotoReceiveData_Bit0_H:
	LDA		R_Delay
	CMP		#2
	BCC		L_Fail
	CMP		#20
	BCS		L_Fail
	
	LDA		#0
	STA		R_Delay
L_Loop_Bit0_H:
	LDA		P_PC
	AND		#020H
	BEQ		L_GotoReceiveData_Bit1_L
	JSR		Delay_50us
	INC		R_Delay
	BNE		L_Loop_Bit0_H
L_Fail:	
	CLI		
	RTS
	
L_GotoReceiveData_Bit1_L:
	LDA		R_Delay
	CMP		#5
	BCC		L_Fail
	CMP		#40
	BCS		L_Fail
	CMP		#14	;750uS
	BCC		L_Continue_GotoReceiveData_Bit1_L
	INC		R_BatGrade
L_Continue_GotoReceiveData_Bit1_L:
	LDA		#0
	STA		R_Delay	
L_Loop_Bit1_L:	
	LDA		P_PC
	AND		#020H			
	BNE		L_GotoReceiveData_Bit1_H
	JSR		Delay_50us
	INC		R_Delay
	BNE		L_Loop_Bit1_L
	BRA		L_Fail
	
L_GotoReceiveData_Bit1_H:
	LDA		R_Delay
	CMP		#2
	BCC		L_Fail
	CMP		#20
	BCS		L_Fail
	
	LDA		#0
	STA		R_Delay
L_Loop_Bit1_H:
	LDA		P_PC
	AND		#020H		
	BEQ		L_GotoReceiveData_Bit2_L
	JSR		Delay_50us	
	INC		R_Delay
	BNE		L_Loop_Bit1_H
	BRA		L_Fail
	
L_GotoReceiveData_Bit2_L:
	LDA		R_Delay
	CMP		#5
	BCC		L_Fail
	CMP		#40
	BCS		L_Fail
	CMP		#14	;750uS
	BCC		L_Continue_GotoReceiveData_Bit2_L
	INC		R_BatGrade
	INC		R_BatGrade
L_Continue_GotoReceiveData_Bit2_L:	
	LDA		#0
	STA		R_Delay
L_Loop_Bit2_L:
	LDA		P_PC
	AND		#020H			
	BNE		L_GotoReceiveData_Bit2_H
	JSR		Delay_50us
	INC		R_Delay
	BNE		L_Loop_Bit2_L
	BRA		L_Fail	
	
L_GotoReceiveData_Bit2_H:
	LDA		R_Delay
	CMP		#2
	BCC		L_Fail
	CMP		#20
	BCS		L_Fail

	LDA		#0
	STA		R_Delay
L_Loop_Bit2_H:
	LDA		P_PC
	AND		#020H			
	BEQ		L_GotoReceiveData_Bit3_L
	JSR		Delay_50us	
	INC		R_Delay
	BNE		L_Loop_Bit2_H
	JMP		L_Fail

L_GotoReceiveData_Bit3_L:
	LDA		R_Delay
	CMP		#5
	BCC		L_Fail_
	CMP		#40
	BCS		L_Fail_
	CMP		#14	;750uS
	BCC		L_Continue_GotoReceiveData_Bit3_L
	INC		R_BatGrade
	INC		R_BatGrade
	INC		R_BatGrade
	INC		R_BatGrade
L_Continue_GotoReceiveData_Bit3_L:	
	LDA		R_BatGrade
	STA		R_Bat_Data
	; JSR		L_Judge_LowBat
L_Fail_:	
	JMP		L_Fail
	



; L_Judge_LowBat:
; 	LDA		Sys_Flag_C
; 	AND		#BIT1
; 	BNE		L_EndJudgeLowBat
; 	LDA		R_Bat_Data
; 	CMP		#1
; 	BCS		L_EndJudgeLowBat
; 	INC		R_LowBatTime
; L_EndJudgeLowBat:
; 	RTS



Delay_50us:
	LDA		#0F5H
	STA		P_Temp
?LOOP:
	INC		P_Temp
	BNE		?LOOP
	RTS
Delay_1ms:
	LDA		#007H
	STA		P_Temp
?LOOP:
	INC		P_Temp
	BNE		?LOOP
	RTS










