
module div(input wire clk, input wire reset, input wire control,
           input wire [31:0] A_in , input wire [31:0] B_in,
           output reg divZero,output reg [31:0] Hi,
           output reg [31:0] Lo);
  
  reg [31:0] mod;
  reg [31:0] quoc;
  reg [31:0] A;
  reg [5:0] counter; //contador pra div em até 32 ciclos
  // A_in -> dividendo ;; B_in -> divisor
  
  always @(posedge clk) begin
    
    if(control == 1'b1 && reset == 1'b0) begin
      
		      
        if(counter == 6'b000000) begin
          mod = B_in;
          quoc = A_in;
        end

        if(counter == 6'b100000) begin
          Hi = A;
          Lo = quoc;
        end

        {A, quoc} = {A, quoc} << 1;
        A = A - mod;

        if(A[31] == 1'b1) begin
          quoc[0] = 1'b0;
          A = A + mod;

        end

        else begin 

          quoc[0] = 1'b1;

        end

        counter = counter + 1;
      
      
    end
    
    
    else if (control == 1'b0 || reset == 1'b1) begin
      
      mod = 32'b00000000000000000000000000000000;
      quoc = 32'b00000000000000000000000000000000;
      A = 32'b00000000000000000000000000000000;
      counter = 6'b000000;
      divZero = 0;
      
    end
    
  end //always

endmodule