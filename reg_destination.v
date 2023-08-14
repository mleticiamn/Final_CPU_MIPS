module reg_destination(
    input wire [1:0] mux_toRegs_control,
    input wire [20:16] RT,
    input wire [15:11] OFFSET,
    output wire [4:0] regDest_output
);

    assign regDest_output = (mux_toRegs_control == 2'b00) ? RT : (mux_toRegs_control == 2'b01) ? OFFSET : (mux_toRegs_control == 2'b10) ? 5'd30 : 5'd31;

endmodule