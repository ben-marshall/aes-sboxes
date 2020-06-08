
//
// Boyar-Peralta AES SBox - Forward / Inverse with shared middle layer
// 

module bp_aes_sbox (
input  wire [7:0] s_in  ,
input  wire       inv   ,
output wire [7:0] s_out
);

wire [7:0] U; // Bit-reversed version of s_in
wire [7:0] S; // Bit reversed version of s_out (forward)
wire [7:0] W; // Bit reversed version of s_out (inverse)

wire [7:0] s_out_inv;
wire [7:0] s_out_fwd;

genvar i;
generate for(i = 0; i < 8; i=i+1) begin
    assign U[i]         = s_in[7-i];
    assign s_out_fwd[i] = S   [7-i];
    assign s_out_inv[i] = W   [7-i];
end endgenerate

assign s_out = inv ? s_out_inv : s_out_fwd;

//
// Top Layer - Forward

wire tf_1   = U[0 ] ^ U[3];
wire tf_2   = U[0 ] ^ U[5];
wire tf_3   = U[0 ] ^ U[6];
wire tf_4   = U[3 ] ^ U[5];
wire tf_5   = U[4 ] ^ U[6];
wire tf_6   = tf_1   ^ tf_5 ;
wire tf_7   = U[1 ] ^ U[2];
wire tf_8   = U[7 ] ^ tf_6 ;
wire tf_9   = U[7 ] ^ tf_7 ;
wire tf_10  = tf_6   ^ tf_7 ;
wire tf_11  = U[1 ] ^ U[5] ;
wire tf_12  = U[2 ] ^ U[5] ;
wire tf_13  = tf_3   ^ tf_4  ;
wire tf_14  = tf_6   ^ tf_11 ;
wire tf_15  = tf_5   ^ tf_11 ;
wire tf_16  = tf_5   ^ tf_12 ;
wire tf_17  = tf_9   ^ tf_16 ;
wire tf_18  = U[3 ] ^ U[7] ;
wire tf_19  = tf_7   ^ tf_18 ;
wire tf_20  = tf_1   ^ tf_19 ;
wire tf_21  = U[6 ] ^ U[7] ;
wire tf_22  = tf_7   ^ tf_21 ;
wire tf_23  = tf_2   ^ tf_22 ;
wire tf_24  = tf_2   ^ tf_10 ;
wire tf_25  = tf_20  ^ tf_17 ;
wire tf_26  = tf_3   ^ tf_16 ;
wire tf_27  = tf_1   ^ tf_12 ;

//
// Top Layer - Inverse

wire r_13  =   U[1] ^ U[6]   ;
wire r_17  = ~(U[2] ^ U[5] ) ;
wire r_18  = ~(U[5] ^ U[6] ) ;
wire r_19  = ~(U[2] ^ U[4] ) ;
wire ti_1  =   U[3] ^ U[4]   ;
wire ti_2  = ~(U[0] ^ U[1] ) ;
wire ti_3  =   ti_1 ^ r_5    ;
wire ti_4  =   U[4] ^ ti_8    ;
wire r_5   =   U[6] ^ U[7]   ;
wire ti_6  =   ti_22^ r_17   ;
wire ti_8  = ~(U[1] ^ ti_23 ) ;
wire ti_9  = ~(U[7] ^ ti_1  ) ;
wire ti_10 =   ti_2 ^ ti_24   ;
wire ti_13 =   ti_2 ^ r_5    ;
wire ti_14 =   ti_10^ r_18   ;
wire ti_15 =   ti_10^ ti_27   ;
wire ti_16 =   r_13 ^ r_19   ;
wire ti_17 = ~(U[2] ^ ti_19 ) ;
wire ti_19 =   ti_22^ r_5    ;
wire ti_20 =   ti_24^ r_13   ;
wire ti_22 = ~(U[1] ^ U[3] ) ;
wire ti_23 =   U[0] ^ U[3]   ;
wire ti_24 = ~(U[4] ^ U[7] ) ;
wire ti_25 = ~(U[2] ^ ti_1  ) ;
wire ti_26 =   ti_3 ^ ti_16   ;
wire ti_27 =   ti_1 ^ r_18   ;
wire y_5   =   U[0] ^ r_17   ;

//
// Top Layer - Forward/Inverse select

