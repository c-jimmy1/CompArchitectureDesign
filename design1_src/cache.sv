`timescale 1ns / 1ns

module Cache(
    input clk,
    input [15:0] addr,
    input write,
    input [15:0] data_in,
    output reg [15:0] found,
    output reg hit
);

    reg [15:0] ind_cache [4095:0];
    reg [12:0] index;
    reg [15:0] tag;
    reg [15:0] mem_cache [4095:0];

    always @(negedge clk) begin
        index <= addr[12:0];
        tag <= addr[15:3];
        if (write == 0) begin
            if (ind_cache[index] == addr) begin
                hit <= 1;
                found <= mem_cache[index];
            end
            else begin
                hit <= 0;
                found <= 16'hFFF0;
            end
        end
        else begin
            ind_cache[index] <= addr;
            mem_cache[index] <= data_in;
        end
    end
endmodule
