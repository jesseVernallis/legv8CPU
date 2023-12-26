`include "headers/control.svh"
`include "headers/bus.svh"
`include "headers/aluop.svh"
`include "headers/opcode.svh"
`include "headers/sign_extend.svh"
`include "headers/branch.svh"

module ControlUnit (
input logic[`OPCODESIZE - 1:0] opcode,
output logic [`CONTROLSIZE-1:0] control,
output logic [`ALUOPSIZE-1:0] alu_op,
output logic [`BRANCHOP_SIZE-1:0] branch_op,
output logic [4:0] imm_op);
 
 //the type of opcode for this instuction
 logic op_br, op_bcond, op_bl, op_cbz, op_cbnz, op_b, 
 op_r, op_shift, op_i, op_ldur, op_stur;
 //intermediatry control signals
 logic op_branch_imm, op_ri, op_cb;
 logic [5:0] ri_upper_lower;
 
 always_comb begin
    //use mask to detrmine opcode type
 	 op_br    = opcode == `BR_BITSET;
	 op_bcond = (opcode & `BCOND_MASK) == `BCOND_BITSET;
	 op_bl    = (opcode & `BL_MASK) == `BL_BITSET;
	 op_cbz   = (opcode & `CBZ_MASK) == `CBZ_BITSET;
	 op_cbnz  = (opcode & `CBNZ_MASK) == `CBNZ_BITSET;
	 op_b     = (opcode & `B_MASK) == `B_BITSET;
	 op_r     = (opcode & `R_MASK) == `R_BITSET;
	 op_shift = (opcode & `SHIFT_MASK) == `SHIFT_BITSET;
	 op_i     = (opcode & `I_MASK) == `I_BITSET;
	 op_ldur  = (opcode & `LDUR_MASK) == `LDUR_BITSET;
	 op_stur  = (opcode & `STUR_MASK) == `STUR_BITSET;
	 
	 //takes 6 bits from opcode to determine if an r/i type instuctiom has to set flags
	 ri_upper_lower = {opcode[`OPCODESIZE-1:`OPCODESIZE-3],opcode[3:1]};
	 //if opcode is either r or i type
	 op_ri = op_r | op_i;
	 //if cbz or cbnz
	 op_cb = op_cbz | op_cbnz | op_bcond;
	 //if branch requires immediate
	 op_branch_imm =  op_bl | op_b | op_cb;
 end
 
 //set control signals
 ControlOp ControlOp(
	.ri_upper_lower(ri_upper_lower),
	.op_cb(op_cb),
	.op_bl(op_bl),
	.op_ri(op_ri),
	.op_i(op_i),
	.op_ldur(op_ldur),
	.op_stur(op_stur),
	.op_shift(op_shift),
	.op_branch_imm(op_branch_imm),
	.control(control)
 );
  //set aluop signals
  AluControlOp AluControlOp(
	.ri_upper_lower(ri_upper_lower),
	.op_ri(op_ri),
	.op_shift(op_shift),
	.shift_dir(opcode[0]),
	.alu_op(alu_op)
 );
 //set branch op signals
 BranchOp BranchOp(
 .op_b(op_b),
 .op_br(op_br),
 .op_bl(op_bl),
 .op_cbz(op_cbz),
 .op_cbnz(op_cbnz),
 .op_bcond(op_bcond),
 .branch_op(branch_op)
 );  
 //set immediate op signals
 ImmOp ImmOp(
 .op_branch_imm(op_branch_imm),
 .op_cb(op_cb),
 .op_i(op_i),
 .op_shift(op_shift),
 .op_ldur(op_ldur),
 .op_stur(op_stur),
 .imm_op(imm_op)
 );
endmodule : ControlUnit

/*********************************************************

					CHILD MODULE DECLARATIONS

*********************************************************/
					
//module to determine control signals based of opcode type
module ControlOp(
input logic[5:0] ri_upper_lower,
input logic op_cb,
op_bl, 
op_ri, 
op_i, 
op_ldur, 
op_stur, 
op_shift,
op_branch_imm,
output logic [`CONTROLSIZE - 1:0] control);

 logic setflags;

 always_comb begin
	//determine if r type that must set flags
	case(ri_upper_lower)
	 `ANDS   : setflags = 1'b1; 
	 `ADDS   : setflags = 1'b1;
	 `SUBS   : setflags = 1'b1;
	 default : setflags = 1'b0; 
	endcase

	
	 
	//op type used to set control signals
	control[`REG1ZERO] = op_cb;
	control[`REG2LOC]  = op_cb | op_ldur | op_stur;
	control[`ALUSRC]   = op_ldur | op_stur | op_i | op_branch_imm | op_shift;
	control[`SETFLAGS] = (op_ri & setflags) | op_cb;
	control[`MEMREAD]  = op_ldur;
	control[`MEMWRITE] = op_bl;
	control[`MEMTOREG] = op_stur;
	control[`PCTOREG]  = op_ldur;
	control[`REGWRITE] = op_bl | op_ldur | op_ri | op_shift;
 end
