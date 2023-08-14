module sign_extend1_32(
    input wire lt_out,
    output wire [31:0] extend_out1
);

    assign extend_out1 = {{32{1'b0}}, lt_out};

endmodule