module mux_IorD(

    input wire [1:0] mux_IorD_control,
    input wire [31:0] PCOut,
    input wire [31:0] ALU_Result,
    input wire [31:0] ALU_Out,
    output wire [31:0] iord_output

);

    assign iord_output = (mux_IorD_control == 2'b00) ? PCOut : (mux_IorD_control == 2'b01) ? ALU_Result :ALU_Out;

endmodule