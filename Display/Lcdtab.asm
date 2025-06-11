;--------COM------------
c0	.equ	0
c1	.equ	1
c2	.equ	2
c3	.equ	3
c4	.equ	4
c5	.equ	5
c6	.equ	6
c7	.EQU	7
;;--------SEG------------
; s47	.equ	47
; s46	.equ	46
; s45	.equ	45
; s44	.equ	44
; s43	.equ	43
; s42	.equ	42
; s41	.equ	41
; s40	.equ	40
s39	.equ	39
s38	.equ	38
s37	.equ	37
s36	.equ	36
s35	.equ	35
s34	.equ	34
s33	.equ	33
s32	.equ	32
s31	.equ	31
s30	.equ	30
s29	.equ	29
s28	.equ	28
s27	.equ	27
s26	.equ	26
s25	.equ	25
s24	.equ	24
s23	.equ	23
s22	.equ	22
s21	.equ	21
s20	.equ	20
; s19	.equ	19
; s18	.equ	18
; s17	.equ	17
; s16	.equ	16
s15	.equ	15
s14	.equ	14
s13	.equ	13
s12	.equ	12
s11	.equ	11
s10	.equ	10
s9	.equ	9
s8	.equ	8
s7	.equ	7
; s6	.equ	6
; s5	.equ	5
; s4	.equ	4
; s3	.equ	3
; s2	.equ	2
; s1	.equ	1
; s0	.equ	0


.MACRO  db_c_s	com,seg
          .BYTE com*5+seg/8
.ENDMACRO

.MACRO  db_c_y	com,seg
	      .BYTE 1.shl.(seg-seg/8*8)
.ENDMACRO

Lcd_byte:	;段码
lcd_table1:
lcd_d1 .equ	lcd_table1-lcd_table1
	db_c_s	c0,s7	;;1A
	db_c_s	c2,s7	;;1B
	db_c_s	c5,s7	;;1C
	db_c_s	c6,s7	;;1D
	db_c_s	c4,s7	;;1E
	db_c_s	c1,s7	;;1F
	db_c_s	c3,s7	;;1G

lcd_d2	.equ	lcd_d1+7
	db_c_s	c0,s8	;;2A
	db_c_s	c2,s8	;;2B
	db_c_s	c5,s8	;;2C
	db_c_s	c6,s8	;;2D
	db_c_s	c4,s8	;;2E
	db_c_s	c1,s8	;;2F
	db_c_s	c3,s8	;;2G

lcd_d3	.equ	lcd_d2+7
	db_c_s	c0,s9	;;3A
	db_c_s	c2,s9	;;3B
	db_c_s	c5,s9	;;3C
	db_c_s	c6,s9	;;3D
	db_c_s	c4,s9	;;3E
	db_c_s	c1,s9	;;3F
	db_c_s	c3,s9	;;3G

lcd_d4	.equ	lcd_d3+7
	db_c_s	c0,s10	;;4A
	db_c_s	c2,s10	;;4B
	db_c_s	c5,s10	;;4C
	db_c_s	c6,s10	;;4D
	db_c_s	c4,s10	;;4E
	db_c_s	c1,s10	;;4F
	db_c_s	c3,s10	;;4G

lcd_d5	.equ	lcd_d4+7
	db_c_s	c0,s11	;;5A
	db_c_s	c2,s11	;;5B
	db_c_s	c5,s11	;;5C
	db_c_s	c6,s11	;;5D
	db_c_s	c4,s11	;;5E
	db_c_s	c1,s11	;;5F
	db_c_s	c3,s11	;;5G

lcd_d6	.equ	lcd_d5+7
	db_c_s	c0,s20	;;6A
	db_c_s	c2,s20	;;6B
	db_c_s	c5,s20	;;6C
	db_c_s	c6,s20	;;6D
	db_c_s	c4,s20	;;6E
	db_c_s	c1,s20	;;6F
	db_c_s	c3,s20	;;6G

lcd_d7	.equ	lcd_d6+7
	db_c_s	c0,s22	;;7A
	db_c_s	c2,s22	;;7B
	db_c_s	c5,s22	;;7C
	db_c_s	c6,s22	;;7D
	db_c_s	c4,s22	;;7E
	db_c_s	c1,s22	;;7F
	db_c_s	c3,s22	;;7G

