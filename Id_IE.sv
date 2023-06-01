`timescale 1ns / 1ps

module Id_IE(
    input logic         clk,
                        reset,
                        RegWriteD,
    input logic [1:0]   ResultSrcD,
    input logic         MemWriteD,
                        JumpD,
                        BranchD,
    input logic [2:0]   ALUControlD,
    input logic         ALUSrcD,
    input logic [31:0]  RD1,
                        RD2,
                        PCD,
    input logic [4:0]   RdD,
    input logic [31:0]  ImmExtD,
                        PCPlus4D,
                       
    output logic        RegWriteE,
    output logic [1:0]  ResultSrcE,
    output logic        MemWriteE,
                        JumpE,
                        BranchE,
    output logic [2:0]  ALUControlE,
    output logic        ALUSrcE,
    output logic [31:0] RD1E,
                        RD2E,
                        PCE,
    output logic [4:0]  RdE,
    output logic [31:0] ImmExtE,
                        PCPlus4E   
    );
    
    always_ff @(posedge clk, posedge reset)
    if (reset) begin
    
		RegWriteE <= 0;
		ResultSrcE <= 0;
		MemWriteE <= 0;
		JumpE <= 0;
		BranchE <= 0;
		ALUControlE <= 0; 
		ALUSrcE <= 0;
		RD1E <= 0;
		RD2E <= 0;
		PCE <= 0;
		RdE <= 0;
		ImmExtE <= 0;
		PCPlus4E <= 0;
		
	end
	else begin
	
	    RegWriteE <= RegWriteD;
		ResultSrcE <= ResultSrcD;
		MemWriteE <= MemWriteD;
		JumpE <= JumpD;
		BranchE <= BranchD;
		ALUControlE <= ALUControlD;
		ALUSrcE <= ALUSrcD;
		RD1E <= RD1;
		RD2E <= RD2;
		PCE <= PCD;
		RdE <= RdD;
		ImmExtE <= ImmExtD;
		PCPlus4E <= PCPlus4D;
	
	end
	
endmodule
