`timescale 1 ns / 1 ps

module test_memory_buffer_register;
  reg clk = 0;
  reg reset = 0;
  reg [15:0] data_input = 1234;
  wire [15:0] data_output;

  // Instantiate the memory_buffer_register module
  memory_buffer_register uut (
    .clk(clk),
    .reset(reset),
    .data_input(data_input),
    .data_output(data_output)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Testbench logic
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    // Display initial values
    #10 $display("Time = %0t: Initial values - clk = %b, reset = %b, data_input = %h, data_output = %h", $time, clk, reset, data_input, data_output);

    // Apply reset
    reset = 1;
    #10 reset = 0;

    // Display values after reset
    #10 $display("Time = %0t: After reset - clk = %b, reset = %b, data_input = %h, data_output = %h", $time, clk, reset, data_input, data_output);

    // Apply test data transfer
    data_input = 5678;
    #10;

    // Display values after test data transfer
    #10 $display("Time = %0t: After test data transfer - clk = %b, reset = %b, data_input = %h, data_output = %h", $time, clk, reset, data_input, data_output);

    // Simulate for an additional 1000 time units
    #1000;

    // Finish simulation
    #10 $finish;
  end
endmodule
