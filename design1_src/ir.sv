`timescale 1ns/1ps

module instruction_register (
    input wire clk,
    input wire reset,
    input wire [15:0] instruction_input,  // Assuming a 16-bit instruction
    output reg [15:0] instruction_output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize IR to 0 on reset
            instruction_output <= 16'b0000000000000000;
        end else begin
            // Update IR with the input instruction on each clock edge
            instruction_output <= instruction_input;
        end
    end

endmodule
