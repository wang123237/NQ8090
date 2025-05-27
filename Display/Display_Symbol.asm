RTS_1:
    RTS
L_DIS_SNZ_Normal_Prog:
    BBR7    Sys_Flag_C,RTS_1
    JSR     L_Dis_lcd_Snz_Prog
    RTS
L_Dis_Alm_Snz_Symbol_Noraml_Prog:
    BBS4    Sys_Flag_C,L_Dis_Alm_Snz_Symbol_Prog_Normal
    RTS
L_Dis_Alm_Snz_Symbol_Prog:
    LDA     R_Mode
    CMP     #1
    BEQ     RTS_1
L_Dis_Alm_Snz_Symbol_Prog_Normal:    
    LDA     R_Alarm_Mode
    BEQ     RTS_1_1
    JSR     L_Dis_lcd_Alm_Prog
    LDA     R_Alarm_Mode
    CMP     #2
    BNE     RTS_1_2
    JSR     L_Dis_lcd_Snz_Prog
    RTS
RTS_1_1:
    JSR     L_Clr_lcd_Alm_Prog
RTS_1_2
    JSR     L_Clr_lcd_Snz_Prog
    RTS
L_Dis_sig_Prog:
    LDA     R_Mode
    CMP     #1
    BEQ     RTS_1
    BBR1    Sys_Flag_C,RTS_1
    JSR     L_Dis_lcd_Sig_Prog
    RTS
L_Dis_col_Prog:
    LDA     R_Mode
    CMP     #1
    BEQ     RTS_1
    LDX     #lcd_col
    JSR     F_DispSymbol
    LDX     #lcd_col2
L_Dis_Symbol_Prog:
    JSR     F_DispSymbol
    RTS
L_Dis_lcd_9H_Prog:	
	LDX     #lcd_9H	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_10I_Prog:	
    LDX     #lcd_10I	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_10H_Prog:	
	LDX     #lcd_10H		
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_10J_Prog:		
    LDX     #lcd_10J	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Alm_Prog:	
    LDX     #lcd_ALM	
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Snz_Prog:	
    LDX     #lcd_SNZ
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_Sig_Prog:		
    LDX     #lcd_SIG 
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_AM_Prog:	
    LDX     #lcd_AM 
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_PM_Prog:
    LDX     #lcd_PM
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T1_Prog:
    LDX     #lcd_T1
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_T2_Prog:
    LDX     #lcd_T2
    BRA		L_Dis_Symbol_Prog
L_Dis_lcd_T3_Prog:
    LDX     #lcd_T3
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T4_Prog:
    LDX     #lcd_T4
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T5_Prog:
    LDX     #lcd_T5
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T6_Prog:
    LDX     #lcd_T6
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T7_Prog:
    LDX     #lcd_T7
    BRA		L_Dis_Symbol_Prog

L_Dis_lcd_T8_Prog:
    LDX     #lcd_T8
    BRA		L_Dis_Symbol_Prog



;================================


    			
L_Clr_col_Prog:
    LDX     #lcd_col
    JSR     F_ClrpSymbol
    LDX     #lcd_col2
L_Clr_Symbol_Prog:
    JSR     F_ClrpSymbol
    RTS

L_Clr_lcd_Alm_Prog:	
    LDX     #lcd_ALM	
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_Snz_Prog:	
    LDX     #lcd_SNZ
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_Sig_Prog:		
    LDX     #lcd_SIG 
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_AM_Prog:	
    LDX     #lcd_AM 
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_PM_Prog:
    LDX     #lcd_PM
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T1_Prog:
    LDX     #lcd_T1
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_T2_Prog:
    LDX     #lcd_T2
    BRA		L_Clr_Symbol_Prog
