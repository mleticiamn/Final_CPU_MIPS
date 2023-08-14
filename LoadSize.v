module LoadSize(
    input wire [1:0] LScontrol,
    input wire [31:0] MemDataReg_out,

    output reg [31:0] LScontrol_output
);

    always @(*) begin
        case (LScontrol)
            2'b01: // lw
                LScontrol_output <= MemDataReg_out;
            2'b10: // lh
                LScontrol_output <= {16'd0, MemDataReg_out[15:0]};
            2'b11: // lb
                LScontrol_output <= {24'd0, MemDataReg_out[7:0]};
        endcase
    end
endmodule