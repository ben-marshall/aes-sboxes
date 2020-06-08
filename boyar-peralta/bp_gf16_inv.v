
//
// Boyar-Peralta GF(2^4) inverter. Figure 1 in paper.
//
module bp_gf16_inv (
input  wire [3:0] x,
output wire [3:0] y
);

wire t1   = x[2] ^ x[3];
wire t2   = x[2] & x[0];
wire t3   = x[1] ^ t2  ;
wire t4   = x[0] ^ x[1];
wire t5   = x[3] ^ t2  ;
wire t6   = t5   & t4  ;
wire t7   = t3   & t1  ;
wire t8   = x[0] & x[3];
wire t9   = t4   & t8  ;
wire t10  = t4   ^ t9  ;
wire t11  = x[1] & x[2];
wire t12  = t1   & t11 ;
wire t13  = t1   ^ t12 ;

assign y[0] = t2   ^ t13 ;
assign y[1] = x[3] ^ t7  ;
assign y[2] = t2   ^ t10 ;
assign y[3] = x[1] ^ t6  ;

endmodule

