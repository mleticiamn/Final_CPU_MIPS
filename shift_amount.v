module shift_amount(
    input  wire ShiftAmt,
    input wire [31:0] B_output,
    input wire [10:6] OFFSET, 
    output wire [4:0] ShiftAmt_output
);
    assign ShiftAmt_output = (ShiftAmt == 1'b1) ? OFFSET : B_output;

endmodule