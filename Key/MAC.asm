.MACRO	SMB0 RAM
    SEI
    LDA     RAM
    ORA     #BIT0
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	SMB1 RAM
    SEI
    LDA     RAM
    ORA     #BIT1
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	SMB2 RAM
    SEI
    LDA     RAM
    ORA     #BIT2
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	SMB3 RAM
    SEI
    LDA     RAM
    ORA     #BIT3
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	SMB4 RAM
    SEI
    LDA     RAM
    ORA     #BIT4
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	SMB5 RAM
    SEI
    LDA     RAM
    ORA     #BIT5
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	SMB6 RAM
    SEI
    LDA     RAM
    ORA     #BIT6
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	SMB7 RAM
    SEI
    LDA     RAM
    ORA     #BIT7
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	RMB0 RAM
    SEI
    LDA     RAM
    AND     #BIT0_
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	RMB1 RAM
    SEI
    LDA     RAM
    AND     #BIT1_
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	RMB2 RAM
    SEI
    LDA     RAM
    AND     #BIT2_
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	RMB3 RAM
    SEI
    LDA     RAM
    AND     #BIT3_
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	RMB4 RAM
    SEI
    LDA     RAM
    AND     #BIT4_
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	RMB5 RAM
    SEI
    LDA     RAM
    AND     #BIT5_
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	RMB6 RAM
    SEI
    LDA     RAM
    AND     #BIT6_
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	RMB7 RAM
    SEI
    LDA     RAM
    AND     #BIT7_
    STA     RAM
    CLI
.ENDMACRO
;================================================================
.MACRO	BBR0 RAM,Addr
    LDA     RAM
    AND     #BIT0
    BEQ     Addr
.ENDMACRO
;================================================================
.MACRO	BBR1 RAM,Addr
    LDA     RAM
    AND     #BIT1
    BEQ     Addr
.ENDMACRO
;================================================================
.MACRO	BBR2 RAM,Addr
    LDA     RAM
    AND     #BIT2
    BEQ     Addr
.ENDMACRO
;================================================================
.MACRO	BBR3 RAM,Addr
    LDA     RAM
    AND     #BIT3
    BEQ     Addr
.ENDMACRO
;================================================================
.MACRO	BBR4 RAM,Addr
    LDA     RAM
    AND     #BIT4
    BEQ     Addr
.ENDMACRO
;================================================================
.MACRO	BBR5 RAM,Addr
    LDA     RAM
    AND     #BIT5
    BEQ     Addr
.ENDMACRO
;================================================================
.MACRO	BBR6 RAM,Addr
    LDA     RAM
    AND     #BIT6
    BEQ     Addr
.ENDMACRO
;================================================================
.MACRO	BBR7 RAM,Addr
    LDA     RAM
    AND     #BIT7
    BEQ     Addr
.ENDMACRO
;================================================================
.MACRO	BBS0 RAM,Addr
    LDA     RAM
    AND     #BIT0
    BNE     Addr
.ENDMACRO
;================================================================
.MACRO	BBS1 RAM,Addr
    LDA     RAM
    AND     #BIT1
    BNE     Addr
.ENDMACRO
;================================================================
.MACRO	BBS2 RAM,Addr
    LDA     RAM
    AND     #BIT2
    BNE     Addr
.ENDMACRO
;================================================================
.MACRO	BBS3 RAM,Addr
    LDA     RAM
    AND     #BIT3
    BNE     Addr
.ENDMACRO
;================================================================
.MACRO	BBS4 RAM,Addr
    LDA     RAM
    AND     #BIT4
    BNE     Addr
.ENDMACRO
;================================================================
.MACRO	BBS5 RAM,Addr
    LDA     RAM
    AND     #BIT5
    BNE     Addr
.ENDMACRO
;================================================================
.MACRO	BBS6 RAM,Addr
    LDA     RAM
    AND     #BIT6
    BNE     Addr
.ENDMACRO
;================================================================
.MACRO	BBS7 RAM,Addr
    LDA     RAM
    AND     #BIT7
    BNE     Addr
.ENDMACRO
;================================================================