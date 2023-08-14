module SS(  // StoreSize virou SS
    input wire [1:0] SScontrol,
    input wire [31:0] B_output,
    input wire [31:0] MemDataReg_out,

    output reg [31:0] SScontrol_output
);

    always @(*) begin
        case (SScontrol)
            2'b01: // sw
                SScontrol_output <= B_output;
            2'b10: // sh
                SScontrol_output <= {MemDataReg_out[31:16], B_output[15:0]};
            2'b11: // sb
                SScontrol_output <= {MemDataReg_out[31:8], B_output[7:0]};
        endcase
    end
endmodule