`timescale 1 ns / 1 ps

module test_instruction_register;

  reg clk;
  reg reset;
  reg [15:0] instruction_input;
  wire [15:0] instruction_output;

  instruction_register uut (
      .clk(clk),
      .reset(reset),
      .instruction_input(instruction_input),
      .instruction_output(instruction_output)
  );

  initial begin
    $dumpfile("ir_dump.vcd");
    $dumpvars;
    
    // Initialize inputs
    clk = 0;
    reset = 1;
    instruction_input = 16'h1234; // Sample instruction

    $display("Time = %0t: Initial values - clk = %b, reset = %b, instruction_input = %h, instruction_output = %h", $time, clk, reset, instruction_input, instruction_output);

    // Apply a reset
    #10 reset = 0;

    // Clock the design for 20 cycles
    repeat (20) begin
      #5 clk = ~clk;
      $display("Time = %0t: Clock cycle - clk = %b, instruction_output = %h", $time, clk, instruction_output);
    end

    // Change the input instruction
    #10 instruction_input = 16'h5678;
    $display("Time = %0t: Input instruction changed - instruction_input = %h", $time, instruction_input);

    // Clock for 10 more cycles
    repeat (10) begin
      #5 clk = ~clk;
      $display("Time = %0t: Clock cycle - clk = %b, instruction_output = %h", $time, clk, instruction_output);
    end

    // Finish simulation
    #10 $finish;
  end

endmodule
