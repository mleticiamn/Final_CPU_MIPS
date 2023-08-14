module mux_aluSrcB(
    input wire [1:0] aluSourceB_control,
    input wire [31:0] B_output, 
    input wire [31:0] sign_extend_1_out, 
    input wire [31:0] shift_left_2_output, 
    output wire [31:0] srcB_output 
);

    assign srcB_output = (aluSourceB_control == 2'b00) ? B_output : (aluSourceB_control == 2'b01) ? 32'd4 : (aluSourceB_control == 2'b10) ? sign_extend_1_out : shift_left_2_output;

endmodule