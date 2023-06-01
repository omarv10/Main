module maindec(input  logic [6:0] op,
               output logic [1:0] ResultSrc,
               output logic       MemWrite,
               output logic       Branch, ALUSrc,
               output logic       RegWrite, Jump,
               output logic [1:0] ImmSrc,
               output logic [1:0] ALUOp);

  logic [10:0] controls;

  //assining the control signals values form the control
  assign RegWrite = controls[10];
  assign ImmSrc = controls[9:8];
  assign ALUSrc = controls[7];
  assign MemWrite = controls[6];
  assign ResultSrc = controls[5:4];
  assign Branch = controls[3];
  assign ALUOp = controls[2:1];
  assign Jump = controls[0];

  always_comb
    case(op)
    // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump
      7'b0000011: controls = 11'b10010010000; // lw
      7'b0100011: controls = 11'b00111xx0000; // sw
      7'b0110011: controls = 11'b1xx00000100; // R-type 
      7'b1100011: controls = 11'b01000xx1010; // beq
      7'b0010011: controls = 11'b10010000100; // I-type ALU
      7'b1101111: controls = 11'b111x0100xx1; // jal
      default:    controls = 11'bxxxxxxxxxxx; // non-implemented instruction
    endcase
endmodule