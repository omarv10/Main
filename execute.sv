`timescale 1ns / 1ps

module execute(
    input logic         clk, 
                        reset,
    input logic [31:0]  RD1E, 
                        RD2E, 
                        ImmExtE,
                        PCE,
                        PCPlus4E,
    input logic [4:0]   RDE,
    input logic         RegWriteE,
    input logic [1:0]   ResultSrcE,
    input logic         MemWriteE,
                        JumpE,
                        BranchE,
    input logic [2:0]   ALUControlE,
    input logic         ALUSrcE,
    
    output logic [31:0] ALUResultM,
                        WriteDataM,
    output logic [4:0]  RdM,
    output logic [31:0] PCPlus4M,
                        PCTargetE,
    output logic        MemWriteM,
    output logic [1:0]  ResultSrcM,
    output logic        RegWriteM,
                        PCSrcE
    );
    
    logic ZeroE;
    logic [31:0] SrcBE;
    
    //ALU output
    logic [31:0] ALUResultE;
    
    //mux
    mux2 mux(.d0(RD2E), .d1(ImmExtE), .s(ALUSrcE), .y(SrcBE));
    
    //PCE + ImmExtE adder
    adder PCPlusImm(.a(PCE), .b(ImmExtE), .y(PCTargetE)); // SrcAE = RD1E
    
    //ALU 
    alu ALU(.a(RD1E), .b(SrcBE), .alucontrol(ALUControlE), .result(ALUResultE), .zero(ZeroE));
    
    //IE_DM pipeline register
    Ex_mem ie_dm1(.clk(clk), .reset(reset), .RegWriteE(RegWriteE), .ResultSrcE(ResultSrcE), .MemWriteE(MemWriteE), .ALUControlE(ALUControlE), .ALUSrcE(ALUSrcE), 
                  .ALUResultE(ALUResultE), .WriteDataE(RD2E), .RdE(RDE), .PCPlus4E(PCPlus4E), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), 
                  .MemWriteM(MemWriteM), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM), .RdM(RdM), .PCPLus4M(PCPlus4M));
    
    // Jump/Branch logic
    assign PCSrcE = (JumpE | (BranchE & ZeroE));
    
endmodule