`timescale 1ns / 1ps

module alu(input [15:0] A, B,  // ALU 16-bit Inputs
           input [3:0] ALU_Sel, // ALU Selection
           output reg [15:0] ALU_Out, // ALU 16-bit Output
           output reg CarryOut // Carry Out
         );
   reg [15:0] ALU_Result;
   wire [16:0] tmp;
   assign ALU_Out = ALU_Result; // ALU out
   assign tmp = {1'b0, A} + {1'b0, B};
   assign CarryOut = tmp[16];

   always @(*) 
   begin
      case (ALU_Sel) 
      4'b0000:
         ALU_Result = A + B; // ADD
      4'b0001:
         ALU_Result = A - B; // SUB
      4'b0010:
         ALU_Result = A & B; // AND
      4'b0011:
         ALU_Result = A | B; // Bitwise OR
      4'b0100:
         ALU_Result = A ^ B; // Bitwise XOR
      4'b0101:
         ALU_Result = ~A;    // Bitwise NOT for A
      4'b0110:
         ALU_Result = ~B;    // Bitwise NOT for B
      4'b0111:
         ALU_Result = A << 1; // Shift Left A by 1
      4'b1000:
         ALU_Result = A >> 1; // Shift Right A by 1
      default: ALU_Result = A;  // Default: Output 0
      endcase
   end
endmodule