lcd_d8	.equ	lcd_d7+7
	db_c_s	c0,s23	;;8A
	db_c_s	c2,s23	;;8B
	db_c_s	c5,s23	;;8C
	db_c_s	c6,s23	;;8D
	db_c_s	c4,s23	;;8E
	db_c_s	c1,s23	;;8F
	db_c_s	c3,s23	;;8G

lcd_d14	.equ	lcd_d8+7
	db_c_s	c7,s35	;;14A
	db_c_s	c5,s35	;;14B
	db_c_s	c2,s35	;;14C
	db_c_s	c1,s35	;;14D
	db_c_s	c3,s35	;;14E
	db_c_s	c6,s35	;;14F
	db_c_s	c4,s35	;;14G

lcd_d15	.equ	lcd_d14+7
	db_c_s	c7,s36	;;15A
	db_c_s	c5,s36	;;15B
	db_c_s	c2,s36	;;15C
	db_c_s	c1,s36	;;15D
	db_c_s	c3,s36	;;15E
	db_c_s	c6,s36	;;15F
	db_c_s	c4,s36	;;15G

lcd_d16	.equ	lcd_d15+7
	db_c_s	c7,s37	;;16A
	db_c_s	c5,s37	;;16B
	db_c_s	c2,s37	;;16C
	db_c_s	c1,s37	;;16D
	db_c_s	c3,s37	;;16E
	db_c_s	c6,s37	;;16F
	db_c_s	c4,s37	;;16G

lcd_d17	.equ	lcd_d16+7
	db_c_s	c7,s38	;;17A
	db_c_s	c5,s38	;;17B
	db_c_s	c2,s38	;;17C
	db_c_s	c1,s38	;;17D
	db_c_s	c3,s38	;;17E
	db_c_s	c6,s38	;;17F
	db_c_s	c4,s38	;;17G

lcd_d18	.equ	lcd_d17+7
	db_c_s	c1,s24	;;18A
	db_c_s	c3,s24	;;18B
	db_c_s	c6,s24	;;18C
	db_c_s	c7,s24	;;18D
	db_c_s	c5,s24	;;18E
	db_c_s	c2,s24	;;18F
	db_c_s	c4,s24	;;18G

lcd_d19	.equ	lcd_d18+7
	db_c_s	c1,s25	;;19A
	db_c_s	c3,s25	;;19B
	db_c_s	c6,s25	;;19C
	db_c_s	c7,s25	;;19D
	db_c_s	c5,s25	;;19E
	db_c_s	c2,s25	;;19F
	db_c_s	c4,s25	;;19G

lcd_d20	.equ	lcd_d19+7
	db_c_s	c1,s26	;;20A
	db_c_s	c3,s26	;;20B
	db_c_s	c6,s26	;;20C
	db_c_s	c7,s26	;;20D
	db_c_s	c5,s26	;;20E
	db_c_s	c2,s26	;;20F
	db_c_s	c4,s26	;;20G

lcd_d21	.equ	lcd_d20+7
	db_c_s	c1,s27	;;21A
	db_c_s	c3,s27	;;21B
	db_c_s	c6,s27	;;21C
	db_c_s	c7,s27	;;21D
	db_c_s	c5,s27	;;21E
	db_c_s	c2,s27	;;21F
	db_c_s	c4,s27	;;21G



