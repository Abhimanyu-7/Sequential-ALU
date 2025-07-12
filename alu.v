`timescale 1ns/1ns

module ALU #(parameter WIDTH = 8)
(
  input clk,
  input reset,
  input [WIDTH-1:0] A,
  input [WIDTH-1:0] B,
  input [3:0] ALU_sel,
  output reg [WIDTH-1:0] ALU_out,
  output reg Zero,
  output reg Carry,
  output reg Negative,
  output reg Overflow
);

  reg [WIDTH:0] temp;
  reg temp_carry;
  reg temp_overflow;

  // Combinational block for COmputation Logic
  always @(*) 
   begin
    temp_carry = 0;
    temp_overflow = 0;
    temp = 0;

    case (ALU_sel)
      4'b0000: begin // ADD
        temp = A + B;
        temp_carry = temp[WIDTH];
        temp_overflow = (~A[WIDTH-1] & ~B[WIDTH-1] & temp[WIDTH-1]) |
                        ( A[WIDTH-1] &  B[WIDTH-1] & ~temp[WIDTH-1]);
      end

      4'b0001: begin // SUB
        temp = A - B;
        temp_carry = temp[WIDTH]; // Carry = 1 means no borrow
        temp_overflow = (A[WIDTH-1] & ~B[WIDTH-1] & ~temp[WIDTH-1]) |
                        (~A[WIDTH-1] & B[WIDTH-1] & temp[WIDTH-1]);
      end

      4'b0010: temp = A & B; // AND
      4'b0011: temp = A | B; // OR
      4'b0100: temp = A ^ B; // XOR

      4'b0101: temp = A << B[2:0]; // SLL (limit shift to 3 bits)
      4'b0110: temp = A >> B[2:0]; // SRL

      4'b0111: temp = $signed(A) >>> B[2:0]; // SRA
      4'b1000: temp = ($signed(A) <  $signed(B)) ? 1 : 0; //SLT

      default: temp = 8'b0;
    endcase
  end

  // Sequential block for Output Logic
  always @(posedge clk or posedge reset) begin
    if (reset) 
    begin
      ALU_out <= 0;
      Zero <= 0;
      Carry <= 0;
      Negative <= 0;
      Overflow <= 0;
    end else begin
      ALU_out <= temp[WIDTH-1:0];
      Zero <= (temp[WIDTH-1:0] == 0);
      Negative <= temp[WIDTH-1];
      Carry <= temp_carry;
      Overflow <= temp_overflow;
    end
  end
endmodule

