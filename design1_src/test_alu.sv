`timescale 1ns / 1ps

module test_alu;
    // Inputs
    reg[15:0] A, B;
    reg[3:0] ALU_Sel;
    // Outputs
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
            #10;

            // Display operation name, inputs, and ALU_Out value after operation
            case (ALU_Sel)
                4'h0: $display("Operation: ADD, A = %h, B = %h, ALU_Out = %h, CarryOut = %b", A, B, ALU_Out, CarryOut);
                4'h1: $display("Operation: SUB, A = %h, B = %h, ALU_Out = %h, CarryOut = %b", A, B, ALU_Out, CarryOut);
                // Add cases for other operations similarly
            endcase

            // Increment ALU_Sel for the next operation
            ALU_Sel = ALU_Sel + 4'h1;
        end
        $finish; // End simulation after loop
    end
endmodule
