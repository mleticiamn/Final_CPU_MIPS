module mux_aluSrcA(
    input wire srcA_selector,
    input wire [31:0] PCOut, // 0
    input wire [31:0] A_output, // 1
    output wire [31:0] srcA_output
);

    assign srcA_output = (srcA_selector) ? A_output : PCOut;

endmodule