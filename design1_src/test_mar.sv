`timescale 1 ns / 1 ps

module test_memory_access_register;

  reg clk;
  reg reset;
  reg [15:0] address_input;
  wire [15:0] address_output;

  memory_access_register uut (
      .clk(clk),
      .reset(reset),
      .address_input(address_input),
      .address_output(address_output)
  );

  initial begin
    $dumpfile("mar_dump.vcd");
    $dumpvars;
    
    // Initialize inputs
    clk = 0;
    reset = 1;
    address_input = 16'h1234; // Sample address

    $display("Time = %0t: Initial values - clk = %b, reset = %b, address_input = %h, address_output = %h", $time, clk, reset, address_input, address_output);

    // Apply a reset
    #10 reset = 0;

    // Clock the design for 20 cycles
    repeat (20) begin
      #5 clk = ~clk;
      $display("Time = %0t: Clock cycle - clk = %b, address_output = %h", $time, clk, address_output);
    end

    // Change the input address
    #10 address_input = 16'h5678;
    $display("Time = %0t: Input address changed - address_input = %h", $time, address_input);

    // Clock for 10 more cycles
    repeat (10) begin
      #5 clk = ~clk;
      $display("Time = %0t: Clock cycle - clk = %b, address_output = %h", $time, clk, address_output);
    end

    // Finish simulation
    #10 $finish;
  end

endmodule
