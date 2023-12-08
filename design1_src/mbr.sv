`timescale 1ns/1ps

module memory_buffer_register (
    input wire clk,
    input wire reset,
    input wire [15:0] data_input,
    output reg [15:0] data_output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize MBR to 0 on reset
            data_output <= 16'b0;
        end else begin
            // Update MBR with the input data on each clock edge
            data_output <= data_input;
        end
    end

endmodule
