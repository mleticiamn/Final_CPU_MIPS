module sign_extend8_32 (
    input wire [31:0] mem_output,
    output wire [31:0] se8_32_output
);

    assign se8_32_output = {{24{1'b0}}, mem_output[7:0]};
endmodule