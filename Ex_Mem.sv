`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2022 03:37:32 PM
// Design Name: 
// Module Name: Ex_mem
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


module Ex_mem(
//input
    input logic         clk,
                        reset,
    input logic         RegWriteE,
    input logic [1:0]   ResultSrcE,
    input logic         MemWriteE,
    input logic [2:0]   ALUControlE,
    input logic         ALUSrcE,
    input logic [31:0]  ALUResultE,
    input logic [31:0]  WriteDataE,
    input logic [4:0]   RdE,
    input logic [31:0]  PCPlus4E,
//output
    output logic        RegWriteM,
    output logic [1:0]  ResultSrcM,
    output logic        MemWriteM,
    output logic [31:0] ALUResultM,
    output logic [31:0] WriteDataM,
    output logic [4:0]  RdM,
    output logic [31:0] PCPLus4M       
    );
    
    always_ff @(posedge clk, posedge reset)
    if (reset) begin
    
    RegWriteM <= 0;
    ResultSrcM <=0;
    MemWriteM <=0;
    ALUResultM <=0;
    WriteDataM <=0;
    RdM <=0;
    PCPLus4M <=0;
    
    end
	else begin
	
	RegWriteM <= RegWriteE;
    ResultSrcM <= ResultSrcE;
    MemWriteM <= MemWriteE;
    ALUResultM <= ALUResultE;
    WriteDataM <= WriteDataE;
    RdM <= RdE;
    PCPLus4M <= PCPlus4E;
    
    end
endmodule
