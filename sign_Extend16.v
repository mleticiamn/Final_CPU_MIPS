module sign_Extend16( 
    input wire [15:0] OFFSET,

    output wire [31:0] SL_16to32_output
);
    wire [31:0] A1;
    assign A1 = {{16{1'b0}}, OFFSET};

    assign SL_16to32_output = A1 << 16; 

endmodule