`timescale 1 ns / 1 ps

module test_ram;

  reg clk;
  reg cs;
  reg we;
  reg oe;
  reg [15:0] addr;
  wire [7:0] data;
  reg [7:0] testbench_data;

  single_port_sync_ram #(.ADDR_WIDTH(16), .DATA_WIDTH(8)) test 
  (
    .clk(clk),
    .addr(addr),
    .data(data),
    .cs(cs),
    .we(we),
    .oe(oe)
  );

  
  always #20 clk = ~clk;
  assign data = !oe ? testbench_data : 'bz;
 
  integer i;
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    {clk, cs, we, addr, testbench_data, oe} <= 0;

    for(i = 0; i < 16; i = i+1) begin
        repeat (1) @(posedge clk) begin
        addr <= i; 
        we <= 1; 
        cs <= 1; 
        oe <= 0; 
        testbench_data <= $random;
        $display("Writing data %h to address %d", testbench_data, i);  // Show the write Operation (we = 1)
      end
    end

    for (i = 0; i < 16; i = i+1) begin  
      repeat (1) @(posedge clk) begin
        addr <= i;
        we <= 0;
        cs <= 1;
        oe <= 1;
        $display("Reading data %h from address %d", data, i); // Show the read operation (we = 0)
      end
    end

    @(posedge clk) cs <= 0;

    #30 $finish; 
  end
endmodule



