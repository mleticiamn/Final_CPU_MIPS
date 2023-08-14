module mux_pcSource(
    input wire [2:0] pcSource_control,
    input wire [31:0] ALU_Result,
    input wire [31:0] conc_SL26_PC_output,
    input wire [31:0] ALU_Out,
    input wire [31:0] EPC_output,
    input wire [31:0] sign_extend8_32_output,
    output wire [31:0] PCSrc_output
);

    assign PCSrc_output = (pcSource_control == 3'b000) ? ALU_Result : (pcSource_control == 3'b001) ? 
    conc_SL26_PC_output : (pcSource_control == 3'b010) ? ALU_Out : (pcSource_control == 3'b011) ?
    EPC_output : sign_extend8_32_output;

endmodule