Lcd_dot:
lcd_S0 .equ Lcd_dot-lcd_table1
	db_c_s	c0,s24	;;S0
	db_c_s	c5,s21	;;S1
	db_c_s	c6,s21	;;S2
	db_c_s	c7,s21	;;S3
	db_c_s	c7,s28	;;S4

	db_c_s	c6,s28	;;S5
	db_c_s	c5,s28	;;S6
	db_c_s	c4,s28	;;S7
	db_c_s	c3,s28	;;S8
	db_c_s	c2,s28	;;S9


	db_c_s	c1,s28	;;S10
	db_c_s	c0,s28	;;S11
	db_c_s	c0,s29	;;S12
	db_c_s	c1,s29	;;S13
	db_c_s	c2,s29	;;S14


	db_c_s	c3,s29	;;S15
	db_c_s	c4,s29	;;S16
	db_c_s	c5,s29	;;S17
	db_c_s	c6,s29	;;S18
	db_c_s	c7,s29	;;S19


	db_c_s	c7,s30	;;S20
	db_c_s	c6,s30	;;S21
	db_c_s	c5,s30	;;S22
	db_c_s	c4,s30	;;S23
	db_c_s	c3,s30	;;S24


	db_c_s	c2,s30	;;S25
	db_c_s	c1,s30	;;S26
	db_c_s	c0,s30	;;S27
	db_c_s	c0,s31	;;S28
	db_c_s	c1,s31	;;S29


	db_c_s	c2,s31	;;S30
	db_c_s	c3,s31	;;S31
	db_c_s	c4,s31	;;S32
	db_c_s	c5,s31	;;S33
	db_c_s	c6,s31	;;S34


	db_c_s	c7,s31	;;S35
	db_c_s	c7,s32	;;S36
	db_c_s	c6,s32	;;S37
	db_c_s	c5,s32	;;S38
	db_c_s	c4,s32	;;S39


	db_c_s	c3,s32	;;S40
	db_c_s	c2,s32	;;S41
	db_c_s	c1,s32	;;S42
	db_c_s	c0,s32	;;S43
	db_c_s	c0,s33	;;S44


	db_c_s	c1,s33	;;S45
	db_c_s	c2,s33	;;S46
	db_c_s	c3,s33	;;S47
	db_c_s	c4,s33	;;S48
	db_c_s	c5,s33	;;S49


	db_c_s	c6,s33	;;S50
	db_c_s	c7,s33	;;S51
	db_c_s	c7,s34	;;S52
	db_c_s	c6,s34	;;S53
	db_c_s	c5,s34	;;S54


	db_c_s	c4,s34	;;S55
	db_c_s	c3,s34	;;S56
	db_c_s	c2,s34	;;S57
	db_c_s	c1,s34	;;S58
	db_c_s	c0,s34	;;S59
	db_c_s	c0,s25	;;S60
	

	db_c_s	c7,s20	;;X1
	db_c_s	c7,s22	;;X2
	db_c_s	c0,s37	;;X3
	db_c_s	c0,s38	;;X4
	db_c_s	c3,s39	;;X5

	db_c_s	c2,s39	;;X6
	db_c_s	c1,s39	;;X7
	db_c_s	c0,s39	;;X8
	db_c_s	c0,s35	;;X9
	db_c_s	c4,s39	;;X10

	db_c_s	c5,s39	;;X11
	db_c_s	c6,s39	;;X12
	db_c_s	c7,s39	;;X13


	db_c_s	c0,s21	;;T1
	db_c_s	c4,s21	;;T2
	db_c_s	c3,s21	;;T3
	db_c_s	c2,s21	;;T4
	db_c_s	c1,s21	;;T5

	db_c_s	c7,s8	;;T6
	db_c_s	c7,s9	;;T7
	db_c_s	c7,s7	;;T8


	db_c_s	c0,s36	;;P1
	db_c_s	c0,s26	;;P2
	db_c_s	c0,s27	;;P3


	db_c_s	c7,s10	;;AM


	db_c_s	c7,s11	;;PM


	db_c_s	c7,s23	;;C
;;lcd_end_here



