`timescale 1 ns / 1 ps

module Accumulator(
    input wire clk, // Clock input
    input wire reset, // Reset signal
    input wire [15:0] dataIn, // Input data to be accumulated
    input wire enable, // Enable signal for accumulation
    output reg [15:0] accumulator // Output accumulator value
);

    reg [15:0] internalAcc; // Internal register for accumulation

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            internalAcc <= 16'h0000; // Reset the accumulator on reset signal
        end else if (enable) begin
            internalAcc <= internalAcc + dataIn; // Accumulate the input data
        end
    end

    // Output the accumulator value
    always @* begin
        accumulator = internalAcc;
    end

endmodule
