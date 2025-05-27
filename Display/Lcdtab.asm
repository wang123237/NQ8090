;--------COM------------
c0	.equ	0
c1	.equ	1
c2	.equ	2
c3	.equ	3
c4	.equ	4
; c5	.equ	5
; c6	.equ	6
;;--------SEG------------
; s47	.equ	47
; s46	.equ	46
; s45	.equ	45
; s44	.equ	44
s43	.equ	43
s42	.equ	42
s41	.equ	41
s40	.equ	40
s39	.equ	39
s38	.equ	38
s37	.equ	37
s36	.equ	36
s35	.equ	35
s34	.equ	34
s33	.equ	33
s32	.equ	32
; s31	.equ	31
; s30	.equ	30
; s29	.equ	29
; s28	.equ	28
; s27	.equ	27
; s26	.equ	26
; s25	.equ	25
; s24	.equ	24
; s23	.equ	23
; s22	.equ	22
; s21	.equ	21
; s20	.equ	20
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
; s7	.equ	7
; s6	.equ	6
; s5	.equ	5
; s4	.equ	4
; s3	.equ	3
; s2	.equ	2
; s1	.equ	1
; s0	.equ	0


.MACRO  db_c_s	com,seg
          .BYTE com*6+seg/8
.ENDMACRO

.MACRO  db_c_y	com,seg
	      .BYTE 1.shl.(seg-seg/8*8)
.ENDMACRO

Lcd_byte:	;段码
lcd_table1:
lcd_d1 .equ	lcd_table1-lcd_table1
	db_c_s	c2,s41	;;1A
	db_c_s	c2,s40	;;1B
	db_c_s	c4,s41	;;1C
	db_c_s	c4,s42	;;1D
	db_c_s	c3,s42	;;1E
	db_c_s	c2,s42	;;1F
	db_c_s	c3,s41	;;1G

lcd_d2	.equ lcd_d1+7
	db_c_s	c2,s38	;;2A
	db_c_s	c3,s38	;;2B
	db_c_s	c4,s38	;;2C
	db_c_s	c4,s39	;;2D
	db_c_s	c3,s40	;;2E
	db_c_s	c2,s39	;;2F
	db_c_s	c3,s39	;;2G
	
lcd_d3	.equ lcd_d2+7
	
	db_c_s	c2,s36	;;3A
	db_c_s	c2,s34	;;3B
	db_c_s	c4,s35	;;3C
	db_c_s	c4,s36	;;3D
	db_c_s	c3,s37	;;3E
	db_c_s	c2,s37	;;3F
	db_c_s	c3,s35	;;3G

lcd_d4	.equ lcd_d3+7

	db_c_s	c2,s32	;;4A
	db_c_s	c3,s32	;;4B
	db_c_s	c4,s32	;;4C
	db_c_s	c4,s33	;;4D
	db_c_s	c3,s34	;;4E
	db_c_s	c2,s33	;;4F
	db_c_s	c3,s33	;;4G



lcd_d5	.equ lcd_d4+7

	db_c_s	c2,s14	;;5A
	db_c_s	c2,s13	;;5B
	db_c_s	c3,s13	;;5C
	db_c_s	c4,s14	;;5D
	db_c_s	c3,s15	;;5E
	db_c_s	c2,s15	;;5F
	db_c_s	c3,s14	;;5G

lcd_d6	.equ lcd_d5+7

	db_c_s	c0,s12	;;6A
	db_c_s	c1,s11	;;6B
	db_c_s	c3,s11	;;6C
	db_c_s	c4,s12	;;6D
	db_c_s	c3,s12	;;6E
	db_c_s	c1,s12	;;6F
	db_c_s	c2,s12	;;6G

lcd_d7	.equ lcd_d6+7

	db_c_s	c0,s10	;;7A
	db_c_s	c1,s10	;;7B
	db_c_s	c3,s10	;;7C
	db_c_s	c4,s10	;;7D
	db_c_s	c2,s11	;;7E
	db_c_s	c0,s11	;;7F
	db_c_s	c2,s10	;;7G