L_Clr_lcd_T3_Prog:
    LDX     #lcd_T3
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T4_Prog:
    LDX     #lcd_T4
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T5_Prog:
    LDX     #lcd_T5
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T6_Prog:
    LDX     #lcd_T6
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T7_Prog:
    LDX     #lcd_T7
    BRA		L_Clr_Symbol_Prog

L_Clr_lcd_T8_Prog:
    LDX     #lcd_T8
    BRA		L_Clr_Symbol_Prog


;==================================
L_Clr_lcd_d1_Prog:
    LDX     #lcd_d1
L_Clr_lcd_usually_Prog:
    LDA     #22
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS
L_Clr_lcd_d2_Prog:
    LDX     #lcd_d2
    BRA     L_Clr_lcd_usually_Prog
L_Clr_lcd_d3_Prog:
    LDX     #lcd_d3
    BRA     L_Clr_lcd_usually_Prog
L_Clr_lcd_d4_Prog:
    LDX     #lcd_d4
    BRA     L_Clr_lcd_usually_Prog
L_Clr_lcd_d5_Prog:
    LDX     #lcd_d5
    BRA     L_Clr_lcd_usually_Prog
L_Clr_lcd_d6_Prog:
    LDX     #lcd_d6
    BRA     L_Clr_lcd_usually_Prog
L_Clr_lcd_d7_Prog:
    LDX     #lcd_d7
    BRA     L_Clr_lcd_usually_Prog
L_Clr_lcd_d8_Prog:
    LDX     #lcd_d8
    BRA     L_Clr_lcd_usually_Prog

L_Display_lcd_Involution_Prog_Normal:
    LDA     R_Involution
    BEQ     L_Display_lcd_Involution_Prog_RTS
L_Display_lcd_Involution_Prog:
    LDX     #lcd_Involution
    JSR     F_DispSymbol
    ; LDX     #lcd_Mul
    ; JSR     F_DispSymbol
L_Display_lcd_Involution_Prog_RTS:
    RTS
L_Display_lcd_Plus_Prog:
    LDX     #lcd_Plus
    JSR     F_DispSymbol
    RTS
L_Display_lcd_SUB_Prog:
    LDX     #lcd_SUB
    JSR     F_DispSymbol
    RTS
L_Display_lcd_Mul_Prog:
    LDX     #lcd_Mul
    JSR     F_DispSymbol
    RTS
L_Display_lcd_DIV_Prog:
    LDX     #lcd_DIV
    JSR     F_DispSymbol
    RTS
L_Clr_Calculator_Symbol_Prog:
    LDX     #lcd_Involution
    JSR     F_ClrpSymbol
L_Clr_Calculator_Symbol_Prog_1: 
    LDX     #lcd_Plus
    JSR     F_ClrpSymbol
    LDX     #lcd_SUB
    JSR     F_ClrpSymbol
    LDX     #lcd_Mul
    JSR     F_ClrpSymbol
    LDX     #lcd_DIV
    JSR     F_ClrpSymbol
    
    RTS


L_Dis_Calculator_Symbol_Prog:
    JSR     L_Clr_Calculator_Symbol_Prog
    JSR     L_Display_lcd_Involution_Prog_Normal 
    CLC
    CLD
    LDA     Calculator_Symbol_State
    ROL
    TAX
    LDA     Table_Calc_Symbol+1,X
    PHA
    LDA     Table_Calc_Symbol,X
    PHA
    RTS
Table_Calc_Symbol:
    DW      RET-1
    DW      L_Display_lcd_Plus_Prog-1
    DW      L_Display_lcd_SUB_Prog-1
    DW      L_Display_lcd_Mul_Prog-1
    DW      L_Display_lcd_DIV_Prog-1

L_Dis_Calculator_Symbol_Prog_Equal:
    LDA     R_Involution
    BNE     L_Dis_Calculator_Symbol_Prog_Equal_RTS
    JSR     L_Clr_Calculator_Symbol_Prog
L_Dis_Calculator_Symbol_Prog_Equal_RTS:
    RTS
