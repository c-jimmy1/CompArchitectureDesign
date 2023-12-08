`timescale 1 ns / 1 ps

module program_counter (
    input wire clk,
    input wire reset,
    output reg [3:0] pc
);

    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 4'b0000; // Initialize PC to 0 on reset
        end else begin
            pc <= pc + 1; // Increment PC on each clock edge
        end
    end

endmodule
