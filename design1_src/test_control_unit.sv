`timescale 1ns/1ps

module tb_control_unit;

    // Inputs
    reg clk;
    reg reset;
    reg [15:0] instruction;

    // Outputs
    wire reg_write_enable;
    wire [3:0] alu_op;
    wire pc_write_enable;
    wire jump_enable;
    wire halt;

    // Instantiate the control_unit module
    control_unit dut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .reg_write_enable(reg_write_enable),
        .alu_op(alu_op),
        .pc_write_enable(pc_write_enable),
        .jump_enable(jump_enable),
        .halt(halt)
    );

    // Create a VCD file for waveform dumping
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_control_unit);
    end

    // Clock generation
    initial begin
        #5; // Initial delay before starting clock
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        // Initialize inputs
        reset = 1;
        instruction = 16'h0000;

        // Apply reset
        #10 reset = 0;

        // Test case 1: ADD opcode
        #10 instruction = 16'b1000100000000001; // Assuming ADD operation
        #10 $display("Test Case 1: ADD opcode - reg_write_enable: %b, alu_op: %b, pc_write_enable: %b, jump_enable: %b, halt: %b", reg_write_enable, alu_op, pc_write_enable, jump_enable, halt);
        
        // Test case 2: HALT opcode
        #10 instruction = 16'b1001100000000010; // Assuming HALT operation
        #10 $display("Test Case 2: HALT opcode - reg_write_enable: %b, alu_op: %b, pc_write_enable: %b, jump_enable: %b, halt: %b", reg_write_enable, alu_op, pc_write_enable, jump_enable, halt);

        // Test case 3: LOAD opcode
        #10 instruction = 16'b1010100000000011; // Assuming LOAD operation
        #10 $display("Test Case 3: LOAD opcode - reg_write_enable: %b, alu_op: %b, pc_write_enable: %b, jump_enable: %b, halt: %b", reg_write_enable, alu_op, pc_write_enable, jump_enable, halt);

        // Test case 4: STORE opcode
        #10 instruction = 16'b1011100000000100; // Assuming STORE operation
        #10 $display("Test Case 4: STORE opcode - reg_write_enable: %b, alu_op: %b, pc_write_enable: %b, jump_enable: %b, halt: %b", reg_write_enable, alu_op, pc_write_enable, jump_enable, halt);

        // Test case 5: CLEAR opcode
        #10 instruction = 16'b1100100000000101; // Assuming CLEAR operation
        #10 $display("Test Case 5: CLEAR opcode - reg_write_enable: %b, alu_op: %b, pc_write_enable: %b, jump_enable: %b, halt: %b", reg_write_enable, alu_op, pc_write_enable, jump_enable, halt);

        // Test case 6: SKIP opcode
        #10 instruction = 16'b1101100000000110; // Assuming SKIP operation
        #10 $display("Test Case 6: SKIP opcode - reg_write_enable: %b, alu_op: %b, pc_write_enable: %b, jump_enable: %b, halt: %b", reg_write_enable, alu_op, pc_write_enable, jump_enable, halt);

        // Test case 7: JUMP opcode
        #10 instruction = 16'b1110100000000111; // Assuming JUMP operation
        #10 $display("Test Case 7: JUMP opcode - reg_write_enable: %b, alu_op: %b, pc_write_enable: %b, jump_enable: %b, halt: %b", reg_write_enable, alu_op, pc_write_enable, jump_enable, halt);

        // Add more test cases as needed

        #100 $finish; // Finish simulation after a while
    end

endmodule
