module concat( 
    input wire [25:21] RS,
    input wire [20:16] RT,
    input wire [15:0] OFFSET,
    input wire [31:0] PCOut,

    output wire [31:0] conc_SL26_PC_output
);

    assign conc_SL26_PC_output = {PCOut[31:28], RT, RS, OFFSET, 2'b00};

endmodule