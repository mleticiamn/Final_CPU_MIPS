module mux_Hi(input wire [31:0] multHi,
              input wire [31:0] divHi,
              input wire control,
              output wire [31:0] mux_Hi_Out);

  assign mux_Hi_Out = (control == 1'b0) ? multHi : divHi;


endmodule