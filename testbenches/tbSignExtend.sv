`include "headers/bus.svh"
`include "headers/sign_extend.svh"

module tbSignExtend();

 logic[`INSTSIZE-1:0] inst;
 logic[4:0] imm_op;
 logic[`REGDATASIZE-1:0] immediate;
 
  SignExtend DUT(
  .inst(inst),
  .imm_op(imm_op),
  .immediate(immediate)
  );
 initial begin
 //B imm
 imm_op = 5'b10000;
 inst[25:0] = 0;
 inst[25] = 1;
 inst[0] = 1;
 #100ns;
 inst = 64'bx;
 //CB_imm
 imm_op = 5'b01000;
 inst[23:5] = 0;
 inst[23] = 1;
 inst[5] = 1;
 #100ns;
 inst = 64'bx;
 //I_imm
 imm_op = 5'b00100;
 inst[21:10] = 0;
 inst[21] = 1;
 inst[10] = 1;
 #100ns;
 inst = 64'bx;
 //Shift_imm
 imm_op = 5'b00010;
 inst[15:10] = 0;
 inst[15] = 1;
 inst[10] = 1;
 #100ns;
 inst = 64'bx;
 //D_imm
 imm_op = 5'b00001;
 inst[20:12] = 0;
 inst[20] = 1;
 inst[12] = 1;
 #100ns;
 inst = 64'bx;
 //NONE_imm
 imm_op = 5'b00000;
 #100ns;
 $finish();
 end
  endmodule : tbSignExtend
  