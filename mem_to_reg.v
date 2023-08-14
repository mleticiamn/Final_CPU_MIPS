module mux_SrcData(
    input wire [3:0] srcData_control,

    input wire [31:0] ALU_Out,
    input wire [31:0] sign_extend1_32_output, 
    input wire [31:0] shiftReg_output,
    input wire [31:0] HI_output, 
    input wire [31:0] LO_output,
    input wire [31:0] SL_16to32_output,
    input wire [31:0] LScontrol_output,

    output wire [31:0] MEMtoREG_output
);

    assign MEMtoREG_output = (srcData_control == 4'b0000) ? ALU_Out :
     (srcData_control == 4'b0001) ? sign_extend1_32_output :
      (srcData_control == 4'b0010) ? shiftReg_output :
       (srcData_control == 4'b0011) ? HI_output :
        (srcData_control == 4'b0100) ? LO_output :
        (srcData_control == 4'b0101) ? SL_16to32_output :
        (srcData_control == 4'b110) ? LScontrol_output :
            32'd227;

endmodule