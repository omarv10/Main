`timescale 1ns / 1ps

module memory(
    input logic         clk,
                        reset,
    input logic [31:0]  ALUResultM,
                        WriteDataM,
                        PCPlus4M,
    input logic [4:0]   RdM,
    input logic         RegWriteM,
                        MemWriteM,
    input logic [1:0]   ResultSrcM,     
    
    output logic [31:0] ALUResultW,
                        ReadDataW,
                        PCPlus4W,
    output logic [4:0]  RdW,
    output logic        RegWriteW,
    output logic [1:0]  ResultSrcW       
    );
    
    //dmem ouput
    logic [31:0] RD;
    
    //Data Memory
    dmem dmem1(.clk(clk), .we(MemWriteM), .a(ALUResultM), .wd(WriteDataM), .rd(RD));
    
    //IM_WB
    dm_wb dm_wb1(.clk(clk), .reset(reset), .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .ALUResultM(ALUResultM), .ReadDataM(RD),
                 .RdM(RdM), .PCPlus4M(PCPlus4M), .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW), .ALUResultW(ALUResultW), 
                 .ReadDataW(ReadDataW), .RdW(RdW), .PCPlus4W(PCPlus4W));

endmodule
