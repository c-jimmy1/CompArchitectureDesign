`timescale 1 ns / 1 ps

module decoder #(parameter ENCODE_WIDTH = 4) (
    input  [ENCODE_WIDTH-1:0] in,
    output [2**ENCODE_WIDTH-1:0] out
);

    localparam latency = 1;

    assign #latency out = 'b1 << in;

endmodule
