module mult(
    input wire clk,
    input wire reset,
    input wire control, 
      input wire [31:0] A_in,
      input wire [31:0] B_in, 
      output reg [31:0] Hi,
      output reg [31:0] Lo
);

    reg [31:0] M; //multiplicando
    reg [31:0] Q;   //multiplicador
    reg Q1;
    reg [31:0] A;
      reg [5:0] counter; //operação em até 32 ciclos

      reg aux = 1;

  always @ (posedge clk) begin

    if(control == 1'b1 && reset == 1'b0) begin

      if(counter == 6'b000000) begin

        Q = A_in;
        M = B_in;
        counter = counter + 1;

      end
      else begin

        if(Q[0] == 1'b1 && Q1 == 1'b0) begin

          A = A - M;

        end

        else if(Q[0] == 1'b0 && Q1 == 1'b1) begin

          A = A + M;

        end

        {A, Q, Q1} = {A, Q, Q1} >> 1'b1;


        if(A[30] == 1'b1) begin

          A[31] = 1'b1;

        end

        counter = counter + 1;

      end //else

      if(counter == 6'b100001) begin

        Lo = Q;
        Hi = A;

      end


    end //if1

    else begin

      counter = 6'b000000;
      Q = 32'b00000000000000000000000000000000;
      M = 32'b00000000000000000000000000000000;
      Q1 = 1'b0;
      A = 32'b00000000000000000000000000000000;

    end

  end //always

endmodule