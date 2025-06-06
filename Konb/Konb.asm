L_Control_Konb_Prog:
    LDA     P_PA
    AND     D_Konb_Value
    STA     P_Temp
    LDA     Konb_Last_State
    CMP     P_Temp
    BNE     L_Control_Konb_Prog_Jugement    


L_Control_Konb_Prog_Jugement:
    LDA     Knob