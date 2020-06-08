
//
// testbench: tb_bp_aes_sbox
//
module tb_bp_aes_sbox (
input clock,
input reset
);

reg     [ 7: 0] dut_in      = $anyconst; // Input byte
reg             dut_inv     = $anyconst; // Forward or inverse?

wire    [ 7: 0] dut_fwd_out ; // Forward out
wire    [ 7: 0] dut_inv_out ; // Inverse out
wire    [ 7: 0] dut_out     ; // Forward/Inverse out

wire    [ 7: 0] grm_fwd_out ; // Forward out
wire    [ 7: 0] grm_inv_out ; // Inverse out


//
// Formal assertions
// ------------------------------------------------------------

always @(posedge clock) begin
    
    assert(dut_fwd_out == grm_fwd_out);
    assert(dut_inv_out == grm_inv_out);

    if(dut_inv) begin
        assert(dut_out     == grm_inv_out);
    end else begin
        assert(dut_out     == grm_fwd_out);
    end

end


//
// DUT & GRM Instance
// ------------------------------------------------------------

bp_aes_sbox_fwd i_dut_fwd(
.s_in (dut_in     ),
.s_out(dut_fwd_out),
);

bp_aes_sbox_inv i_dut_inv(
.s_in (dut_in     ),
.s_out(dut_inv_out),
);

bp_aes_sbox     i_dut(
.s_in (dut_in   ),
.inv  (dut_inv  ),
.s_out(dut_out  ) 
);

aes_sbox i_grm_fwd(
.in (dut_in     ),
.inv(1'b0       ),
.out(grm_fwd_out)
);

aes_sbox i_grm_inv(
.in (dut_in     ),
.inv(1'b1       ),
.out(grm_inv_out)
);

endmodule

