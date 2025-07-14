// Code your testbench here
// or browse Examples
`timescale 1ns/1ns

module alu_tb;

  // Parameters
  parameter WIDTH = 8;

  // Signals
  logic clk;
  logic reset;
  logic [WIDTH-1:0] A, B;
  logic [3:0] ALU_sel;
  logic [WIDTH-1:0] ALU_out;
  logic Zero, Carry, Negative, Overflow;

  // DUT Instantiation
  ALU #(.WIDTH(WIDTH)) dut (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .ALU_sel(ALU_sel),
    .ALU_out(ALU_out),
    .Zero(Zero),
    .Carry(Carry),
    .Negative(Negative),
    .Overflow(Overflow)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Waveform generation
  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);
  end

  // Stimulus
  initial begin
    // Apply reset
    reset = 1;
    A = 0;
    B = 0;
    ALU_sel = 0;
    #10 reset = 0;

    // Test cases
    test_case(8'd5,  8'd3,  4'b0000, "ADD");
    test_case(8'd125,  8'd3,  4'b0000, "ADD");
    test_case(8'd5,  8'd3,  4'b0001, "SUB");
    test_case(8'd5,  8'd13,  4'b0001, "SUB");
    test_case(8'd12, 8'd10, 4'b0010, "AND");
    test_case(8'd12, 8'd10, 4'b0011, "OR");
    test_case(8'd12, 8'd10, 4'b0100, "XOR");
    test_case(8'd113,  8'd3,  4'b0101, "SLL");
    test_case(8'd12, 8'd2,  4'b0110, "SRL");
    test_case(8'd16, 8'd2,  4'b0111, "SRA");
    test_case(8'd3,  8'd7,  4'b1000, "SLT");

    #20;
    $display("Simulation complete.");
    $finish;
  end

  // Task for easy test cases
  task test_case(input [WIDTH-1:0] in1,
                 input [WIDTH-1:0] in2,
                 input [3:0] op,
                 input string op_name);
    begin
      A = in1;
      B = in2;
      ALU_sel = op;
      #10;
      $display("[%s] A=%0d, B=%0d -> Out=%0d | Z=%b C=%b N=%b V=%b",
               op_name, A, B, ALU_out, Zero, Carry, Negative, Overflow);
    end
  endtask

  // Timeout
  initial begin
    #2000;
    $display(" Timeout: Ran out of simulation time.");
    $finish;
  end

endmodule