lcd_d8	.equ lcd_d7+7

	db_c_s	c0,s9	;;8A
	db_c_s	c1,s8	;;8B
	db_c_s	c3,s8	;;8C
	db_c_s	c4,s8	;;8D
	db_c_s	c3,s9	;;8E
	db_c_s	c1,s9	;;8F
	db_c_s	c2,s9	;;8G
lcd_d9	.equ lcd_d8+7

	db_c_s	c0,s35	;;9A
	db_c_s	c1,s35	;;9B
	db_c_s	c1,s36	;;9C
	db_c_s	c1,s37	;;9D
	db_c_s	c0,s37	;;9E
	db_c_s	c0,s34	;;9F
	db_c_s	c0,s36	;;9G

lcd_d10	.equ lcd_d9+7

	db_c_s	c0,s15	;;10A
	db_c_s	c1,s15	;;10B
	db_c_s	c1,s32	;;10C
	db_c_s	c1,s33	;;10D
	db_c_s	c0,s33	;;10E
	db_c_s	c0,s14	;;10F
	db_c_s	c0,s32	;;10G
	




Lcd_dot:
lcd_col .equ Lcd_dot-lcd_table1
	db_c_s	c2,s35	;;col1
	db_c_s	c3,s36	;;col2
	
	db_c_s	c1,s34	;;9H

	db_c_s	c0,s13	;;10I
	db_c_s	c1,s14	;;10H
	db_c_s	c1,s13	;;10J

	db_c_s	c0,s41	;;ALM
	db_c_s	c0,s40	;;SNZ
	db_c_s	c0,s42	;;SIG

	
	
	db_c_s	c1,s42	;AM
	db_c_s	c1,s41	;;PM

	db_c_s	c1,s40	;;K
	db_c_s	c1,s39	;;+
	db_c_s	c0,s39	;;-
	db_c_s	c1,s38	;;*
	db_c_s	c0,s38	;;/

	
	db_c_s	c4,s40	;;lcd_T1
	db_c_s	c4,s37	;;lcd_T2
	db_c_s	c4,s34	;;lcd_T3
	db_c_s	c4,s15	;;lcd_T4
	db_c_s	c4,s13	;;lcd_T5
	db_c_s	c4,s11	;;lcd_T6
	db_c_s	c4,s9	;;lcd_T7
	db_c_s	c2,s8	;;lcd_T8

	lcd_col2		.EQU	lcd_col+1
	lcd_9H			.EQU	lcd_col+2
	lcd_10I			.EQU	lcd_col+3
	lcd_10H			.EQU	lcd_col+4
	lcd_10J			.EQU	lcd_col+5
	lcd_SIG			.EQU	lcd_col+6
	lcd_SNZ			.EQU	lcd_col+7
	lcd_ALM			.EQU	lcd_col+8
	lcd_AM			.EQU	lcd_col+9
	lcd_PM			.EQU	lcd_col+10
	lcd_Involution	.EQU	lcd_col+11
	lcd_Plus		.EQU	lcd_col+12
	lcd_SUB			.EQU	lcd_col+13
	lcd_Mul			.EQU	lcd_col+14
	lcd_DIV			.EQU	lcd_col+15
	lcd_T1		.EQU	lcd_col+16		
	lcd_T2		.EQU	lcd_col+17
	lcd_T3		.EQU	lcd_col+18
	lcd_T4		.EQU	lcd_col+19
	lcd_T5		.EQU	lcd_col+20
	lcd_T6		.EQU	lcd_col+21
	lcd_T7		.EQU	lcd_col+22
	lcd_T8		.EQU	lcd_col+23	
	
	

	
