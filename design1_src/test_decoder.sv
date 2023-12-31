`timescale 1 ns / 1 ps

module test_decoder;

  parameter ENCODE_WIDTH = 4;
  parameter DECODE_WIDTH = 2**ENCODE_WIDTH;

  reg osc;
  reg [ENCODE_WIDTH-1:0] in;
  reg [DECODE_WIDTH-1:0] out;

  localparam period = 10;

  wire clk; 
  assign clk = osc;

  decoder #(.ENCODE_WIDTH(ENCODE_WIDTH)) u0 (
      .in(in),
      .out(out)
  );

  integer i;

  always begin  // Clock wave
     #period  osc = ~osc;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    {osc, in} <= 0;

    for (i = 0; i < 16; i = i + 1) begin
      @(posedge clk) in = i;
      $display("Input in = %0d, Output out = %0d", in, out);
    end

    #(period * 16) $finish;
  end
  
endmodule
