L_Display_Timer_Min_Prog:
    LDA     R_Timer_Min
    AND     #F0H
    LDX     #lcd_d19
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA     R_Timer_Min
    AND     #0FH
    LDX     #lcd_d19
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS
L_Display_Timer_Sec_Prog:
    LDA     R_Timer_Sec
    AND     #F0H
    LDX     #lcd_d20
    JSR     L_Dis_8Bit_DigitDot_Prog
    LDA     R_Timer_Sec
    AND     #0FH
    LDX     #lcd_d21
    JSR     L_Dis_8Bit_DigitDot_Prog
    RTS









L_Display_Timer_TurnPlate_Prog:
    JSR     L_Display_S60_Prog
    CLC
    ClD
    LDA     R_Timer_Min
    ROL
    TAX
    LDA     Table_TurnPlate_Display+1,X
    PHA
    LDA     Table_TurnPlate_Display,X
    PHA
    RTS
 Table_TurnPlate_Display:
    DW      L_Display_S0_Prog-1
    DW      L_Display_S1_Prog-1
    DW      L_Display_S2_Prog-1
    DW      L_Display_S3_Prog-1
    DW      L_Display_S4_Prog-1
    DW      L_Display_S5_Prog-1
    DW      L_Display_S6_Prog-1
    DW      L_Display_S7_Prog-1
    DW      L_Display_S8_Prog-1
    DW      L_Display_S9_Prog-1
    DW      L_Display_S10_Prog-1
    DW      L_Display_S11_Prog-1
    DW      L_Display_S12_Prog-1
    DW      L_Display_S13_Prog-1
    DW      L_Display_S14_Prog-1
    DW      L_Display_S15_Prog-1
    DW      L_Display_S16_Prog-1
    DW      L_Display_S17_Prog-1
    DW      L_Display_S18_Prog-1
    DW      L_Display_S19_Prog-1
    DW      L_Display_S20_Prog-1
    DW      L_Display_S21_Prog-1
    DW      L_Display_S22_Prog-1
    DW      L_Display_S23_Prog-1
    DW      L_Display_S24_Prog-1
    DW      L_Display_S25_Prog-1
    DW      L_Display_S26_Prog-1
    DW      L_Display_S27_Prog-1
    DW      L_Display_S28_Prog-1
    DW      L_Display_S29_Prog-1
    DW      L_Display_S30_Prog-1
    DW      L_Display_S31_Prog-1
    DW      L_Display_S32_Prog-1
    DW      L_Display_S33_Prog-1
    DW      L_Display_S34_Prog-1
    DW      L_Display_S35_Prog-1
    DW      L_Display_S36_Prog-1
    DW      L_Display_S37_Prog-1
    DW      L_Display_S38_Prog-1
    DW      L_Display_S39_Prog-1
    DW      L_Display_S40_Prog-1
    DW      L_Display_S41_Prog-1
    DW      L_Display_S42_Prog-1
    DW      L_Display_S43_Prog-1
    DW      L_Display_S44_Prog-1
    DW      L_Display_S45_Prog-1
    DW      L_Display_S46_Prog-1
    DW      L_Display_S47_Prog-1
    DW      L_Display_S48_Prog-1
    DW      L_Display_S49_Prog-1
    DW      L_Display_S50_Prog-1
    DW      L_Display_S51_Prog-1
    DW      L_Display_S52_Prog-1
    DW      L_Display_S53_Prog-1
    DW      L_Display_S54_Prog-1
    DW      L_Display_S55_Prog-1
    DW      L_Display_S56_Prog-1
    DW      L_Display_S57_Prog-1
    DW      L_Display_S58_Prog-1
    DW      L_Display_S59_Prog-1

;===========================================================
L_Clr_Timer_TurnPlate_Prog:
    ; JSR     L_Clr_S60_Prog
    CLC
    ClD
    LDA     R_Timer_Min
    ROL
    TAX
    LDA     Table_TurnPlate_Clr+1,X
    PHA
    LDA     Table_TurnPlate_Clr,X
    PHA
    RTS
 Table_TurnPlate_Clr:
    DW      L_Clr_S0_Prog-1
    DW      L_Clr_S1_Prog-1
    DW      L_Clr_S2_Prog-1
    DW      L_Clr_S3_Prog-1
    DW      L_Clr_S4_Prog-1
    DW      L_Clr_S5_Prog-1
    DW      L_Clr_S6_Prog-1
    DW      L_Clr_S7_Prog-1
    DW      L_Clr_S8_Prog-1
    DW      L_Clr_S9_Prog-1
    DW      L_Clr_S10_Prog-1
    DW      L_Clr_S11_Prog-1
    DW      L_Clr_S12_Prog-1
    DW      L_Clr_S13_Prog-1
    DW      L_Clr_S14_Prog-1
    DW      L_Clr_S15_Prog-1
    DW      L_Clr_S16_Prog-1
    DW      L_Clr_S17_Prog-1
    DW      L_Clr_S18_Prog-1
    DW      L_Clr_S19_Prog-1
    DW      L_Clr_S20_Prog-1
    DW      L_Clr_S21_Prog-1
    DW      L_Clr_S22_Prog-1
    DW      L_Clr_S23_Prog-1
    DW      L_Clr_S24_Prog-1
    DW      L_Clr_S25_Prog-1
    DW      L_Clr_S26_Prog-1
    DW      L_Clr_S27_Prog-1
    DW      L_Clr_S28_Prog-1
    DW      L_Clr_S29_Prog-1
    DW      L_Clr_S30_Prog-1
    DW      L_Clr_S31_Prog-1
    DW      L_Clr_S32_Prog-1
    DW      L_Clr_S33_Prog-1
    DW      L_Clr_S34_Prog-1
    DW      L_Clr_S35_Prog-1
    DW      L_Clr_S36_Prog-1
    DW      L_Clr_S37_Prog-1
    DW      L_Clr_S38_Prog-1
    DW      L_Clr_S39_Prog-1
    DW      L_Clr_S40_Prog-1
    DW      L_Clr_S41_Prog-1
    DW      L_Clr_S42_Prog-1
    DW      L_Clr_S43_Prog-1
    DW      L_Clr_S44_Prog-1
    DW      L_Clr_S45_Prog-1
    DW      L_Clr_S46_Prog-1
    DW      L_Clr_S47_Prog-1
    DW      L_Clr_S48_Prog-1
    DW      L_Clr_S49_Prog-1
    DW      L_Clr_S50_Prog-1
    DW      L_Clr_S51_Prog-1
    DW      L_Clr_S52_Prog-1
    DW      L_Clr_S53_Prog-1
    DW      L_Clr_S54_Prog-1
    DW      L_Clr_S55_Prog-1
    DW      L_Clr_S56_Prog-1
    DW      L_Clr_S57_Prog-1
    DW      L_Clr_S58_Prog-1
    DW      L_Clr_S59_Prog-1

    