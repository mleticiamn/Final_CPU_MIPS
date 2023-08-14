module shift_src(
    input  wire ShiftSrc,
    input wire [31:0] A_output,
    input wire [31:0] B_output,
    output wire [31:0] ShiftSrc_output
);


    assign ShiftSrc_output = (ShiftSrc == 1'b1) ? B_output : A_output;

endmodule