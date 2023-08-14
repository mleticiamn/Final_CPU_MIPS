module mux_Low(input wire [31:0] multLow,
               input wire [31:0] divLow,
              input wire control,
               output wire [31:0] mux_Low_Out);

  assign mux_Low_Out = (control == 1'b0) ? multLow : divLow;


endmodule