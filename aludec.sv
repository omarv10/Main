module aludec(input  logic       opb5,
              input  logic [2:0] funct3,
              input  logic       funct7b5, 
              input  logic [1:0] ALUOp,
              output logic [2:0] ALUControl);

  logic  RtypeSub;
  assign RtypeSub = funct7b5 & opb5;  // TRUE for R-type subtract instruction

  always_comb
    case(ALUOp)
     // add the logic here 
     2'b00 : 
        ALUControl = 3'b000;
     2'b01 : 
        ALUControl = 3'b001;
     2'b10 : begin
        if (funct3 == 3'b000 & RtypeSub < 1)
            ALUControl = 3'b000;
        else if (funct3 == 3'b000 & RtypeSub > 0)
            ALUControl = 3'b001;
        else if(funct3== 3'b010)
            ALUControl = 3'b101;
        else if(funct3 == 3'b110)
            ALUControl = 3'b011;
        else //(funct3 == 3'b111)
            ALUControl = 3'b010;
     end     
    endcase
endmodule
