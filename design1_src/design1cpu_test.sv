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
    // Fibonacci 11 program with direct addressing
    @(posedge clk) MAR <= 'h0000100; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10000005;
    @(posedge clk) MAR <= 'h0000102; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10000006;
    @(posedge clk) MAR <= 'h0000104; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10110007;
    @(posedge clk) MAR <= 'h0000106; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10000006;
    @(posedge clk) MAR <= 'h0000108; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10110004;
    @(posedge clk) MAR <= 'h000010A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10000007;
    @(posedge clk) MAR <= 'h000010C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10110006;
    @(posedge clk) MAR <= 'h000010E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10000008;
    @(posedge clk) MAR <= 'h0000110; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1000000F;
    @(posedge clk) MAR <= 'h0000112; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10110008;
    @(posedge clk) MAR <= 'h0000114; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h11004000;
    @(posedge clk) MAR <= 'h0000116; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10000000;
    @(posedge clk) MAR <= 'h0000118; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10010000;
    @(posedge clk) MAR <= 'h000011A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00000000;
    @(posedge clk) MAR <= 'h000011C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00000001;
    @(posedge clk) MAR <= 'h000011E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00000000;
    @(posedge clk) MAR <= 'h0000120; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0000000A;
    @(posedge clk) MAR <= 'h0000122; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'hFFFF00FF;

    @(posedge clk) PC <= 'h0000100;

    for (i = 0; i < 62; i = i+1) begin
          // Fetch
          @(posedge clk) MAR <= PC; we <= 0; cs <= 1; oe <= 1;
          @(posedge clk) IR <= data;
          @(posedge clk) PC <= PC + 1;
          // Decode and execute
      case(IR[15:12])
        4'b0001: begin//load
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= data;
              #20;
              #1;
              @(posedge clk) AC <= MBR;
        end 
		    4'b0010: begin//store
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= AC;
              @(posedge clk) we <= 1; oe <= 0; testbench_data <= MBR;      
              #20;
              #1;
        end
        4'b0011: begin//add
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= data;
              #20;
              #1;
              @(posedge clk) ALU_Sel <= 'b01; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        4'b0100: begin//subtract
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= data;
              #20;
              #1;
              @(posedge clk) ALU_Sel <= 'b10; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        4'b0101: begin//and
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= data;
              #20;
              #1;
              @(posedge clk) ALU_Sel <= 'b11; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        4'b0110: begin//or
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= data;
              #20;
              #1;
              @(posedge clk) ALU_Sel <= 'b00; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        4'b0111: begin//halt
              @(posedge clk) PC <= PC - 1;
        end
        4'b1000: begin//skip
          @(posedge clk)
          if(IR[11:10]==2'b01 && AC == 0) PC <= PC + 1;
          else if(IR[11:10]==2'b00 && AC < 0) PC <= PC + 1;
          else if(IR[11:10]==2'b10 && AC > 0) PC <= PC + 1;
        end
        4'b1001: begin //jump
              @(posedge clk) PC <= IR[11:0];
        end
        4'b1010: begin 
          @(posedge clk) AC <= 0;
        end
          
      endcase
    end

    @(posedge clk) MAR  <= 'h10110004; we <= 0; cs <= 1; oe <= 1;
    @(posedge clk);

    #20 $finish;

  end

endmodule