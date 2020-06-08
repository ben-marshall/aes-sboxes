
//
// Boyar-Peralta AES SBox - Forward direction only
// 

module bp_aes_sbox_fwd (
input  wire [7:0] s_in ,
output wire [7:0] s_out
);

wire [7:0] U; // Bit-reversed version of s_in
wire [7:0] S; // Bit reversed version of s_out

genvar i;
generate for(i = 0; i < 8; i=i+1) begin
    assign U    [i] = s_in[7-i];
    assign s_out[i] = S   [7-i];
end endgenerate

wire d= s_in[0];

//
// Top Layer - Forward

wire t_1   = U[0 ] ^ U[3];
wire t_2   = U[0 ] ^ U[5];
wire t_3   = U[0 ] ^ U[6];
wire t_4   = U[3 ] ^ U[5];
wire t_5   = U[4 ] ^ U[6];
wire t_6   = t_1   ^ t_5 ;
wire t_7   = U[1 ] ^ U[2];
wire t_8   = U[7 ] ^ t_6 ;
wire t_9   = U[7 ] ^ t_7 ;
wire t_10  = t_6   ^ t_7 ;
wire t_11  = U[1 ] ^ U[5] ;
wire t_12  = U[2 ] ^ U[5] ;
wire t_13  = t_3   ^ t_4  ;
wire t_14  = t_6   ^ t_11 ;
wire t_15  = t_5   ^ t_11 ;
wire t_16  = t_5   ^ t_12 ;
wire t_17  = t_9   ^ t_16 ;
wire t_18  = U[3 ] ^ U[7] ;
wire t_19  = t_7   ^ t_18 ;
wire t_20  = t_1   ^ t_19 ;
wire t_21  = U[6 ] ^ U[7] ;
wire t_22  = t_7   ^ t_21 ;
wire t_23  = t_2   ^ t_22 ;
wire t_24  = t_2   ^ t_10 ;
wire t_25  = t_20  ^ t_17 ;
wire t_26  = t_3   ^ t_16 ;
wire t_27  = t_1   ^ t_12 ;

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

endmodule

