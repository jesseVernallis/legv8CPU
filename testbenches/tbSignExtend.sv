`include "headers/bus.svh"
`include "headers/sign_extend.svh"

module tbSignExtend();

 logic[`INSTRSIZE-1:0] instr;
 logic[4:0] imm_op;
 logic[`REGDATASIZE-1:0] immediate;
 
  SignExtend DUT(
  .instr(instr),
  .imm_op(imm_op),
  .immediate(immediate)
  );
 initial begin
 //B imm
 imm_op = 5'b10000;
 instr[25:0] = 0;
 instr[25] = 1;
 instr[0] = 1;
 #100ns;
 instr = 64'bx;
 //CB_imm
 imm_op = 5'b01000;
 instr[23:5] = 0;
 instr[23] = 1;
 instr[5] = 1;
 #100ns;
 instr = 64'bx;
 //I_imm
 imm_op = 5'b00100;
 instr[21:10] = 0;
 instr[21] = 1;
 instr[10] = 1;
 #100ns;
 instr = 64'bx;
 //Shift_imm
 imm_op = 5'b00010;
 instr[15:10] = 0;
 instr[15] = 1;
 instr[10] = 1;
 #100ns;
 instr = 64'bx;
 //D_imm
 imm_op = 5'b00001;
 instr[20:12] = 0;
 instr[20] = 1;
 instr[12] = 1;
 #100ns;
 instr = 64'bx;
 //NONE_imm
 imm_op = 5'b00000;
 #100ns;
 $finish();
 end
  endmodule : tbSignExtend
  