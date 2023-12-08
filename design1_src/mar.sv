module memory_access_register (
    input wire clk,
    input wire reset,
    input wire [15:0] address_input,  // Assuming a 16-bit address bus
    output reg [15:0] address_output
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize MAR to 0 on reset
            address_output <= 16'b0000000000000000;
        end else begin
            // Update MAR with the input address on each clock edge
            address_output <= address_input;
        end
    end

endmodule
