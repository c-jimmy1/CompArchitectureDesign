`timescale 1 ns / 1 ps

module test_program_counter;

  reg clk;
  reg reset;
  wire [3:0] pc;

  program_counter uut (
      .clk(clk),
      .reset(reset),
      .pc(pc)
  );

  initial begin
    $dumpfile("pc_dump.vcd");
    $dumpvars;
    
    // Initialize inputs
    clk = 0;
    reset = 1;

    // Apply a reset
    #10 reset = 0;

    // Clock the design for 20 cycles
    repeat (20) begin
      #5 clk = ~clk;
    end

    // Assert reset again
    #10 reset = 1;

    // Clock for 10 more cycles
    repeat (10) begin
      #5 clk = ~clk;
    end

    // Finish simulation
    #10 $finish;
  end

endmodule