lcd_S1			.EQU	lcd_S0+1	
lcd_S2			.EQU	lcd_S0+2	
lcd_S3			.EQU	lcd_S0+3	
lcd_S4			.EQU	lcd_S0+4	
lcd_S5			.EQU	lcd_S0+5	
lcd_S6			.EQU	lcd_S0+6	
lcd_S7			.EQU	lcd_S0+7	
lcd_S8			.EQU	lcd_S0+8	
lcd_S9			.EQU	lcd_S0+9	
lcd_S10			.EQU	lcd_S0+10	
lcd_S11			.EQU	lcd_S0+11	
lcd_S12			.EQU	lcd_S0+12	
lcd_S13			.EQU	lcd_S0+13	
lcd_S14			.EQU	lcd_S0+14	
lcd_S15			.EQU	lcd_S0+15	
lcd_S16			.EQU	lcd_S0+16	
lcd_S17			.EQU	lcd_S0+17	
lcd_S18			.EQU	lcd_S0+18	
lcd_S19			.EQU	lcd_S0+19	
lcd_S20			.EQU	lcd_S0+20	
lcd_S21			.EQU	lcd_S0+21	
lcd_S22			.EQU	lcd_S0+22	
lcd_S23			.EQU	lcd_S0+23	
lcd_S24			.EQU	lcd_S0+24	
lcd_S25			.EQU	lcd_S0+25	
lcd_S26			.EQU	lcd_S0+26	
lcd_S27			.EQU	lcd_S0+27	
lcd_S28			.EQU	lcd_S0+28	
lcd_S29			.EQU	lcd_S0+29	
lcd_S30			.EQU	lcd_S0+30	
lcd_S31			.EQU	lcd_S0+31	
lcd_S32			.EQU	lcd_S0+32	
lcd_S33			.EQU	lcd_S0+33	
lcd_S34			.EQU	lcd_S0+34	
lcd_S35			.EQU	lcd_S0+35	
lcd_S36			.EQU	lcd_S0+36	
lcd_S37			.EQU	lcd_S0+37	
lcd_S38			.EQU	lcd_S0+38	
lcd_S39			.EQU	lcd_S0+39
lcd_S40			.EQU	lcd_S0+40		
lcd_S41			.EQU	lcd_S0+41	
lcd_S42			.EQU	lcd_S0+42	
lcd_S43			.EQU	lcd_S0+43	
lcd_S44			.EQU	lcd_S0+44	
lcd_S45			.EQU	lcd_S0+45	
lcd_S46			.EQU	lcd_S0+46	
lcd_S47			.EQU	lcd_S0+47	
lcd_S48			.EQU	lcd_S0+48	
lcd_S49			.EQU	lcd_S0+49
lcd_S50			.EQU	lcd_S0+50	
lcd_S51			.EQU	lcd_S0+51	
lcd_S52			.EQU	lcd_S0+52	
lcd_S53			.EQU	lcd_S0+53	
lcd_S54			.EQU	lcd_S0+54	
lcd_S55			.EQU	lcd_S0+55	
lcd_S56			.EQU	lcd_S0+56	
lcd_S57			.EQU	lcd_S0+57	
lcd_S58			.EQU	lcd_S0+58	
lcd_S59			.EQU	lcd_S0+59
lcd_S60			.EQU	lcd_S0+60
lcd_X1			.EQU	lcd_S0+61	
lcd_X2			.EQU	lcd_S0+62	
lcd_X3			.EQU	lcd_S0+63	
lcd_X4			.EQU	lcd_S0+64	
lcd_X5			.EQU	lcd_S0+65	
lcd_X6			.EQU	lcd_S0+66	
lcd_X7			.EQU	lcd_S0+67	
lcd_X8			.EQU	lcd_S0+68	
lcd_X9			.EQU	lcd_S0+69
lcd_X10			.EQU	lcd_S0+70
lcd_X11			.EQU	lcd_S0+71
lcd_X12			.EQU	lcd_S0+72
lcd_X13			.EQU	lcd_S0+73
lcd_T1			.EQU	lcd_S0+74
lcd_T2			.EQU	lcd_S0+75
lcd_T3			.EQU	lcd_S0+76
lcd_T4			.EQU	lcd_S0+77
lcd_T5			.EQU	lcd_S0+78
lcd_T6			.EQU	lcd_S0+79
lcd_T7			.EQU	lcd_S0+80
lcd_T8			.EQU	lcd_S0+81
lcd_P1			.EQU	lcd_S0+82
lcd_P2			.EQU	lcd_S0+83
lcd_P3			.EQU	lcd_S0+84
lcd_AM			.EQU	lcd_S0+85
lcd_PM			.EQU	lcd_S0+86
lcd_C			.EQU	lcd_S0+87

lcd_Week		.EQU	lcd_X1
lcd_Voice		.EQU	lcd_X3
lcd_Sclient		.EQU	lcd_X4
lcd_Alarm_Clock_1	.EQU	lcd_X5
lcd_Alarm_Clock_2	.EQU	lcd_X6
lcd_Alarm_Clock_3	.EQU	lcd_X7
lcd_Alarm_Clock_4	.EQU	lcd_X8
lcd_Alarm_Clock_5	.EQU	lcd_X9






