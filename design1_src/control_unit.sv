`timescale 1ns/1ps
`include "pc.sv"
`include "ir.sv"

module control_unit (
    input wire clk,
    input wire reset,
    input wire [15:0] instruction,
    output reg reg_write_enable,
    output reg [3:0] alu_op,
    output reg pc_write_enable,
    output reg jump_enable,
    output reg halt
);

    // Define opcodes
    parameter ADD_OPCODE   = 4'b1000;
    parameter HALT_OPCODE  = 4'b1001;
    parameter LOAD_OPCODE  = 4'b1010;
    parameter STORE_OPCODE = 4'b1011;
    parameter CLEAR_OPCODE = 4'b1100;
    parameter SKIP_OPCODE  = 4'b1101;
    parameter JUMP_OPCODE  = 4'b1110;


    // Instantiate PC and IR modules
    program_counter PC (
        .clk(clk),
        .reset(reset),
        .pc()
    );

    instruction_register IR (
        .clk(clk),
        .reset(reset),
        .instruction_input(instruction),
        .instruction_output()
    );

    // Control unit logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_write_enable <= 0;
            alu_op <= 4'b0000;
            pc_write_enable <= 0;
            jump_enable <= 0;
            halt <= 0;
        end else begin
            case (IR.instruction_output[15:12])
                ADD_OPCODE: begin
                    reg_write_enable <= 1;
                    alu_op <= 4'b1000; // Example: ADD operation
                    pc_write_enable <= 1;
                    jump_enable <= 0;
                    halt <= 0;
                end
                HALT_OPCODE: begin
                    reg_write_enable <= 0;
                    alu_op <= 4'b1001;
                    pc_write_enable <= 0;
                    jump_enable <= 0;
                    halt <= 1;
                end
                LOAD_OPCODE: begin
                    reg_write_enable <= 1;
                    alu_op <= 4'b1010; // Example: Assuming LOAD operation sets ALU op to 0
                    pc_write_enable <= 1;
                    jump_enable <= 0;
                    halt <= 0;
                end
                STORE_OPCODE: begin
                    reg_write_enable <= 0;
                    alu_op <= 4'b1011; // Example: Assuming STORE operation sets ALU op to 0
                    pc_write_enable <= 1;
                    jump_enable <= 0;
                    halt <= 0;
                end
                CLEAR_OPCODE: begin
                    reg_write_enable <= 1;
                    alu_op <= 4'b1100; // Example: Assuming CLEAR operation sets ALU op to 0
                    pc_write_enable <= 1;
                    jump_enable <= 0;
                    halt <= 0;
                end
                SKIP_OPCODE: begin
                    reg_write_enable <= 0;
                    alu_op <= 4'b1101;
                    pc_write_enable <= 1;
                    jump_enable <= 1; // Example: Assuming SKIP operation enables jumping
                    halt <= 0;
                end
                JUMP_OPCODE: begin
                    reg_write_enable <= 0;
                    alu_op <= 4'b1110;
                    pc_write_enable <= 0;
                    jump_enable <= 1; // Example: Assuming JUMP operation enables jumping
                    halt <= 0;
                end
                default: begin
                    // Handle unknown opcodes or NOP
                    reg_write_enable <= 0;
                    alu_op <= 4'b0000;
                    pc_write_enable <= 0;
                    jump_enable <= 0;
                    halt <= 0;
                end
            endcase
        end
    end

endmodule