;=============.EQU	lcd_=============================================
;==========================================================
Lcd_bit:

	db_c_y	c2,s41	;;1A
	db_c_y	c2,s40	;;1B
	db_c_y	c4,s41	;;1C
	db_c_y	c4,s42	;;1D
	db_c_y	c3,s42	;;1E
	db_c_y	c2,s42	;;1F
	db_c_y	c3,s41	;;1G


	db_c_y	c2,s38	;;2A
	db_c_y	c3,s38	;;2B
	db_c_y	c4,s38	;;2C
	db_c_y	c4,s39	;;2D
	db_c_y	c3,s40	;;2E
	db_c_y	c2,s39	;;2F
	db_c_y	c3,s39	;;2G
	

	
	db_c_y	c2,s36	;;3A
	db_c_y	c2,s34	;;3B
	db_c_y	c4,s35	;;3C
	db_c_y	c4,s36	;;3D
	db_c_y	c3,s37	;;3E
	db_c_y	c2,s37	;;3F
	db_c_y	c3,s35	;;3G



	db_c_y	c2,s32	;;4A
	db_c_y	c3,s32	;;4B
	db_c_y	c4,s32	;;4C
	db_c_y	c4,s33	;;4D
	db_c_y	c3,s34	;;4E
	db_c_y	c2,s33	;;4F
	db_c_y	c3,s33	;;4G





	db_c_y	c2,s14	;;5A
	db_c_y	c2,s13	;;5B
	db_c_y	c3,s13	;;5C
	db_c_y	c4,s14	;;5D
	db_c_y	c3,s15	;;5E
	db_c_y	c2,s15	;;5F
	db_c_y	c3,s14	;;5G



	db_c_y	c0,s12	;;6A
	db_c_y	c1,s11	;;6B
	db_c_y	c3,s11	;;6C
	db_c_y	c4,s12	;;6D
	db_c_y	c3,s12	;;6E
	db_c_y	c1,s12	;;6F
	db_c_y	c2,s12	;;6G



	db_c_y	c0,s10	;;7A
	db_c_y	c1,s10	;;7B
	db_c_y	c3,s10	;;7C
	db_c_y	c4,s10	;;7D
	db_c_y	c2,s11	;;7E
	db_c_y	c0,s11	;;7F
	db_c_y	c2,s10	;;7G


	db_c_y	c0,s9	;;8A
	db_c_y	c1,s8	;;8B
	db_c_y	c3,s8	;;8C
	db_c_y	c4,s8	;;8D
	db_c_y	c3,s9	;;8E
	db_c_y	c1,s9	;;8F
	db_c_y	c2,s9	;;8G


	db_c_y	c0,s35	;;9A
	db_c_y	c1,s35	;;9B
	db_c_y	c1,s36	;;9C
	db_c_y	c1,s37	;;9D
	db_c_y	c0,s37	;;9E
	db_c_y	c0,s34	;;9F
	db_c_y	c0,s36	;;9G



	db_c_y	c0,s15	;;10A
	db_c_y	c1,s15	;;10B
	db_c_y	c1,s32	;;10C
	db_c_y	c1,s33	;;10D
	db_c_y	c0,s33	;;10E
	db_c_y	c0,s14	;;10F
	db_c_y	c0,s32	;;10G
	




	db_c_y	c2,s35	;;col1
	db_c_y	c3,s36	;;col2
	
	db_c_y	c1,s34	;;9H

	db_c_y	c0,s13	;;10I
	db_c_y	c1,s14	;;10H
	db_c_y	c1,s13	;;10J

	db_c_y	c0,s41	;;ALM
	db_c_y	c0,s40	;;SNZ
	db_c_y	c0,s42	;;SIG

	
	
	db_c_y	c1,s42	;AM
	db_c_y	c1,s41	;;PM

	db_c_y	c1,s40	;;K
	db_c_y	c1,s39	;;+
	db_c_y	c0,s39	;;-
	db_c_y	c1,s38	;;*
	db_c_y	c0,s38	;;/

	
	db_c_y	c4,s40	;;lcd_T1
	db_c_y	c4,s37	;;lcd_T2
	db_c_y	c4,s34	;;lcd_T3
	db_c_y	c4,s15	;;lcd_T4
	db_c_y	c4,s13	;;lcd_T5
	db_c_y	c4,s11	;;lcd_T6
	db_c_y	c4,s9	;;lcd_T7
	db_c_y	c2,s8	;;lcd_T8