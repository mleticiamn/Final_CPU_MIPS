module shift_left_2(
    input wire [31:0] sign_extend_out,
    output wire [31:0] shiftLft2_output
);

    assign shiftLft2_output = sign_extend_out << 2; 

endmodule