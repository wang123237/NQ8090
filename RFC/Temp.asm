;------------------------------------------------
; PA1 : CAP= 102
; PA3 : RR	= 39K
; PA4 : RT=  10K
; PA5 : (RH303 // 1M) + 510R
;需要修改的地方：L_Temperature_Low，更改测量最低温度。
;L_Temperature_High：测量最高温度
;L_Counter_T_Step2_1：P_TEMP+6控制测量范围
;
;------------------------------------------------
;------------------------------------------------
;------------------------------------------------
;************************************************
;------------------------------------------------
;L_RR_Fail_Program:
;	lda		R_Temperature_L
;	AND		#0	;#$0F
;	ORA		#$10
;	sta		R_Temperature_L
;	LDA		#$BB
;	STA		R_Temperature
;	STA		R_Temperature_F_H
;   STA     R_Temperature_F_M
;	RTS
;   


;------------------------------------------------
;************************************************
;------------------------------------------------
L_Counter_Temperature_Prog:;
        LDA     R_RT_M
        ORA     R_RT_H
		BNE	 	L_OK1	    
        LDA     R_RT_L
		CMP		#10
		BCS		L_OK1	;L_RR_Fail_Program，低温判断
		JMP		L_Temperature_Low
L_OK1:
        LDA     R_RR_M
		ORA     R_RR_H
		BNE		L_OK2
        LDA     R_RR_L
		CMP		#10
		BCS		L_OK2	;L_RR_Fail_Program，判断参考电阻的值
		JMP		L_Temperature_Low;低温判断
L_OK2:	
		CLD
        LDA     R_RT_L
        STA     P_Temp+10 ; 0 ; 3
        LDA     R_RT_M
        STA     P_Temp+11 ; 1 ; 4
        LDA     #0H
        STA     P_Temp+12 ; 2 ; 5

        LDA     R_RR_L
        STA     P_Temp+13 ; 3 ; 0
        LDA     R_RR_M
        STA     P_Temp+14 ; 4 ; 1
        LDA     #0H
        STA     P_Temp+15 ; 5 ; 2

        JSR     L_Counter_T_Sbc_Prog    ;调用减法程序计算比值

        LDA     P_Temp+9
        STA     P_Temp+7
        JSR     L_R0Data_LeftMove4Bit   ;将温度电阻的值左移四位
        JSR     L_Counter_T_Sbc_Prog    ;再次计算比值

        LDA     P_Temp+9
        STA     P_Temp+8
		CLC
		ROL		P_Temp+8
		CLC
		ROL		P_Temp+8
		CLC
		ROL		P_Temp+8
		CLC
		ROL		P_Temp+8
        JSR     L_R0Data_LeftMove4Bit
        JSR     L_Counter_T_Sbc_Prog

        LDA     P_Temp+9
        ORA     P_Temp+8
        STA     P_Temp+8
        JSR     L_R0Data_LeftMove4Bit
        JSR     L_Counter_T_Sbc_Prog    ;将分段的计算结果合并，形成连续的二进制温度值

        CLC
        LDA     #$F8
        ADC     P_Temp+9
        LDA     #0
        ADC     P_Temp+8
        STA     P_Temp+8
        LDA     #0
        ADC     P_Temp+7
        STA     P_Temp+7
        LDA     #0
        STA     P_Temp+6    ;溢出和校准查表
        LDX     #0
		
;		SEC					;xwx
;        LDA     P_Temp+7
;        SBC     #1
;        BCC     L_Counter_T_Step2		
;		SEC
;        LDA     P_Temp+7
;        SBC     #1
;        STA     P_Temp+7	;xwx	;从0度开始这里多减255 		

L_Loop_Counter_T_Step1:
		SEC
        LDA     P_Temp+8
        SBC     Table_Temperature,X 
        LDA     P_Temp+7
        SBC     #0
        BCC     L_Counter_T_Step2
        SEC
        LDA     P_Temp+8
        SBC     Table_Temperature,X
        STA     P_Temp+8
        LDA     P_Temp+7
        SBC     #0
        STA     P_Temp+7
        INX
;        SED
;        CLC
;        LDA     #1
;        ADC     P_Temp+6
;        STA     P_Temp+6
;        CLD
		INC		P_Temp+6	
		
        JMP     L_Loop_Counter_T_Step1

L_Counter_T_Step2:
    LDA     P_Temp+6
    BNE     L_Counter_T_Step2_1
L_Temperature_Low:              ;等于0是说明现在是最低温，
                                ;当小于时跳转到此
;	JMP		L_RR_Fail_Program
	lda		R_Temperature_L
	AND		#0	;#$0F
	ORA		#$9
	STA		R_Temperature_L
	
;	ORA		#$89
;	sta		R_Temperature_L
;	LDA		#09
;	STA		R_Temperature
;	JMP		L_TestOkExit
	RTS


L_Counter_T_Step2_1:
	SEC
    LDA     #59		;-20~70,控制测量范围
    SBC     P_Temp+6
    BCS     L_Counter_T_Step2_2
L_Temperature_High:
	lda		R_Temperature_L
	AND		#0	;#$0F
	ORA		#$50
	sta		R_Temperature_L
;	LDA		#65
;	STA		R_Temperature
;	JMP		L_TestOkExit
	RTS

L_Counter_T_Step2_2:
    JSR     L_Counter_T_Decimals;P_Temp+5是十分位的温度
    SEC
    LDA     P_Temp+6		
    SBC     #41-31		;#52	
    BCS     L_Temperature_Over_0
	LDA		#41-31
	STA		P_Temp
    LDA     P_Temp+5
	BEQ     L_Measure_Small0_Temp_L
	LDA     #40-31
	STA     P_Temp
L_Measure_Small0_Temp_L:
	SEC
    LDA     P_Temp
    SBC     P_Temp+6
    STA     R_Temperature
	
	LDA		P_Temp+5
	BEQ		NoInc
	CMP		#10-7
	BCS		NoInc
	INC		R_Temperature
NoInc:
	
	LDA		R_Temperature
	BNE		Continue
;    LDA     P_Temp+5
;	BNE		Continue
	LDA		#0
	STA		R_Temperature_L	
	JMP		L_Test_Ok
Continue:
	LDA		R_Temperature_L	;P_Temp+5	;
	AND		#$00
	ORA		#$80
	STA		R_Temperature_L ;温度负值标志
	LDA		R_Temperature
	CMP		#9+1	;#21
	BCC		L_End_CounteP_Temp_Small_0
	JMP		L_Temperature_Low
L_End_CounteP_Temp_Small_0:	
	JMP		L_Test_Ok
;========================================
L_Temperature_Over_0:
	STA		R_Temperature

	LDA		#0
	STA		R_Temperature_L

; 	LDA		P_Temp+5
; 	AND		#$0F
; 	CMP		#$07
; 	BCC		Skip
; ;	STA		R_Temperature_L
; 	INC		R_Temperature
Skip:


L_ExitDisDeal:
L_Test_Ok:
	LDA		R_Temperature
	CMP		#50+1 ;#70+1
	BCS		L_Temperature_High
L_TestOkExit:
	LDA		R_Temperature
	JSR		L_A_HexToHexD
	STA		R_Temperature			;*小于100的十六进制转十进制
	RTS
;------------------------------------------------
L_Counter_T_Decimals:
        LDA     #$A
        STA     P_Temp
        LDA     #0
        STA     P_Temp+1
        STA     P_Temp+2
L_Loop_Mul10:           ;将剩下的比值乘以10
        LDA     P_Temp
        BEQ     L_Counter_T_Decimals_1
        CLC
        LDA     P_Temp+8
        ADC     P_Temp+2
        STA     P_Temp+2
        LDA     P_Temp+7
        ADC     P_Temp+1
        STA     P_Temp+1
        DEC     P_Temp
        JMP     L_Loop_Mul10

L_Counter_T_Decimals_1:
        LDA     #0
        STA     P_Temp+5
L_Loop_Counter_T_Decimals:;通过减法得到余数占当前温度的十分之几作为10分位数
		SEC
        LDA     P_Temp+2                                              
        SBC     Table_Temperature,X
        STA     P_Temp+2
        LDA     P_Temp+1
        SBC     #0
        STA     P_Temp+1
        BCC     L_End_Counter_T_Decimals
        INC     P_Temp+5
        JMP     L_Loop_Counter_T_Decimals
L_End_Counter_T_Decimals:
	RTS

;------------------------------------------------
L_R0Data_LeftMove4Bit:
        LDA     #4
        STA     P_Temp
L_Loop_LeftMove4Bit:
        LDA     P_Temp
        BEQ     L_End_R0Data_LeftMove4Bit
;        ASL     P_Temp+10
		CLC
		ROL		P_Temp+10
        ROL     P_Temp+11
        ROL     P_Temp+12
        DEC     P_Temp
        JMP     L_Loop_LeftMove4Bit
L_End_R0Data_LeftMove4Bit:
	RTS

;------------------------------------------------
L_Counter_T_Sbc_Prog:
        LDA     #0
        STA     P_Temp+9
L_Loop_Counter_T_Sbc:;通过循环减法得到比值
		SEC
        LDA     P_Temp+10
        SBC     P_Temp+13
        LDA     P_Temp+11
        SBC     P_Temp+14
        LDA     P_Temp+12
        SBC     P_Temp+15
        BCC     L_End_Counter_T_Sbc_Prog
        SEC
        LDA     P_Temp+10
        SBC     P_Temp+13
        STA     P_Temp+10
        LDA     P_Temp+11
        SBC     P_Temp+14
        STA     P_Temp+11
        LDA     P_Temp+12
        SBC     P_Temp+15
        STA     P_Temp+12
        INC     P_Temp+9
        JMP     L_Loop_Counter_T_Sbc
L_End_Counter_T_Sbc_Prog:
	RTS

;-----------------------------------------------
Table_Temperature:
;--------------------------------------------------
;RR=39K RT=10K
;表的初值是RR*256/RT,后面的值是每个温度的增加值
;--------------------------------------------------
;	DB 28		;-51	
;	DB 1		;-50
;	DB 2        ;-49
;	DB 2        ;-48
;	DB 2        ;-47
;	DB 2        ;-46
;	DB 2        ;-45
;	DB 3        ;-44
;	DB 2        ;-43
;	DB 3        ;-42
;	DB 2        ;-41
;	DB 3		;-40
;	DB 3        ;-39
;	DB 3        ;-38
;	DB 3        ;-37
;	DB 4        ;-36
;	DB 3        ;-35
;	DB 4        ;-34
;	DB 4        ;-33
;	DB 4        ;-32
;	DB 4        ;-31
;	DB 5		;-30
;	DB 4        ;-29
;	DB 5        ;-28
;	DB 5        ;-27
;	DB 6        ;-26
;	DB 5        ;-25
;	DB 6        ;-24
;	DB 6        ;-23
;	DB 7        ;-22
;	DB 7        ;-21
;	DB 147	;7		;-20
;	DB 7        ;-19
;	DB 7        ;-18
;	DB 8        ;-17
;	DB 9        ;-16
;	DB 8        ;-15
;	DB 9        ;-14
;	DB 9        ;-13
;	DB 10       ;-12
;	DB 10       ;-11
;	DB 11		;-10	235	;
	DB 246       ;-9
	DB 11       ;-8
	DB 12       ;-7
	DB 12       ;-6
	DB 13       ;-5
	DB 13       ;-4
	DB 14       ;-3
	DB 14       ;-2
	DB 15       ;-1
;---------------------------	
    DB 16      			  ;0		16		;366-255=111
    DB 16                 ;1
    DB 17                 ;2
    DB 17                 ;3
    DB 18                 ;4
    DB 18                 ;5
    DB 20                 ;6
    DB 20                 ;7
    DB 20                 ;8
    DB 22                 ;9
    DB 22                 ;10
    DB 23                 ;11
    DB 24                 ;12
    DB 25                 ;13
    DB 25                 ;14
    DB 26                 ;15
    DB 28                 ;16
    DB 28                 ;17
    DB 29                 ;18
    DB 31                 ;19
    DB 31                 ;20
    DB 32                 ;21
    DB 34                 ;22
    DB 34                 ;23
    DB 36                 ;24
    DB 36                 ;25
    DB 38                 ;26
    DB 40                 ;27
    DB 40                 ;28
    DB 42                 ;29
    DB 43                 ;30
    DB 44                 ;31
    DB 46                 ;32
    DB 48                 ;33
    DB 48                 ;34
    DB 51                 ;35
    DB 51                 ;36
    DB 54                 ;37
    DB 55                 ;38
    DB 56                 ;39
    DB 59                 ;40
    DB 60                 ;41
    DB 62                 ;42
    DB 64                 ;43
    DB 65                 ;44
    DB 68                 ;45
    DB 69                 ;46
    DB 72                 ;47
    DB 73                 ;48
    DB 76                 ;49
    DB 78                 ;50
    DB 79                 ;51
    DB 82                 ;52
    DB 85                 ;53
    DB 87                 ;54
    DB 89                 ;55
    DB 92                 ;56
    DB 94                 ;57
    DB 96                 ;58
    DB 100                ;59
    DB 102                ;60
	DB 104				  ;61
	DB 108	              ;62
	DB 110	              ;63
	DB 113	              ;64
	DB 116	              ;65
	DB 119	              ;66
	DB 123	              ;67
	DB 125	              ;68
	DB 129	              ;69
	DB 131		          ;70
	DB 136				  ;71
    DB 255             	;-
    DB 255             	;-
    DB 255             	;-
;-----------------------------------------------
;===============================================
;R_Temperature_F_L
;R_Temperature_F_H
;-----------------------------------------------
; L_C_SwitchTo_F_Program:
; 		LDA     #0		;无小数点	LDA     R_Temperature_L 	;
;         STA     P_Temp+2
;         LDA     R_Temperature
;         STA     P_Temp+3
;         LDA     #0
;         STA     P_Temp+4
; 		CLC
; 		ROL		P_Temp+2
; 		CLC
; 		ROL		P_Temp+2
; 		CLC
; 		ROL		P_Temp+2
; 		CLC
; 		ROL		P_Temp+2
;         SED
;         CLC
;         LDA     P_Temp+2
;         ADC     P_Temp+2
;         STA     P_Temp+2
;         LDA     P_Temp+3
;         ADC     P_Temp+3
;         STA     P_Temp+3
;         LDA     P_Temp+4
;         ADC     P_Temp+4
;         STA     P_Temp+4
;         CLD
;         LDA     #0
;         STA     P_Temp+5
;         STA     P_Temp+6
;         STA     P_Temp+7
;         LDA     #9
;         STA     P_Temp+1
; L_C_SwitchTo_F_Multiply9:
;         LDA     P_Temp+1
;         BEQ     L_Judge_TF_LL_Over_5
;         SED
;         CLC
;         LDA     P_Temp+2
;         ADC     P_Temp+5
;         STA     P_Temp+5
;         LDA     P_Temp+3
;         ADC     P_Temp+6
;         STA     P_Temp+6
;         LDA     P_Temp+4
;         ADC     P_Temp+7
;         STA     P_Temp+7
;         CLD
;         DEC     P_Temp+1
;         JMP     L_C_SwitchTo_F_Multiply9
; L_Judge_TF_LL_Over_5:
;         LDA     P_Temp+5
;         SBC     #$50
;         BCC     L_C_SwitchTo_F_Adc32
;         SED
;         CLC
;         LDA     #$01
;         ADC     P_Temp+6
;         STA     P_Temp+6
;         LDA     #00
;         ADC     P_Temp+7
;         STA     P_Temp+7
; 		CLD
; L_C_SwitchTo_F_Adc32:
; ;		LDA		R_RTRH_Flag	;负温度
; ;		AND		#$80
; 		LDA		R_Temperature_L
; 		AND		#$80

; 		BNE		L_C_SwitchTo_F_32Sub
;         SED
;         CLC
;         LDA     #$20
;         ADC     P_Temp+6
;         STA     P_Temp+6
;         LDA     #03
;         ADC     P_Temp+7
;         STA     P_Temp+7
; 		CLD
; L_Exit_C_SwitchTo_F_Prog:
;         LDA      P_Temp+6
;         STA      R_Temperature_F_M
;         LDA      P_Temp+7
;         STA      R_Temperature_F_H ;BIT8为1代表显示-F
; 		RTS

; L_C_SwitchTo_F_32Sub:
; 	SED
; 	SEC
; 	LDA		#$20
; 	SBC		P_Temp+6
; 	LDA		#$03
; 	SBC		P_Temp+7
; 	BCS		L_yuanlai	;F值为正
; 	SEC
; 	LDA		P_Temp+6
; 	SBC		#$20
; 	STA		P_Temp+6
; 	LDA		P_Temp+7
; 	SBC		#$03
; 	ORA		#$80
; 	STA		P_Temp+7	;BIT7为显示-F
; 	CLD
; 	JMP		L_Exit_C_SwitchTo_F_Prog
; L_yuanlai:
; 	LDA		#$20
; 	SBC		P_Temp+6
; 	STA		P_Temp+6
; 	LDA		#$03
; 	SBC		P_Temp+7
; 	STA		P_Temp+7
; 	CLD
; 	JMP		L_Exit_C_SwitchTo_F_Prog
; ;-------------------------------------------------------
; ;*******************************************************
; ;-------------------------------------------------------