wire t_1  = inv ? ti_1  : tf_1  ;
wire t_2  = inv ? ti_2  : tf_2  ;
wire t_3  = inv ? ti_3  : tf_3  ;
wire t_4  = inv ? ti_4  : tf_4  ;
wire t_6  = inv ? ti_6  : tf_6  ;
wire t_8  = inv ? ti_8  : tf_8  ;
wire t_9  = inv ? ti_9  : tf_9  ;
wire t_10 = inv ? ti_10 : tf_10 ;
wire t_13 = inv ? ti_13 : tf_13 ;
wire t_14 = inv ? ti_14 : tf_14 ;
wire t_15 = inv ? ti_15 : tf_15 ;
wire t_16 = inv ? ti_16 : tf_16 ;
wire t_17 = inv ? ti_17 : tf_17 ;
wire t_19 = inv ? ti_19 : tf_19 ;
wire t_20 = inv ? ti_20 : tf_20 ;
wire t_22 = inv ? ti_22 : tf_22 ;
wire t_23 = inv ? ti_23 : tf_23 ;
wire t_24 = inv ? ti_24 : tf_24 ;
wire t_25 = inv ? ti_25 : tf_25 ;
wire t_26 = inv ? ti_26 : tf_26 ;
wire t_27 = inv ? ti_27 : tf_27 ;
wire d    = inv ? y_5   : s_in[0] ;

//
// Middle Layer - Shared

wire m_1   = t_13  & t_6  ;
wire m_2   = t_23  & t_8  ;
wire m_3   = t_14  ^ m_1  ;
wire m_4   = t_19  & d    ;
wire m_5   = m_4   ^ m_1  ;
wire m_6   = t_3   & t_16 ;
wire m_7   = t_22  & t_9  ;
wire m_8   = t_26  ^ m_6  ;
wire m_9   = t_20  & t_17 ;
wire m_10  = m_9   ^ m_6  ;
wire m_11  = t_1   & t_15 ;
wire m_12  = t_4   & t_27 ;
wire m_13  = m_12  ^ m_11 ;
wire m_14  = t_2   & t_10 ;
wire m_15  = m_14  ^ m_11 ;
wire m_16  = m_3   ^ m_2  ;
wire m_17  = m_5   ^ t_24 ;
wire m_18  = m_8   ^ m_7  ;
wire m_19  = m_10  ^ m_15 ;
wire m_20  = m_16  ^ m_13 ;
wire m_21  = m_17  ^ m_15 ;
wire m_22  = m_18  ^ m_13 ;
wire m_23  = m_19  ^ t_25 ;
wire m_24  = m_22  ^ m_23 ;
wire m_25  = m_22  & m_20 ;
wire m_26  = m_21  ^ m_25 ;
wire m_27  = m_20  ^ m_21 ;
wire m_28  = m_23  ^ m_25 ;
wire m_29  = m_28  & m_27 ;
wire m_30  = m_26  & m_24 ;
wire m_31  = m_20  & m_23 ;
wire m_32  = m_27  & m_31 ;
wire m_33  = m_27  ^ m_25 ;
wire m_34  = m_21  & m_22 ;
wire m_35  = m_24  & m_34 ;
wire m_36  = m_24  ^ m_25 ;
wire m_37  = m_21  ^ m_29 ;
wire m_38  = m_32  ^ m_33 ;
wire m_39  = m_23  ^ m_30 ;
wire m_40  = m_35  ^ m_36 ;
wire m_41  = m_38  ^ m_40 ;
wire m_42  = m_37  ^ m_39 ;
wire m_43  = m_37  ^ m_38 ;
wire m_44  = m_39  ^ m_40 ;
wire m_45  = m_42  ^ m_41 ;
wire m_46  = m_44  & t_6  ;
wire m_47  = m_40  & t_8  ;
wire m_48  = m_39  & d    ;
wire m_49  = m_43  & t_16 ;
wire m_50  = m_38  & t_9  ;
wire m_51  = m_37  & t_17 ;
wire m_52  = m_42  & t_15 ;
wire m_53  = m_45  & t_27 ;
wire m_54  = m_41  & t_10 ;
wire m_55  = m_44  & t_13 ;
wire m_56  = m_40  & t_23 ;
wire m_57  = m_39  & t_19 ;
wire m_58  = m_43  & t_3  ;
wire m_59  = m_38  & t_22 ;
wire m_60  = m_37  & t_20 ;
wire m_61  = m_42  & t_1  ;
wire m_62  = m_45  & t_4  ;
wire m_63  = m_41  & t_2  ;

