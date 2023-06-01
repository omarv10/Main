`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 03:14:46 PM
// Design Name: 
// Module Name: idecode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module idecode(
   input  logic   clk, reset,
   input logic   [31:0] InstrD,
   input logic   [31:0] PCD,PCPlus4D,
   input logic   RegWriteW,
   input logic [31:0] ResultW,
   input logic [4:0] RdW,
   output logic [31:0] PCE,
   output logic [31:0] PCPlus4E,
   output logic [31:0] RD1E,
   output logic [31:0] RD2E,
   output logic [4:0] RDE,
   output logic [31:0] ImmExtE,
   output logic  ALUSrcE,
   output logic  BranchE,
   output logic  JumpE,
   output logic  RegWriteE,
   output logic [1:0] ResultSrcE,
   output logic MemWriteE,
   output logic [2:0] ALUControlE
    );
   
    //signals
   //logic InstrD;
   logic [1:0] ImmSrcD;
   logic [6:0] opcode ;
   logic [2:0] funct3;
   logic f7b5;
   
   //Control outputs
   logic RegWriteD;
   logic [1:0] ResultSrcD;
   logic MemWriteD, JumpD, BranchD;
   logic [2:0] ALUControlD;
   logic ALUSrcD = 0;
   
   //Reg File output
   logic [31:0] RD1, RD2;
   
   //extend output
   logic [31:0] ImmExtD;
   
   assign opcode[6:0] = InstrD[6:0];
   assign funct3[2:0] = InstrD[14:12];
   assign f7b5 = InstrD[30];
   
    //control
    controller contrllr( .op(InstrD[6:0]), .funct3(InstrD[14:12]), .funct7b5(InstrD[30]), .ResultSrc(ResultSrcD), .MemWrite(MemWriteD), 
                         .Branch(BranchD), .ALUSrc(ALUSrcD), .RegWrite(RegWriteD), .Jump(JumpD), .ImmSrc(ImmSrcD), .ALUControl(ALUControlD));
    //register file
    regfile registers(.clk(clk), .we3(RegWriteW), .a1(InstrD[19:15]), .a2(InstrD[24:20]), .a3(RdW), .wd3(ResultW), .rd1(RD1), .rd2(RD2));
    //extend 
    extend ex(.instr(InstrD[31:7]),.immsrc(ImmSrcD), .immext(ImmExtD));
    
    //idecode pipeline register

    Id_IE   Id_IE1(.clk(clk), .reset(reset), .RegWriteD(RegWriteD), .ResultSrcD(ResultSrcD), .MemWriteD(MemWriteD), .JumpD(JumpD), .BranchD(BranchD),
                   .ALUControlD(ALUControlD), .ALUSrcD(ALUSrcD), .RD1(RD1), .RD2(RD2), .PCD(PCD), .RdD(InstrD[11:7]), .ImmExtD(ImmExtD), .PCPlus4D(PCPlus4D), .PCE(PCE), .PCPlus4E(PCPlus4E), .RD1E(RD1E), .RD2E(RD2E), .RdE(RDE), 
                   .ImmExtE(ImmExtE), .ALUSrcE(ALUSrcE), .BranchE(BranchE), .JumpE(JumpE), .RegWriteE(RegWriteE), .MemWriteE(MemWriteE), .ResultSrcE(ResultSrcE), .ALUControlE(ALUControlE));
    
    
    /*
    initial begin
   
      $display("Time\t InstrD\t PCD\t PCPlus4D\t\t PCE\t\t PCPlus4E");
      $monitor("%0d\t\t %0d\t\t %0d\t\t %h\t %h\t %h", $time, InstrD, PCD, PCPlus4D, PCE, PCPlus4E, RegWriteE, ResultSrcE, MemWriteE,JumpE,BranchE,ALUControlE,
    ALUSrcE,RD1E,RD2E,PCD,RdD,ImmExtE);
      #210 $finish;
   end
    */
endmodule