endmodule : ControlOp

//module to determine aluop signals based of opcode type
module AluControlOp(
input logic[5:0] ri_upper_lower,
input logic shift_dir,
op_shift,
op_ri,
output logic [`ALUOPSIZE - 1:0] alu_op
);

 always_comb begin
	//invert 2nd reg bit(for subtraction)
	casex(ri_upper_lower)
		6'b11x100  : alu_op[4] = 1'b1;
		default : alu_op[4] = 1'b0;
   endcase
	//shift bits alu op
	alu_op[3] = op_shift & shift_dir;
	alu_op[2] = op_shift;
	
	case(op_ri)
	1'b1 : begin
		case(ri_upper_lower)
			6'b10_0000 : alu_op[1:0] = `ALUCTRL_AND;//AND,ANDS,ANDI,ANDIS
	      6'b10_1000 : alu_op[1:0] = `ALUCTRL_ORR;//ORR,ORRS,ORRI,ORRIS
	      6'b11_0000 : alu_op[1:0] = `ALUCTRL_XOR;//XOR,XORS,XORI,XORIS
			default    : alu_op[1:0] = `ALUCTRL_ADD;//ADD,ADDS,ADDI,ADDIS
		endcase
	end
	//all branches, adds, subs, etc use aluCTRL_ADD
	1'b0 : alu_op[1:0] = `ALUCTRL_ADD;
	endcase
	
 end
endmodule : AluControlOp
//moduel to determine branch_op, 
//signals merge into one hot encoded array
module BranchOp(
input logic op_b,
op_br,
op_bl,
op_cbz,
op_cbnz,
op_bcond,
output logic [`BRANCHOP_SIZE-1:0] branch_op
);  

 always_comb begin
	//one hot encoded brach control signal
	branch_op[`BRANCHCTRL_B]     = op_b; 
	branch_op[`BRANCHCTRL_BR]    = op_br; 
	branch_op[`BRANCHCTRL_BL]    = op_bl; 
	branch_op[`BRANCHCTRL_CBZ]   = op_cbz; 
	branch_op[`BRANCHCTRL_CBNZ]  = op_cbnz; 
	branch_op[`BRANCHCTRL_BCOND] = op_bcond; 
	//BRANCH_NONE implied for no braching instuction
 end
endmodule : BranchOp

//moduel to determine imm_op
//signals merge into one hot encoded array
module ImmOp(input logic op_branch_imm,
op_cb,
op_i,
op_shift,
op_ldur,
op_stur,
output logic [4:0] imm_op);

 logic op_d;
 always_comb begin
	 //determines if instuction is data type
	 op_d = op_ldur | op_stur;
	 //one hot encoded immediate control signal
	 imm_op[`IMMCTRL_B]     = op_branch_imm & (~op_cb);
	 imm_op[`IMMCTRL_CB]    = op_cb;
	 imm_op[`IMMCTRL_I]     = op_i;
	 imm_op[`IMMCTRL_SHIFT] = op_shift;
	 imm_op[`IMMCTRL_D]     = op_d;
	 //no immediate required implied for instuctions
	 //that do not require immediates
 end
endmodule : ImmOp