`timescale 1ns / 1ps
module alu_testbench;
    //Inputs
    reg[15:0] A, B;
    reg[3:0] ALU_Sel;
    //Outputs
    wire[15:0] ALU_Out;
    wire CarryOut;

    integer i;
    alu test_unit(A, B, ALU_Sel, ALU_Out, CarryOut);
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, alu_testbench);
        A = 16'hFA;
        B = 16'h02;
        ALU_Sel = 4'h0;
        for (i = 0; i < 8; i = i + 1) begin
            ALU_Sel = ALU_Sel + 4'h1;
            #10;
        end
    end
endmodule
