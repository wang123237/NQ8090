;===========================================================
;程序功能：	显示8BIT字段
;程序入口：	A =  显示内容
;			X =  ofc	
;影响资源：P_Temp，P_Temp+1，P_Temp+2，P_Temp+3,X，A
;===========================================================
L_Dis_8Bit_DigitDot_Prog:
;	STA		P_Temp
;	LDA		Table_Digit_Addr_Offset,X
	STX		P_Temp+1;显示在那个位置上
	TAX
	LDA		Table_Digit_DataDot,X;查要显示的数对应的段码
	LDX		P_Temp+1
F_DispPro:	
	STA		P_Temp;保存显示的数对应的段码
	STX		P_Temp+1;再次保存显示位置
	LDA		#7
	STA		P_Temp+3	;显示段数
L_Judge_Dis_8Bit_DigitDot:;显示循环的开始
	LDX		P_Temp+1	;加载位置索引到x
	LDA		Lcd_bit,X	;加载com线
	STA		P_Temp+2	
	LDA		Lcd_byte,X	;加载SEG线
	TAX
	ROR		P_Temp		;循环右移
	BCC		L_CLR		;c=0是清除
	LDA		LCD_RamAddr,X	;加载LCD RAM地址
	ORA		P_Temp+2		;将COM和SEG信息与LCD RAM地址进行逻辑或操作
	STA		LCD_RamAddr,X	;将结果写回LCD RAM，更新显示
	BRA		L_Inc_Dis_Index_Prog	;跳转到显示索引增加的子程序。
L_CLR:	
	LDA		LCD_RamAddr,X	;加载LCD RAM的地址
	ORA		P_Temp+2		;将COM和SEG信息与LCD RAM地址进行逻辑或操作
	EOR		P_Temp+2		;进行异或操作，用于清除对应的段。
	STA		LCD_RamAddr,X	;将结果写回LCD RAM，清除对应位置。
L_Inc_Dis_Index_Prog:		;增加显示索引，减少显示段数
	INC		P_Temp+1		;增加P_Temp+1（位置索引）
	DEC		P_Temp+3		;减少P_Temp+3（段数
	BNE		L_Judge_Dis_8Bit_DigitDot	;如果段数不为0，回到循环开始，否则退出
	RTS
	
F_DispPro_8bit:
	STA		P_Temp			;保存段码的值
	STX		P_Temp+1
	LDA		#8
	STA		P_Temp+3	;显示段数
	BRA		L_Judge_Dis_8Bit_DigitDot
;-----------------------------------------
F_DispSymbol:		;input Xcc -> ofs
	JSR		F_DispSymbol_Com	
	STA		LCD_RamAddr,X	;实现显示
	RTS

F_ClrpSymbol:		;input Xcc -> ofs
	JSR		F_DispSymbol_Com	;清除显示
	EOR		P_Temp+2
	STA		LCD_RamAddr,X
	RTS

F_DispSymbol_Com:	
	LDA		Lcd_bit,X	;加载X寄存器对应的COM线
	STA		P_Temp+2	
	LDA		Lcd_byte,X	;加载X寄存器对应的SEG线
	TAX
	LDA		LCD_RamAddr,X;加载LCD	RAM	地址
	ORA		P_Temp+2
	RTS
;============================================================
;===============================================
L_ROR_4Bit_Prog:
L_ROR4Bit_Prog:
L_LSR4Bit_Prog:
F_MSBToLSB:
	ROR		
	ROR		
	ROR		
	ROR		
	AND		#$0F
	RTS
L_ROL_4Bit_Prog:
	ROL
	ROL
	ROL
	ROL
	AND		#F0H
	RTS
;================================================
;********************************************	
Table_Digit_DataDot:	;显示内容对应显示的段码
           ;hgfedcba
	.BYTE 	3fh	;0
	.BYTE	06h	;1
	.BYTE	5bh	;2
	.BYTE	4fh	;3
	.BYTE	66h	;4	
	.BYTE	6dh	;5
	.BYTE	7dh	;6
	.BYTE	27h	;7		
	.BYTE	7fh	;8
	.BYTE	6fh	;9
	.BYTE	00h	;清除10
	.BYTE	01000000B;负号11
	.BYTE	01110110B;H12
	.BYTE	01010000B;r13
	.BYTE	00110111B;N	14
	.BYTE	00110001B;T的左边15
	.BYTE	00111110B;U.16
	.BYTE	01111001B;E.17
	.BYTE	01110111B;A.18
	.BYTE	01110001B;F	19	
	.BYTE	00111000B;L	20
	.BYTE	01110011B;P	21
	.BYTE	00001000B;一条横杠22



