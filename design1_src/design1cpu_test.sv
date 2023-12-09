`timescale 1 ns / 1 ps

module test_cpu;
  parameter ADDR_WIDTH = 18;
  parameter DATA_WIDTH = 16;
  
  reg osc;
  localparam period = 10;

  wire clk; 
  assign clk = osc; 

  reg cs;
  reg we;
  reg oe;
  integer i;
  reg [ADDR_WIDTH-1:0] MAR;
  wire [DATA_WIDTH-1:0] data;
  reg [DATA_WIDTH-1:0] testbench_data;
  assign data = !oe ? testbench_data : 'hz;

  single_port_sync_ram_large  #(.DATA_WIDTH(DATA_WIDTH)) ram
  (   .clk(clk),
   .addr(MAR),
      .data(data[DATA_WIDTH-1:0]),
      .cs_input(cs),
      .we(we),
      .oe(oe)
  );
  
  reg [15:0] A;
  reg [15:0] B;
  reg [15:0] ALU_Out;
  reg [1:0] ALU_Sel;
  alu alu16(
    .A(A),
    .B(B),  // ALU 16-bit Inputs
    .ALU_Sel(ALU_Sel),// ALU Selection
    .ALU_Out(ALU_Out) // ALU 16-bit Output
     );
  
  reg [15:0] PC = 'h100;
  reg [15:0] IR = 'h0;
  reg [15:0] MBR = 'h0;
  reg [15:0] AC = 'h0;

  initial osc = 1;  //init clk = 1 for positive-edge triggered
  always begin  // Clock wave
     #period  osc = ~osc;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    // Fibonacci 11 program
    @(posedge clk) MAR <= 'h0000100; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h08001048;
    @(posedge clk) MAR <= 'h0000102; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h18001040;
    @(posedge clk) MAR <= 'h0000104; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h18001044;
    @(posedge clk) MAR <= 'h0000106; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10001048;
    @(posedge clk) MAR <= 'h0000108; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h08001044;
    @(posedge clk) MAR <= 'h000010A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10001040;
    @(posedge clk) MAR <= 'h000010C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h08001048;
    @(posedge clk) MAR <= 'h000010E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10001044;
    @(posedge clk) MAR <= 'h0000110; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h08001054;
    @(posedge clk) MAR <= 'h0000112; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10001048;
    @(posedge clk) MAR <= 'h0000114; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0800104c;
    @(posedge clk) MAR <= 'h0000116; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h18001050;
    @(posedge clk) MAR <= 'h0000118; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1000104c;
    @(posedge clk) MAR <= 'h000011A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h52000000;
    @(posedge clk) MAR <= 'h000011C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h58001000;
    @(posedge clk) MAR <= 'h000011E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h40000000;
    @(posedge clk) MAR <= 'h0000120; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00000001;
    @(posedge clk) MAR <= 'h0000122; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00000001;

    @(posedge clk) PC <= 'h0000100;

    for (i = 0; i < 62; i = i+1) begin
      
    end
  end

endmodule