//
// Bottom Layer - Forward

wire l_0   = m_61  ^ m_62 ;
wire l_1   = m_50  ^ m_56 ;
wire l_2   = m_46  ^ m_48 ;
wire l_3   = m_47  ^ m_55 ;
wire l_4   = m_54  ^ m_58 ;
wire l_5   = m_49  ^ m_61 ;
wire l_6   = m_62  ^ l_5  ;
wire l_7   = m_46  ^ l_3  ;
wire l_8   = m_51  ^ m_59 ;
wire l_9   = m_52  ^ m_53 ;
wire l_10  = m_53  ^ l_4  ;
wire l_11  = m_60  ^ l_2  ;
wire l_12  = m_48  ^ m_51 ;
wire l_13  = m_50  ^ l_0  ;
wire l_14  = m_52  ^ m_61 ;
wire l_15  = m_55  ^ l_1  ;
wire l_16  = m_56  ^ l_0  ;
wire l_17  = m_57  ^ l_1  ;
wire l_18  = m_58  ^ l_8  ;
wire l_19  = m_63  ^ l_4  ;
wire l_20  = l_0   ^ l_1  ;
wire l_21  = l_1   ^ l_7  ;
wire l_22  = l_3   ^ l_12 ;
wire l_23  = l_18  ^ l_2  ;
wire l_24  = l_15  ^ l_9  ;
wire l_25  = l_6   ^ l_10 ;
wire l_26  = l_7   ^ l_9  ;
wire l_27  = l_8   ^ l_10 ;
wire l_28  = l_11  ^ l_14 ;
wire l_29  = l_11  ^ l_17 ;

assign S[0 ] = l_6   ^ l_24 ;
assign S[1 ] = l_16  ~^l_26 ;
assign S[2 ] = l_19  ~^l_28 ;
assign S[3 ] = l_6   ^ l_21 ;
assign S[4 ] = l_20  ^ l_22 ;
assign S[5 ] = l_25  ^ l_29 ;
assign S[6 ] = l_13  ~^l_27 ;
assign S[7 ] = l_6   ~^l_23 ;

//
// Bottom Layer - Inverse

wire p_0  = m_52 ^ m_61 ;
wire p_1  = m_58 ^ m_59 ;
wire p_2  = m_54 ^ m_62 ;
wire p_3  = m_47 ^ m_50 ;
wire p_4  = m_48 ^ m_56 ;
wire p_5  = m_46 ^ m_51 ;
wire p_6  = m_49 ^ m_60 ;
wire p_7  = p_0  ^ p_1  ;
wire p_8  = m_50 ^ m_53 ;
wire p_9  = m_55 ^ m_63 ;
wire p_10 = m_57 ^ p_4  ;
wire p_11 = p_0  ^ p_3  ;
wire p_12 = m_46 ^ m_48 ;
wire p_13 = m_49 ^ m_51 ;
wire p_14 = m_49 ^ m_62 ;
wire p_15 = m_54 ^ m_59 ;
wire p_16 = m_57 ^ m_61 ;
wire p_17 = m_58 ^ p_2  ;
wire p_18 = m_63 ^ p_5  ;
wire p_19 = p_2  ^ p_3  ;
wire p_20 = p_4  ^ p_6  ;
wire p_22 = p_2  ^ p_7  ;
wire p_23 = p_7  ^ p_8  ;
wire p_24 = p_5  ^ p_7  ;
wire p_25 = p_6  ^ p_10 ;
wire p_26 = p_9  ^ p_11 ;
wire p_27 = p_10 ^ p_18 ;
wire p_28 = p_11 ^ p_25 ;
wire p_29 = p_15 ^ p_20 ;

assign W[0] = p_13 ^ p_22;
assign W[1] = p_26 ^ p_29;
assign W[2] = p_17 ^ p_28;
assign W[3] = p_12 ^ p_22;
assign W[4] = p_23 ^ p_27;
assign W[5] = p_19 ^ p_24;
assign W[6] = p_14 ^ p_23;
assign W[7] = p_9  ^ p_16;

endmodule
