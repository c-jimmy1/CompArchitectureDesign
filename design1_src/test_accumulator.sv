`timescale 1 ns / 1 ps

module test_accumulator();

    // Declare signals for testbench
    reg clk;
    reg reset;
    reg [15:0] dataIn;
    reg enable;
    wire [15:0] accumulator_out;

    // Instantiate the accumulator module
    Accumulator accumulator(
        .clk(clk),
        .reset(reset),
        .dataIn(dataIn),
        .enable(enable),
        .accumulator(accumulator_out)
    );

    // Clock generation
    always #5 clk = ~clk; // Create a clock with 10ns period

    // Test stimulus
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, test_accumulator);
        clk = 0;
        reset = 1;
        dataIn = 16'h0000; // Input value for accumulation
        enable = 0;

        #20 reset = 0; // Deassert reset after 100ns
        #10 enable = 1; // Enable accumulation after 50ns

        // Test case 1
        dataIn = 16'h0003; // Input value for accumulation
        #50; // Wait for 250ns
        // Check the accumulator value
        $display("Accumulator Value: %h", accumulator_out);
        
        // Test case 2
        dataIn = 16'h0005; // Another input value
        #50; // Wait for 250ns
        // Check the accumulator value
        $display("Accumulator Value: %h", accumulator_out);

        // Add more test cases as needed...

        #100; // Additional time for simulation stability
        $finish; // Stop simulation after test cases
    end

endmodule