;=============.EQU	lcd_=============================================
;==========================================================
Lcd_bit:

	    db_c_y	c0,s7	;;1A
	db_c_y	c2,s7	;;1B
	db_c_y	c5,s7	;;1C
	db_c_y	c6,s7	;;1D
	db_c_y	c4,s7	;;1E
	db_c_y	c1,s7	;;1F
	db_c_y	c3,s7	;;1G


	db_c_y	c0,s8	;;2A
	db_c_y	c2,s8	;;2B
	db_c_y	c5,s8	;;2C
	db_c_y	c6,s8	;;2D
	db_c_y	c4,s8	;;2E
	db_c_y	c1,s8	;;2F
	db_c_y	c3,s8	;;2G


	db_c_y	c0,s9	;;3A
	db_c_y	c2,s9	;;3B
	db_c_y	c5,s9	;;3C
	db_c_y	c6,s9	;;3D
	db_c_y	c4,s9	;;3E
	db_c_y	c1,s9	;;3F
	db_c_y	c3,s9	;;3G


	db_c_y	c0,s10	;;4A
	db_c_y	c2,s10	;;4B
	db_c_y	c5,s10	;;4C
	db_c_y	c6,s10	;;4D
	db_c_y	c4,s10	;;4E
	db_c_y	c1,s10	;;4F
	db_c_y	c3,s10	;;4G


	db_c_y	c0,s11	;;5A
	db_c_y	c2,s11	;;5B
	db_c_y	c5,s11	;;5C
	db_c_y	c6,s11	;;5D
	db_c_y	c4,s11	;;5E
	db_c_y	c1,s11	;;5F
	db_c_y	c3,s11	;;5G


	db_c_y	c0,s20	;;6A
	db_c_y	c2,s20	;;6B
	db_c_y	c5,s20	;;6C
	db_c_y	c6,s20	;;6D
	db_c_y	c4,s20	;;6E
	db_c_y	c1,s20	;;6F
	db_c_y	c3,s20	;;6G


	db_c_y	c0,s22	;;7A
	db_c_y	c2,s22	;;7B
	db_c_y	c5,s22	;;7C
	db_c_y	c6,s22	;;7D
	db_c_y	c4,s22	;;7E
	db_c_y	c1,s22	;;7F
	db_c_y	c3,s22	;;7G


	db_c_y	c0,s23	;;8A
	db_c_y	c2,s23	;;8B
	db_c_y	c5,s23	;;8C
	db_c_y	c6,s23	;;8D
	db_c_y	c4,s23	;;8E
	db_c_y	c1,s23	;;8F
	db_c_y	c3,s23	;;8G


	db_c_y	c7,s35	;;14A
	db_c_y	c5,s35	;;14B
	db_c_y	c2,s35	;;14C
	db_c_y	c1,s35	;;14D
	db_c_y	c3,s35	;;14E
	db_c_y	c6,s35	;;14F
	db_c_y	c4,s35	;;14G


	db_c_y	c7,s36	;;15A
	db_c_y	c5,s36	;;15B
	db_c_y	c2,s36	;;15C
	db_c_y	c1,s36	;;15D
	db_c_y	c3,s36	;;15E
	db_c_y	c6,s36	;;15F
	db_c_y	c4,s36	;;15G


	db_c_y	c7,s37	;;16A
	db_c_y	c5,s37	;;16B
	db_c_y	c2,s37	;;16C
	db_c_y	c1,s37	;;16D
	db_c_y	c3,s37	;;16E
	db_c_y	c6,s37	;;16F
	db_c_y	c4,s37	;;16G


	db_c_y	c7,s38	;;17A
	db_c_y	c5,s38	;;17B
	db_c_y	c2,s38	;;17C
	db_c_y	c1,s38	;;17D
	db_c_y	c3,s38	;;17E
	db_c_y	c6,s38	;;17F
	db_c_y	c4,s38	;;17G


	db_c_y	c1,s24	;;18A
	db_c_y	c3,s24	;;18B
	db_c_y	c6,s24	;;18C
	db_c_y	c7,s24	;;18D
	db_c_y	c5,s24	;;18E
	db_c_y	c2,s24	;;18F
	db_c_y	c4,s24	;;18G


	db_c_y	c1,s25	;;19A
	db_c_y	c3,s25	;;19B
	db_c_y	c6,s25	;;19C
	db_c_y	c7,s25	;;19D
	db_c_y	c5,s25	;;19E
	db_c_y	c2,s25	;;19F
	db_c_y	c4,s25	;;19G


	db_c_y	c1,s26	;;20A
	db_c_y	c3,s26	;;20B
	db_c_y	c6,s26	;;20C
	db_c_y	c7,s26	;;20D
	db_c_y	c5,s26	;;20E
	db_c_y	c2,s26	;;20F
	db_c_y	c4,s26	;;20G


	db_c_y	c1,s27	;;21A
	db_c_y	c3,s27	;;21B
	db_c_y	c6,s27	;;21C
	db_c_y	c7,s27	;;21D
	db_c_y	c5,s27	;;21E
	db_c_y	c2,s27	;;21F
	db_c_y	c4,s27	;;21G



	db_c_y	c0,s24	;;S0
	db_c_y	c5,s21	;;S1
	db_c_y	c6,s21	;;S2
	db_c_y	c7,s21	;;S3
	db_c_y	c7,s28	;;S4

	db_c_y	c6,s28	;;S5
	db_c_y	c5,s28	;;S6
	db_c_y	c4,s28	;;S7
	db_c_y	c3,s28	;;S8
	db_c_y	c2,s28	;;S9


	db_c_y	c1,s28	;;S10
	db_c_y	c0,s28	;;S11
	db_c_y	c0,s29	;;S12
	db_c_y	c1,s29	;;S13
	db_c_y	c2,s29	;;S14


	db_c_y	c3,s29	;;S15
	db_c_y	c4,s29	;;S16
	db_c_y	c5,s29	;;S17
	db_c_y	c6,s29	;;S18
	db_c_y	c7,s29	;;S19


	db_c_y	c7,s30	;;S20
	db_c_y	c6,s30	;;S21
	db_c_y	c5,s30	;;S22
	db_c_y	c4,s30	;;S23
	db_c_y	c3,s30	;;S24


	db_c_y	c2,s30	;;S25
	db_c_y	c1,s30	;;S26
	db_c_y	c0,s30	;;S27
	db_c_y	c0,s31	;;S28
	db_c_y	c1,s31	;;S29


	db_c_y	c2,s31	;;S30
	db_c_y	c3,s31	;;S31
	db_c_y	c4,s31	;;S32
	db_c_y	c5,s31	;;S33
	db_c_y	c6,s31	;;S34


	db_c_y	c7,s31	;;S35
	db_c_y	c7,s32	;;S36
	db_c_y	c6,s32	;;S37
	db_c_y	c5,s32	;;S38
	db_c_y	c4,s32	;;S39


	db_c_y	c3,s32	;;S40
	db_c_y	c2,s32	;;S41
	db_c_y	c1,s32	;;S42
	db_c_y	c0,s32	;;S43
	db_c_y	c0,s33	;;S44


	db_c_y	c1,s33	;;S45
	db_c_y	c2,s33	;;S46
	db_c_y	c3,s33	;;S47
	db_c_y	c4,s33	;;S48
	db_c_y	c5,s33	;;S49


	db_c_y	c6,s33	;;S50
	db_c_y	c7,s33	;;S51
	db_c_y	c7,s34	;;S52
	db_c_y	c6,s34	;;S53
	db_c_y	c5,s34	;;S54


	db_c_y	c4,s34	;;S55
	db_c_y	c3,s34	;;S56
	db_c_y	c2,s34	;;S57
	db_c_y	c1,s34	;;S58
	db_c_y	c0,s34	;;S59
	db_c_y	c0,s25	;;S60
	

	db_c_y	c7,s20	;;X1
	db_c_y	c7,s22	;;X2
	db_c_y	c0,s37	;;X3
	db_c_y	c0,s38	;;X4
	db_c_y	c3,s39	;;X5

	db_c_y	c2,s39	;;X6
	db_c_y	c1,s39	;;X7
	db_c_y	c0,s39	;;X8
	db_c_y	c0,s35	;;X9
	db_c_y	c4,s39	;;X10

	db_c_y	c5,s39	;;X11
	db_c_y	c6,s39	;;X12
	db_c_y	c7,s39	;;X13


	db_c_y	c0,s21	;;T1
	db_c_y	c4,s21	;;T2
	db_c_y	c3,s21	;;T3
	db_c_y	c2,s21	;;T4
	db_c_y	c1,s21	;;T5

	db_c_y	c7,s8	;;T6
	db_c_y	c7,s9	;;T7
	db_c_y	c7,s7	;;T8


	db_c_y	c0,s36	;;P1
	db_c_y	c0,s26	;;P2
	db_c_y	c0,s27	;;P3


	db_c_y	c7,s10	;;AM


	db_c_y	c7,s11	;;PM


	db_c_y	c7,s23	;;C
