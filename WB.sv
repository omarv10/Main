`timescale 1ns / 1ps

module WB(
    input logic [31:0]  ALUResultW,
                        ReadDataW,
                        PCPlus4W,  
    input logic [1:0]   ResultSrcW,
    
    output logic [31:0] ResultW
    );
    
    mux3 mux(.d0(ALUResultW), .d1(ReadDataW), .d2(PCPlus4W), .s(ResultSrcW), .y(ResultW));
    
    //RegWriteW and RdW could be outputs but can be output from memory.sv instead?
    
endmodule
