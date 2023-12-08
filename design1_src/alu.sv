`timescale 1ns / 1ps

module alu(
    input [15:0] A, B,
    input [3:0] ALU_Sel,
    output reg [15:0] ALU_Out,
    output reg CarryOut
    );

    reg [15:0] ALU_Result;
    wire [16:0] tmp;

    assign tmp = {1'b0, A} + {1'b0, B};
    assign CarryOut = tmp[16];

    always @* begin
        case (ALU_Sel)
            4'b0000: begin // ADD
                ALU_Result = A + B;
            end
            4'b0001: begin // SUB
                ALU_Result = A - B;
            end
            4'b0010: ALU_Result = A & B; // AND
            4'b0011: ALU_Result = A | B; // OR
            4'b0100: ALU_Result = A ^ B; // XOR
            4'b0101: ALU_Result = ~A;    // NOT for A
            4'b0110: ALU_Result = ~B;    // NOT for B
            4'b0111: ALU_Result = 0;     // Clear
            default: ALU_Result = A; // Default: A
        endcase
    end

    assign ALU_Out = ALU_Result;

endmodule
